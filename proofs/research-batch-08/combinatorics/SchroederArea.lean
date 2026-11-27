import Mathlib.Data.Nat.Basic
import Mathlib.Tactic.Linarith

namespace SchroederArea

inductive Site where
  | even (u : ℕ)
  | odd (u : ℕ)

/-- Raw walks in the Pascal triangle, with the odd/even height explicit. -/
inductive Fine : Site → Site → Type where
  | stop (h) : Fine h h
  | upEven {u d} (p : Fine (.odd u) d) : Fine (.even u) d
  | upOdd {u d} (p : Fine (.even (u+1)) d) : Fine (.odd u) d
  | short {u d} (p : Fine (.even u) d) : Fine (.odd u) d
  | long {u d} (p : Fine (.odd u) d) : Fine (.odd (u+1)) d

/-- A nonnegative Schröder path, indexed by its two endpoint heights. -/
inductive Path : ℕ → ℕ → Type where
  | stop (u) : Path u u
  | up {u v} (p : Path (u+1) v) : Path u v
  | flat {u v} (p : Path u v) : Path u v
  | down {u v} (p : Path u v) : Path (u+1) v

def expand : {u v : ℕ} → Path u v → Fine (.odd u) (.odd v)
  | _,_,.stop u => .stop (.odd u)
  | _,_,.up p => .upOdd (.upEven (expand p))
  | _,_,.flat p => .short (.upEven (expand p))
  | _,_,.down p => .long (expand p)

def compress : {u v : ℕ} → Fine (.odd u) (.odd v) → Path u v
  | _,_,.stop (.odd u) => .stop u
  | _,_,.upOdd (.upEven p) => .up (compress p)
  | _,_,.short (.upEven p) => .flat (compress p)
  | _,_,.long p => .down (compress p)

theorem compress_expand {u v} (p : Path u v) : compress (expand p)=p := by
  induction p <;> simp [expand, compress, *]

theorem expand_compress : {u v : ℕ} → (p : Fine (.odd u) (.odd v)) → expand (compress p)=p
  | _,_,.stop (.odd _) => by simp [expand,compress]
  | _,_,.upOdd (.upEven p) => by simp [compress,expand,expand_compress p]
  | _,_,.short (.upEven p) => by simp [compress,expand,expand_compress p]
  | _,_,.long p => by simp [compress,expand,expand_compress p]

/-- (number of descents, sum of landing heights). -/
def fineStats {h d} : Fine h d → ℕ × ℕ
  | .stop _ => (0,0)
  | .upEven p => fineStats p
  | .upOdd p => fineStats p
  | .short (u:=u) p => (1+(fineStats p).1, 2*u+(fineStats p).2)
  | .long (u:=u) p => (1+(fineStats p).1, (2*u+1)+(fineStats p).2)

/-- (number of flat and down steps, total area with up-steps charged to matched descents). -/
def pathStats {u v} : Path u v → ℕ × ℕ
  | .stop _ => (0,0)
  | .up p => pathStats p
  | .flat (u:=h) p => (1+(pathStats p).1, 2*h+(pathStats p).2)
  | .down (u:=h) p => (1+(pathStats p).1, (2*h+1)+(pathStats p).2)

theorem preserves_stats {u v} (p : Path u v) : fineStats (expand p)=pathStats p := by
  induction p <;> simp [expand, fineStats, pathStats, *]

/-- Inner walks with the final descent to zero still present. Adding the
    initial forced up-step gives a nonempty walk from even zero to itself. -/
def closePath : {u : ℕ} → Path u 0 → Fine (.odd u) (.even 0)
  | _,.stop 0 => .short (.stop (.even 0))
  | _,.up p => .upOdd (.upEven (closePath p))
  | _,.flat p => .short (.upEven (closePath p))
  | _,.down p => .long (closePath p)

def openPath : {u : ℕ} → Fine (.odd u) (.even 0) → Path u 0
  | _,.upOdd (.upEven p) => .up (openPath p)
  | _,.short (.stop (.even 0)) => .stop 0
  | _,.short (.upEven p) => .flat (openPath p)
  | _,.long p => .down (openPath p)

theorem open_close : {u : ℕ} → (p : Path u 0) → openPath (closePath p) = p
  | _,.stop 0 => by simp [closePath,openPath]
  | _,.up p => by simp [closePath,openPath,open_close p]
  | _,.flat p => by simp [closePath,openPath,open_close p]
  | _,.down p => by simp [closePath,openPath,open_close p]

theorem close_open : {u : ℕ} → (p : Fine (.odd u) (.even 0)) → closePath (openPath p)=p
  | _,.upOdd (.upEven p) => by simp [closePath,openPath,close_open p]
  | _,.short (.stop (.even 0)) => by simp [closePath,openPath]
  | _,.short (.upEven p) => by simp [closePath,openPath,close_open p]
  | _,.long p => by simp [closePath,openPath,close_open p]

theorem closed_stats : {u : ℕ} → (p : Path u 0) →
    fineStats (closePath p)=((pathStats p).1+1,(pathStats p).2)
  | _,.stop 0 => by simp [closePath,fineStats,pathStats]
  | _,.up p => by simp [closePath,fineStats,pathStats,closed_stats p]
  | _,.flat p => by simp [closePath,fineStats,pathStats,closed_stats p,Nat.add_assoc]
  | _,.down p => by simp [closePath,fineStats,pathStats,closed_stats p,Nat.add_assoc]

/-- Horizontal span and twice the geometric area, obtained one trapezoid at a time. -/
def geometry {u v} : Path u v → ℕ × ℕ
  | .stop _ => (0,0)
  | .up (u:=h) p => (1+(geometry p).1,2*h+1+(geometry p).2)
  | .flat (u:=h) p => (2+(geometry p).1,4*h+(geometry p).2)
  | .down (u:=h) p => (1+(geometry p).1,2*h+1+(geometry p).2)

theorem path_geometry {u v} (p : Path u v) :
    (geometry p).1+u=2*(pathStats p).1+v ∧
    (geometry p).2+u^2=2*(pathStats p).2+v^2 := by
  induction p with
  | stop h => simp [geometry,pathStats]
  | up p ih => obtain ⟨ha,hb⟩ := ih; simp [geometry,pathStats]; constructor <;> nlinarith
  | flat p ih => obtain ⟨ha,hb⟩ := ih; simp [geometry,pathStats]; constructor <;> nlinarith
  | down p ih => obtain ⟨ha,hb⟩ := ih; simp [geometry,pathStats]; constructor <;> nlinarith

theorem excursion_geometry (p : Path 0 0) :
    (geometry p).1 = 2*(pathStats p).1 ∧ (geometry p).2 = 2*(pathStats p).2 := by
  simpa using path_geometry p

end SchroederArea

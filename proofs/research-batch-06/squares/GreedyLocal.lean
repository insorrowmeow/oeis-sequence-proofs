import Mathlib.Data.Nat.Basic
import Mathlib.Tactic.Ring
import Mathlib.Tactic.NormNum

namespace GreedySquares

/-- The exceptional integers in Legendre's three-square theorem. -/
def needsFour (n : ℕ) : Prop := ∃ e h : ℕ, n = 4^e * (8*h+7)

theorem scale (n : ℕ) : needsFour (4*n) ↔ needsFour n := by
  constructor
  · rintro ⟨e, h, H⟩
    cases e with
    | zero => simp at H; omega
    | succ e =>
      refine ⟨e,h, ?_⟩
      rw [pow_succ] at H
      rw [show 4^e*4*(8*h+7) = 4*(4^e*(8*h+7)) by ring] at H
      omega
  · rintro ⟨e,h,rfl⟩
    exact ⟨e+1,h,by rw [pow_succ]; ring⟩

theorem primitive_test {n : ℕ} (hn : n%8 ≠ 0) :
    needsFour n ↔ n%8 = 7 ∨ n%32 = 28 := by
  constructor
  · rintro ⟨e,h,H⟩
    match e with
    | 0 => simp at H; omega
    | 1 => norm_num at H; omega
    | e+2 =>
      have H' : n = 16 * (4^e*(8*h+7)) := by rw [H,pow_add]; ring
      omega
  · rintro (h|h)
    · exact ⟨0,n/8,by simp; omega⟩
    · exact ⟨1,n/32,by norm_num; omega⟩

def sqSum (a b c d : ℕ) : ℕ := a*a + b*b + c*c + d*d

private theorem small_primitive : ∀ a b c d : Fin 4,
    (a.val%2=1 ∨ b.val%2=1 ∨ c.val%2=1 ∨ d.val%2=1) →
    sqSum a b c d % 8 ≠ 0 := by decide

private theorem square_mod (a : ℕ) : a*a % 8 = ((a%4)*(a%4))%8 := by
  have h : 4*(a/4)+a%4 = a := by omega
  have he : a*a = 8*(2*(a/4)^2+(a/4)*(a%4)) + (a%4)*(a%4) := by
    calc
      a*a = (4*(a/4)+a%4)*(4*(a/4)+a%4) := by rw [h]
      _ = _ := by ring
  omega

theorem primitive_quadruple (a b c d : ℕ)
    (hp : a%2=1 ∨ b%2=1 ∨ c%2=1 ∨ d%2=1) :
    needsFour (sqSum a b c d) ↔ sqSum a b c d %8 = 7 ∨ sqSum a b c d %32 = 28 := by
  apply primitive_test
  have h := small_primitive ⟨a%4,by omega⟩ ⟨b%4,by omega⟩ ⟨c%4,by omega⟩ ⟨d%4,by omega⟩
  simp only at h
  have h' := h (by omega)
  simp only [sqSum] at *
  have ha := square_mod a
  have hb := square_mod b
  have hc := square_mod c
  have hd := square_mod d
  omega

/-- Counts ordered pairs of residues modulo 16 with a given square sum modulo 32. -/
def pairs (xs : List ℕ) (r : ℕ) : ℕ :=
  (xs.map fun a => (xs.filter fun b => (a*a+b*b)%32 = r).length).sum

/-- Convolve the pair histogram with itself to count ordered quadruples. -/
def count (xs : List ℕ) (accept : ℕ → Bool) : ℕ :=
  let bins := (List.range 32).map fun r => (r, pairs xs r)
  (bins.map fun p => (bins.map fun q =>
    if accept ((p.1+q.1)%32) then p.2*q.2 else 0).sum).sum

def allRoots := List.range 16
def evenRoots := allRoots.filter (fun a => a%2=0)
def localTest (v : ℕ) := decide (v%8=7 ∨ v=28)

set_option maxRecDepth 100000 in
set_option maxHeartbeats 4000000 in
theorem local_counts :
    count allRoots localTest - count evenRoots localTest = 9216 ∧
    allRoots.length^4 - evenRoots.length^4 = 61440 := by decide

theorem primitive_fraction : 9216*20 = 3*61440 := by decide

#print axioms primitive_quadruple
#print axioms local_counts
end GreedySquares

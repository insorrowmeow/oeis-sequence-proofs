import Std

namespace Tetrastix

/-- Integer displacements from the original vertex (1,0,0). -/
structure Point where
  x : Int
  y : Int
  z : Int
deriving DecidableEq

def origin : Point := ⟨0,0,0⟩

def Valid (p : Point) : Prop :=
  (p.x+1) % 2 ≠ p.y % 2 ∨ p.y % 2 ≠ p.z % 2

def Neighbor (p q : Point) : Prop :=
  (p.y=q.y ∧ p.z=q.z ∧ (p.x=q.x+1 ∨ p.x=q.x-1)) ∨
  (p.x=q.x ∧ p.z=q.z ∧ (p.y=q.y+1 ∨ p.y=q.y-1)) ∨
  (p.x=q.x ∧ p.y=q.y ∧ (p.z=q.z+1 ∨ p.z=q.z-1))

private def extra (x y z : Int) : Nat :=
  if x ≠ 0 ∧ y = 0 ∧ z = 0 then 2 else 0

def distance (p : Point) : Nat :=
  p.x.natAbs + p.y.natAbs + p.z.natAbs + extra p.x p.y p.z

inductive Walk : Point → Nat → Prop
  | start : Walk origin 0
  | extend {p q : Point} {n : Nat} : Walk p n → Neighbor q p → Valid q → Walk q (n+1)

private theorem magnitude (x : Int) :
    (x.natAbs : Int) = (if x < 0 then -x else x) := by
  split
  · exact Int.ofNat_natAbs_of_nonpos (by omega)
  · exact Int.natAbs_of_nonneg (by omega)

private theorem adjacent_magnitude {x y : Int} (h : x=y+1 ∨ x=y-1) :
    x.natAbs ≤ y.natAbs + 1 := by
  have hx := magnitude x
  have hy := magnitude y
  split at hx <;> split at hy <;> omega

private theorem at_origin {p : Point} (h : distance p = 0) : p = origin := by
  rcases p with ⟨x,y,z⟩
  change x.natAbs + y.natAbs + z.natAbs + _ = 0 at h
  have hx : x.natAbs = 0 := by omega
  have hy : y.natAbs = 0 := by omega
  have hz : z.natAbs = 0 := by omega
  simp only [Int.natAbs_eq_zero] at hx hy hz
  simp [origin, hx, hy, hz]

private theorem lipschitz {p q : Point} (hp : Valid p) (hq : Valid q) (adj : Neighbor q p) :
    distance q ≤ distance p + 1 := by
  rcases p with ⟨x,y,z⟩
  rcases q with ⟨u,v,w⟩
  simp only [Valid] at hp hq
  simp only [Neighbor] at adj
  simp only [distance]
  rcases adj with ⟨rfl,rfl,h⟩ | ⟨rfl,rfl,h⟩ | ⟨rfl,rfl,h⟩
  all_goals
    have hd := adjacent_magnitude h
    unfold extra
    split <;> split
    all_goals first | omega | (simp_all <;> omega)

private theorem valid_of_walk {p n} (h : Walk p n) : Valid p := by
  cases h with
  | start => unfold Valid origin; decide
  | extend _ _ h => exact h

theorem lower_bound {p n} (h : Walk p n) : distance p ≤ n := by
  induction h with
  | start => decide +kernel
  | extend path adj valid ih =>
    have := lipschitz (valid_of_walk path) valid adj
    omega

private def toward (u : Int) : Int := if u < 0 then u+1 else u-1

private theorem toward_length {u : Int} (hu : u ≠ 0) : (toward u).natAbs + 1 = u.natAbs := by
  have ha := magnitude u
  have hb := magnitude (toward u)
  unfold toward at *
  split at ha <;> simp_all <;> split at hb <;> omega

private theorem toward_move (u : Int) : u=toward u+1 ∨ u=toward u-1 := by
  unfold toward
  split <;> omega

private theorem predecessor {p : Point} (hp : Valid p) (nonzero : p ≠ origin) :
    ∃ q, Neighbor p q ∧ Valid q ∧ distance q + 1 = distance p := by
  rcases p with ⟨x,y,z⟩
  change (x+1)%2 ≠ y%2 ∨ y%2 ≠ z%2 at hp
  have nz : x ≠ 0 ∨ y ≠ 0 ∨ z ≠ 0 := by
    apply Classical.byContradiction; intro h
    apply nonzero
    have hx : x=0 := by omega
    have hy : y=0 := by omega
    have hz : z=0 := by omega
    simp [origin, hx, hy, hz]
  by_cases axis : y=0 ∧ z=0
  · obtain ⟨rfl,rfl⟩ := axis
    have hx : x ≠ 0 := by omega
    refine ⟨⟨x,1,0⟩, Or.inr (Or.inl ⟨rfl,rfl,by dsimp; decide⟩), Or.inr (by dsimp; decide), ?_⟩
    simp [distance, extra, hx]
  by_cases mx : x ≠ 0 ∧ y%2 ≠ z%2
  · refine ⟨⟨toward x,y,z⟩, Or.inl ⟨rfl,rfl,toward_move x⟩, Or.inr mx.2, ?_⟩
    have len := toward_length mx.1
    simp only [distance, extra]
    split <;> split <;> omega
  by_cases my : y ≠ 0 ∧ (x+1)%2 ≠ z%2 ∧ (x=0 ∨ toward y ≠ 0 ∨ z≠0)
  · refine ⟨⟨x,toward y,z⟩, Or.inr (Or.inl ⟨rfl,rfl,toward_move y⟩), ?_, ?_⟩
    · unfold Valid
      dsimp only
      omega
    · have len := toward_length my.1
      simp only [distance, extra]
      split <;> split <;> omega
  have mz : z ≠ 0 ∧ (x+1)%2 ≠ y%2 ∧ (x=0 ∨ y≠0 ∨ toward z ≠ 0) := by
    unfold toward at my ⊢
    split at my <;> split <;> omega
  refine ⟨⟨x,y,toward z⟩, Or.inr (Or.inr ⟨rfl,rfl,toward_move z⟩), Or.inl mz.2.1, ?_⟩
  have len := toward_length mz.1
  simp only [distance, extra]
  split <;> split <;> omega

theorem shortest_walk {p : Point} (hp : Valid p) : Walk p (distance p) := by
  generalize hd : distance p = d
  induction d using Nat.strongRecOn generalizing p with
  | ind d ih =>
    by_cases zero : d=0
    · have pp := at_origin (hd.trans zero)
      subst p
      rw [zero]
      exact .start
    have nz : p ≠ origin := by
      intro pp
      subst p
      have hzero : distance origin = 0 := by decide
      omega
    obtain ⟨q, adj, valid, step⟩ := predecessor hp nz
    have walk := ih (distance q) (by omega) valid rfl
    have extension := Walk.extend walk adj hp
    rw [step, hd] at extension
    exact extension

/-- A walk with the stated length exists, and every walk to the target is at least this long. -/
theorem exact_distance (p : Point) (valid : Valid p) :
    Walk p (distance p) ∧ ∀ n, Walk p n → distance p ≤ n :=
  ⟨shortest_walk valid, fun _ h => lower_bound h⟩

end Tetrastix

#print axioms Tetrastix.exact_distance

import Mathlib.Data.Nat.Basic

namespace SixPhaseOrbit

/-- Both subtractions are natural, so their sum is the absolute difference. -/
def step (n prev : ℕ) : ℕ :=
  if prev % 2 = 1 then prev + n else ((prev-n) + (n-prev)) / 2

def orbit : ℕ → ℕ
  | 0 => 0
  | 1 => 1
  | n+2 => step (n+2) (orbit (n+1))

private theorem next (n : ℕ) (hn : 1 ≤ n) : orbit (n+1) = step (n+1) (orbit n) := by
  cases n <;> first | omega | rfl

private theorem block (q : ℕ) (h : orbit (6*q+6) = 2*q) :
    orbit (6*q+7) = 2*q+3 ∧ orbit (6*q+8) = 8*q+11 ∧
    orbit (6*q+9) = 14*q+20 ∧ orbit (6*q+10) = 4*q+5 ∧
    orbit (6*q+11) = 10*q+16 ∧ orbit (6*q+12) = 2*q+2 := by
  have v1 : orbit (6*q+7) = 2*q+3 := by
    rw [show 6*q+7 = (6*q+6)+1 by omega, next _ (by omega), h]
    unfold step
    split <;> omega
  have v2 : orbit (6*q+8) = 8*q+11 := by
    rw [show 6*q+8 = (6*q+7)+1 by omega, next _ (by omega), v1]
    unfold step
    split <;> omega
  have v3 : orbit (6*q+9) = 14*q+20 := by
    rw [show 6*q+9 = (6*q+8)+1 by omega, next _ (by omega), v2]
    unfold step
    split <;> omega
  have v4 : orbit (6*q+10) = 4*q+5 := by
    rw [show 6*q+10 = (6*q+9)+1 by omega, next _ (by omega), v3]
    unfold step
    split <;> omega
  have v5 : orbit (6*q+11) = 10*q+16 := by
    rw [show 6*q+11 = (6*q+10)+1 by omega, next _ (by omega), v4]
    unfold step
    split <;> omega
  have v6 : orbit (6*q+12) = 2*q+2 := by
    rw [show 6*q+12 = (6*q+11)+1 by omega, next _ (by omega), v5]
    unfold step
    split <;> omega
  exact ⟨v1,v2,v3,v4,v5,v6⟩

theorem closed_form (q : ℕ) :
    orbit (6*q+6) = 2*q ∧ orbit (6*q+7) = 2*q+3 ∧
    orbit (6*q+8) = 8*q+11 ∧ orbit (6*q+9) = 14*q+20 ∧
    orbit (6*q+10) = 4*q+5 ∧ orbit (6*q+11) = 10*q+16 := by
  have hzero (j : ℕ) : orbit (6*j+6) = 2*j := by
    induction j with
    | zero => decide
    | succ j ih =>
      have hx := (block j ih).2.2.2.2.2
      simpa only [Nat.mul_succ, Nat.add_assoc] using hx
  obtain ⟨h1,h2,h3,h4,h5,_⟩ := block q (hzero q)
  exact ⟨hzero q,h1,h2,h3,h4,h5⟩

/-- The OEIS bounds on a(n)/n, cleared of denominators. -/
theorem ratio_bounds (n : ℕ) (hn : 10 ≤ n) : n ≤ 6 * orbit n ∧ 3 * orbit n < 7*n := by
  let q := (n-6)/6
  have hq : 6*q+6 ≤ n ∧ n ≤ 6*q+11 := by dsimp [q]; omega
  obtain ⟨h0,h1,h2,h3,h4,h5⟩ := closed_form q
  rcases (show n=6*q+6 ∨ n=6*q+7 ∨ n=6*q+8 ∨ n=6*q+9 ∨ n=6*q+10 ∨ n=6*q+11 by omega)
    with h|h|h|h|h|h <;> rw [h] <;> omega

theorem lower_attained : 6 * orbit 12 = 12 := by decide

theorem upper_approached (q : ℕ) : 3*orbit (6*q+9)+3 = 7*(6*q+9) := by
  have hv := (closed_form q).2.2.2.1
  omega

end SixPhaseOrbit

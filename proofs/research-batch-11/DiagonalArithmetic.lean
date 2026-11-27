import Mathlib.Data.Nat.Multiplicity
import Mathlib.NumberTheory.Padics.PadicVal.Defs

namespace DiagonalArithmetic

/-- The odd factor above (2r)! contributes no power of two. -/
theorem odd_factorial_bound (r : ℕ) (hr : 0 < r) :
    padicValNat 2 ((2*r+1).factorial) < 2*r := by
  have h : emultiplicity 2 ((2*r+1).factorial) < (2*r : ℕ) := by
    rw [Nat.factorial_succ, Nat.prime_two.emultiplicity_mul,
      emultiplicity_eq_zero.2 (Nat.two_not_dvd_two_mul_add_one r), zero_add]
    exact Nat.emultiplicity_two_factorial_lt (by omega)
  rw [← padicValNat_eq_emultiplicity (p := 2) (Nat.factorial_pos _)] at h
  exact_mod_cast h

private theorem choose_two_step (n : ℕ) :
    (n+1).choose 2 = n + n.choose 2 := by
  rw [Nat.choose_succ_succ' n 1, Nat.choose_one_right]

private theorem twice_step (n : ℕ) :
    (n+2).choose 2 = n.choose 2 + 2*n + 1 := by
  rw [show n+2 = n+1+1 by omega, choose_two_step, choose_two_step]
  omega

/-- The factorial denominator in the differentiated central-difference equation
costs at most the gain in the triangular exponent. -/
theorem diagonal_valuation_budget (k r : ℕ) (hk : 0 < k) (hr : 0 < r) :
    k.choose 2 + 2*r + padicValNat 2 ((2*r+1).factorial) ≤
      (k+2*r).choose 2 := by
  have hval := odd_factorial_bound r hr
  obtain ⟨s, rfl⟩ := Nat.exists_eq_succ_of_ne_zero hr.ne'
  simp only [Nat.succ_eq_add_one] at hval ⊢
  suffices k.choose 2 + 4*s + 3 ≤ (k+2*(s+1)).choose 2 by omega
  clear hval hr
  induction s with
  | zero =>
    change k.choose 2 + 0 + 3 ≤ (k+2).choose 2
    rw [twice_step]
    omega
  | succ s ih =>
    rw [show k+2*(s+1+1) = (k+2*(s+1))+2 by omega, twice_step]
    omega

end DiagonalArithmetic

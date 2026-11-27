import Mathlib.Algebra.Polynomial.Derivative
import Mathlib.Tactic.Ring
import Mathlib.Tactic.NormNum

namespace Frohlich
open Polynomial

noncomputable def q (R : Type*) [Semiring R] : Polynomial R := X^2+X+1
noncomputable def central (n : ℕ) : ℕ := (q ℕ ^ n).coeff n

private theorem central_int (n : ℕ) :
    (central n : ℤ) = (q ℤ ^ n).coeff n := by
  change (Nat.castRingHom ℤ) ((q ℕ ^ n).coeff n) = _
  rw [← Polynomial.coeff_map]
  simp [q]

-- Extracting the middle coefficient of X H' - (n+2) H gives zero.
theorem central_recurrence (n : ℕ) :
    (n+2)*central (n+2) = (2*n+3)*central (n+1) + 3*(n+1)*central n := by
  let Q := q ℤ
  let H := (X^2-1)*Q^(n+1)
  have certificate :
      C (n+2 : ℤ)*Q^(n+2) - C (2*n+3 : ℤ)*(X*Q^(n+1)) -
        C (3*(n+1) : ℤ)*(X*(X*Q^n)) =
      X * derivative H - C (n+2 : ℤ)*H := by
    dsimp only [H]
    rw [derivative_mul, derivative_pow_succ]
    have hQ : derivative Q = 2*X+1 := by simp [Q, q, derivative_sq]
    rw [hQ, derivative_sub, derivative_sq]
    simp only [derivative_X, derivative_one, mul_one, sub_zero, pow_succ Q,
      map_add, map_mul, map_ofNat, map_one]
    dsimp only [Q, q]
    ring
  have hc := congrArg (fun f : Polynomial ℤ => f.coeff (n+2)) certificate
  simp only [coeff_sub, coeff_C_mul, coeff_X_mul, coeff_derivative] at hc
  zify
  repeat rw [central_int]
  dsimp only [Q] at hc
  push_cast at hc
  linarith

private theorem value0 : central 0 = 1 := by simp [central]
private theorem value1 : central 1 = 1 := by simp [central, q, coeff_one]

/-- Advance from (T_i,T_(i+1)) to the desired index using exact integer division. -/
def advance : ℕ → ℕ → ℕ → ℕ → ℕ
  | 0, _, a, _ => a
  | k+1, i, a, b => advance k (i+1) b (((2*i+3)*b + 3*(i+1)*a)/(i+2))

theorem advance_central (k i : ℕ) :
    advance k i (central i) (central (i+1)) = central (i+k) := by
  induction k generalizing i with
  | zero => simp [advance]
  | succ k ih =>
    rw [advance, ← central_recurrence, Nat.mul_div_cancel_left _ (by omega)]
    simpa [Nat.add_assoc, Nat.add_comm, Nat.add_left_comm] using ih (i+1)

theorem central_eval (n : ℕ) : central n = advance n 0 1 1 := by
  simpa only [value0, Nat.zero_add, value1] using (advance_central n 0).symm

#print axioms central_eval

end Frohlich

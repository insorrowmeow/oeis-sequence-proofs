import Mathlib.RingTheory.PowerSeries.Derivative
import Mathlib.Tactic.Ring
import Mathlib.Tactic.LinearCombination
import Mathlib.Tactic.NormNum

open PowerSeries
open scoped PowerSeries

namespace RowRecurrence

abbrev S := PowerSeries ℚ
local notation "z" => (X : S)
local notation "D" => PowerSeries.derivative ℚ
noncomputable section

/-- Cleared radical equation of the three-periodic Stieltjes fraction (t,1,-1). -/
def Source (t : ℚ) (F : S) : Prop :=
  let u := C ℚ t
  (2*z*(1-u*z)*F-((u+2)*z-1))^2 = (1-u*z)^2+4*u*z^3

def Euler (F : S) := z * D F
def term (F : S) (s b : ℚ) := s • Euler F + b • F
def op (F : S) (t : ℚ) : S :=
  term F 1 1 + z*(term F (-3*t) (-3*t) +
    z*(term F (3*t^2) (3*t^2) + z*(term F (4*t-t^3) (-2*t-t^3) +
    z*term F (-4*t^2) (-2*t^2))))
def rhs (t : ℚ) : S :=
  1 + z*(C ℚ (-t) + z*(C ℚ (3*t) + z*C ℚ (-t*(t+2))))

theorem ode {F : S} {t : ℚ} (h : Source t F) : op F t = rhs t := by
  let u : S := C ℚ t
  let W : S := 2*z*(1-u*z)
  let V : S := (u+2)*z-1
  let Y := W*F-V
  let P : S := (1-u*z)^2+4*u*z^3
  have h0 : Y^2 = P := h
  have h1 : 2 * Y * D Y = D P := by
    rw [← h0, pow_two, Derivation.leibniz, smul_eq_mul]
    ring
  have deriv_eq : 2*P*D Y = D P * Y := by rw [←h1, ←h0]; ring
  have d2 : D (2:S) = 0 := Derivation.map_natCast D 2
  have d4 : D (4:S) = 0 := Derivation.map_natCast D 4
  dsimp [P,Y,V,W,u] at deriv_eq
  simp only [pow_succ, pow_zero, mul_one, Derivation.leibniz, smul_eq_mul, map_add,
    map_sub, derivative_X, derivative_C, Derivation.map_one_eq_zero,
    d2,d4] at deriv_eq
  have four : (4 : S) ≠ 0 := by
    intro he
    have eq := congrArg (constantCoeff ℚ) he
    rw [← map_ofNat (C ℚ) 4, constantCoeff_C] at eq
    norm_num at eq
  apply (mul_left_cancel₀ four)
  simp only [op, rhs, term, Euler, smul_eq_C_mul, map_add, map_sub, map_mul, map_neg,
    map_pow, map_one, map_ofNat]
  linear_combination deriv_eq

private theorem coeff_euler (F : S) (n : ℕ) :
    coeff ℚ n (Euler F) = n * coeff ℚ n F := by
  cases n with
  | zero => simp [Euler,coeff_zero_eq_constantCoeff]
  | succ n => rw [Euler,coeff_succ_X_mul,coeff_derivative]; push_cast; ring

private theorem coeff_term (F : S) (n : ℕ) (s b : ℚ) :
    coeff ℚ n (term F s b) = (s*n+b)*coeff ℚ n F := by
  simp [term, coeff_euler, smul_eq_mul]; ring

/-- Coefficient recurrence of the row polynomial, including t = 1 and t = 2. -/
theorem recurrence {F : S} {t : ℚ} (h : Source t F) (k : ℕ) :
    (k+5 : ℚ)*coeff ℚ (k+4) F - 3*t*(k+4)*coeff ℚ (k+3) F +
    3*t^2*(k+3)*coeff ℚ (k+2) F +
    ((4*t-t^3)*(k+4) + 2*t^3-14*t)*coeff ℚ (k+1) F +
    (14*t^2-4*t^2*(k+4))*coeff ℚ k F = 0 := by
  have hc := congrArg (coeff ℚ (k+4)) (ode h)
  simp only [op,rhs,map_add,coeff_succ_X_mul,coeff_term,coeff_one,coeff_C] at hc
  simp [Nat.add_eq_zero] at hc
  linear_combination hc

#print axioms recurrence
end
end RowRecurrence

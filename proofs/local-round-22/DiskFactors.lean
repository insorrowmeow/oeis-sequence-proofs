import Analytic
import Transfer
import Mathlib.Algebra.Polynomial.Div
import Mathlib.Algebra.Polynomial.Derivative
import Mathlib.Analysis.Complex.Polynomial.Basic

namespace CriticalPerimeter

open Polynomial Filter Topology
open scoped Polynomial
noncomputable section

private def linearPoly (q : ℂ) : ℂ[X] := 1 - C q * X
private def productPoly (l : List ℂ) : ℂ[X] := (l.map linearPoly).prod

private lemma product_coe (l : List ℂ) :
    (productPoly l : Transfer.Series) = Transfer.factorProduct l := by
  induction l with
  | nil => simp [productPoly,Transfer.factorProduct]
  | cons q l ih =>
    change ((linearPoly q * productPoly l : ℂ[X]) : Transfer.Series) =
      Transfer.linear q * Transfer.factorProduct l
    simp [linearPoly, Transfer.linear, ih]

private lemma product_eval (l : List ℂ) :
    (l.map (fun q => (1-q)⁻¹)).prod = ((productPoly l).eval 1)⁻¹ := by
  induction l with
  | nil => simp [productPoly]
  | cons q l ih =>
    change (1-q)⁻¹ * (l.map (fun w => (1-w)⁻¹)).prod =
      ((linearPoly q * productPoly l).eval 1)⁻¹
    rw [ih, eval_mul, linearPoly, eval_sub, eval_one, eval_mul, eval_C, eval_X, mul_one,
      mul_inv_rev, mul_comm]

private lemma factor_off_disk (p : ℂ[X]) (hc : p.eval 0 = 1)
    (hd : ∀ z : ℂ, ‖z‖ ≤ 1 → p.eval z ≠ 0) :
    ∃ l : List ℂ, p = productPoly l ∧ ∀ q ∈ l, ‖q‖ < 1 := by
  by_cases h : p.natDegree = 0
  · refine ⟨[], ?_, by simp⟩
    have hcoeff : p.coeff 0 = 1 := p.coeff_zero_eq_eval_zero.trans hc
    rw [eq_C_of_natDegree_eq_zero h, hcoeff]
    simp [productPoly]
  obtain ⟨z,hz⟩ := Complex.exists_root (natDegree_pos_iff_degree_pos.mp (Nat.pos_of_ne_zero h))
  have hlarge : 1 < ‖z‖ := lt_of_not_ge (fun hn => hd z hn hz)
  have zn : z ≠ 0 := fun he => by norm_num [he] at hlarge
  obtain ⟨t,ht⟩ := dvd_iff_isRoot.mpr hz
  let u := C (-z) * t
  have hp : p = linearPoly z⁻¹ * u := by
    change p = (1 - C z⁻¹ * X) * (C (-z) * t)
    rw [ht, ← mul_assoc]
    have hzC : C z⁻¹ * C z = (1 : ℂ[X]) := by rw [← map_mul, inv_mul_cancel₀ zn, map_one]
    simp only [map_neg, mul_neg, sub_mul, one_mul]
    linear_combination (-X * t) * hzC
  have uc : u.eval 0 = 1 := by simpa [hp, linearPoly] using hc
  have ud (w : ℂ) (hw : ‖w‖ ≤ 1) : u.eval w ≠ 0 := by
    intro he
    exact hd w hw (by simp [hp, he])
  have ut : u.natDegree < p.natDegree := by
    have tn : t ≠ 0 := fun he => by simp [ht,he] at hc
    rw [ht, natDegree_mul (X_sub_C_ne_zero z) tn, natDegree_X_sub_C]
    exact lt_of_le_of_lt (natDegree_C_mul_le _ _) (by omega)
  obtain ⟨l,hl,hl'⟩ := factor_off_disk u uc ud
  refine ⟨z⁻¹ :: l, ?_, ?_⟩
  · change p = linearPoly z⁻¹ * productPoly l
    rw [hp, hl]
  · intro q hq
    rcases List.mem_cons.mp hq with he|he
    · rw [he, norm_inv]
      exact inv_lt_one_of_one_lt₀ hlarge
    · exact hl' q he
termination_by p.natDegree
decreasing_by exact ut

/-- Coefficient transfer for the particular critical-modulus rational generating function. -/
theorem critical_coefficient_limit {s a u v : ℕ} (hs : 0 < s) {r : ℝ}
    (hr : 0 < r) (hr1 : r < 1) (h : 1-r = r^s) (F : Transfer.Series)
    (gen : F * denominator s (PowerSeries.C ℂ (r : ℂ) * PowerSeries.X) =
      numerator s a u v (PowerSeries.C ℂ (r : ℂ) * PowerSeries.X)) :
    Tendsto (fun n => PowerSeries.coeff ℂ n F) atTop
      (𝓝 ((numerator s a u v r / (-r * slope s r) : ℝ) : ℂ)) := by
  let R : ℂ := r
  let Y : ℂ[X] := C R * X
  let b : ℂ[X] := denominator s Y
  let p : ℂ[X] := numerator s a u v Y
  have b_eval (z : ℂ) : b.eval z = denominator s (R*z) := by simp [b, denominator,Y]
  have p_eval (z : ℂ) : p.eval z = numerator s a u v (R*z) := by simp [p,numerator,Y]
  have root : b.IsRoot 1 := by
    rw [IsRoot, b_eval, mul_one]
    change (1 - (r : ℂ))^2 - ((r : ℂ)^s)^2 = 0
    exact_mod_cast (show (1-r)^2-(r^s)^2 = 0 by rw [h]; ring)
  obtain ⟨t,ht⟩ := dvd_iff_isRoot.mpr root
  let T : ℂ[X] := -t
  have hb : b = (1-X)*T := by
    rw [ht]
    simp [T]
    ring
  have hc : T.eval 0 = 1 := by
    have hx := b_eval 0
    simpa [hb, denominator, zero_pow hs.ne'] using hx
  have hB' : b.derivative.eval 1 = (r * slope s r : ℝ) := by
    simp [b,Y,denominator,slope,R,derivative_pow,derivative_mul,derivative_sub]
    ring
  have hT : T.eval 1 = ((-r*slope s r : ℝ) : ℂ) := by
    rw [hb, derivative_mul] at hB'
    simp at hB'
    push_cast
    linear_combination -hB'
  have hd (z : ℂ) (hz : ‖z‖ ≤ 1) : T.eval z ≠ 0 := by
    intro he
    have hzero : denominator s (R*z) = 0 := by rw [← b_eval, hb]; simp [he]
    have hbnd : ‖R*z‖ ≤ r := by
      rw [norm_mul, show ‖R‖ = r by simpa [R] using (abs_of_pos hr)]
      nlinarith
    have hz' := unique_dominant_root h hzero hbnd
    have hR : R ≠ 0 := by
      change (r : ℂ) ≠ 0
      exact_mod_cast hr.ne'
    have hz1 : z = 1 := mul_left_cancel₀ hR (by simpa [R] using hz')
    have nonzero := (normalizer_pos (s:=s) hr hr1).ne'
    rw [hz1, hT] at he
    exact nonzero (by exact_mod_cast he)
  obtain ⟨l,hl,hl'⟩ := factor_off_disk T hc hd
  have bcoe : (b : Transfer.Series) = denominator s (PowerSeries.C ℂ R * PowerSeries.X) := by
    simp [b,Y,denominator]
  have pcoe : (p : Transfer.Series) = numerator s a u v (PowerSeries.C ℂ R * PowerSeries.X) := by
    simp [p,Y,numerator]
  have gen' : F * (1-PowerSeries.X) * Transfer.factorProduct l = (p : Transfer.Series) := by
    rw [← product_coe, ← hl, mul_assoc, ← coe_one, ← coe_X, ← coe_sub, ← coe_mul, ← hb, bcoe, pcoe]
    exact gen
  have htend := Transfer.coefficient_limit F p l hl' gen'
  rw [product_eval, ← hl, hT, p_eval, mul_one] at htend
  simpa [R, numerator, div_eq_mul_inv] using htend

#print axioms critical_coefficient_limit

end
end CriticalPerimeter

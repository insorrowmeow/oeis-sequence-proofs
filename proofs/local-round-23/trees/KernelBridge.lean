import Specialize
import Comparison

namespace Voloshyn
open PowerSeries VoloshynSeries Finset
noncomputable section
variable {K : Type*} [Field K]
local notation "S" => PowerSeries K
local notation "B" => PowerSeries (Polynomial K)
local notation "ι" => PowerSeries.map (Polynomial.C : K →+* Polynomial K)
local notation "χ" => (C (Polynomial K) Polynomial.X)

private theorem spec_lift (u f : S) : substHom u (ι f)=f := by
  ext n
  change coeff K n (subst _ _) = _
  simp only [subst, coeff_mk, coeff_map, Polynomial.map_C, Polynomial.eval_C, coeff_C]
  rw [sum_eq_single n]
  · simp
  · intro i hi hn
    have hil : i<n := by simp only [mem_range] at hi; omega
    simp [show n-i ≠ 0 by omega]
  · simp

private theorem derivative_lift (f : S) : derivativeX (ι f) = 0 := by
  ext n
  simp [derivativeX]

private theorem derivative_quartic (a b c d e : S) :
    derivativeX (quartic (ι a) (ι b) (ι c) (ι d) (ι e) χ) =
      dQuartic (ι a) (ι b) (ι c) (ι d) χ := by
  simp [quartic, dQuartic, pow_succ, derivativeX_mul, derivative_lift]
  ring

/-- Any solution of the forest kernel gives a double root of its explicit
quartic discriminant, in the ring of univariate formal power series. -/
theorem kernel_double_root (z : K) (f : S) (w : B)
    (hw : kernelA X (C _ (Polynomial.C z)) χ*w^2
        + kernelB X (ι f) χ*w - (1-χ) = 0) :
    ∃ r : S, delta X (C K z) f r = 0 ∧
      dQuartic (fourth X (C K z) f) (third X (C K z) f)
        (second X (C K z) f) (-2) r = 0 := by
  let J := 2 * kernelA X (C _ (Polynomial.C z)) χ * w + kernelB X (ι f) χ
  have hconst : coeff _ 0 J = 1-Polynomial.X := by
    rw [coeff_zero_eq_constantCoeff_apply]
    simp [J, kernelA, kernelB]
  obtain ⟨r, hr, hder⟩ := catalytic_square_double_root hconst (square_of_forest _ _ _ _ _ hw).symm
  use r
  constructor
  · simpa [delta, kernelA, kernelB, spec_lift, map_ofNat] using hr
  · have he : delta X (C _ (Polynomial.C z)) (ι f) χ =
        quartic (ι (fourth X (C K z) f)) (ι (third X (C K z) f))
          (ι (second X (C K z) f)) (ι (-2)) (ι 1) χ := by
      rw [delta_as_quartic]
      simp [fourth, third, second, map_ofNat]
    rw [he, derivative_quartic] at hder
    simpa only [dQuartic, map_add, map_mul, map_pow, map_ofNat, spec_lift,
      substHom_C, Polynomial.eval₂_X] using hder

/-- The full formal-series comparison, given the two defining equations. -/
theorem forest_eq_gww_of_kernel [CharZero K] (z : K) (hz : z ≠ 0) (h1 : z ≠ 1)
    (f g : S) (w : B)
    (hw : kernelA X (C _ (Polynomial.C z)) χ*w^2
        + kernelB X (ι f) χ*w - (1-χ) = 0)
    (hg : gww256 (-C K z+2*X*(1-C K z)^2*g) (-C K z) (4*X*(1-C K z)^3)=0) :
    f=g := by
  obtain ⟨r,hr,hd⟩ := kernel_double_root z f w hw
  exact forest_eq_gww_of_double_root z hz h1 f g r hr hd hg

#print axioms forest_eq_gww_of_kernel
end
end Voloshyn

import Quartic
import Series

namespace Voloshyn
open PowerSeries

noncomputable section
variable {K : Type*} [Field K] [CharZero K]
local notation "S" => PowerSeries K

omit [CharZero K] in
private theorem eval_correction (t z y : S) :
    (correction (Polynomial.C t) (Polynomial.C z) Polynomial.X).eval y =
    correction t z y := by
  simp [correction, Polynomial.eval_add, Polynomial.eval_mul, Polynomial.eval_sub,
    Polynomial.eval_pow, Polynomial.eval_neg]

/-- Equality of the forest branch and the GWW branch follows from a repeated
root of the forest discriminant. All three data are formal power series. -/
theorem forest_eq_gww_of_double_root (z : K) (hz : z ≠ 0) (h1 : z ≠ 1) (f g r : S)
    (hval : delta X (C K z) f r = 0)
    (hder : dQuartic (fourth X (C K z) f) (third X (C K z) f)
        (second X (C K z) f) (-2) r = 0)
    (hg : gww256 (-C K z+2*X*(1-C K z)^2*g) (-C K z) (4*X*(1-C K z)^3)=0) :
    f=g := by
  rw [delta_as_quartic] at hval
  have hf := double_root_invariant _ _ _ _ _ r hval hder
  rw [tree_quartic_certificate] at hf
  rw [gww_certificate] at hg
  have hz' : (1 : S)-C K z ≠ 0 := by
    intro h
    apply h1
    have hc := congrArg (constantCoeff K) h
    simp only [map_sub, map_one, constantCoeff_C, map_zero, sub_eq_zero] at hc
    exact hc.symm
  have h6912 : (6912:S) ≠ 0 := by
    intro h
    have hh := congrArg (constantCoeff K) h
    simp only [map_ofNat, map_zero] at hh
    exact (Nat.cast_ne_zero.mpr (by decide : (6912:ℕ) ≠ 0)) hh
  have h16 : (16:S) ≠ 0 := by
    intro h
    have hh := congrArg (constantCoeff K) h
    simp only [map_ofNat, map_zero] at hh
    exact (Nat.cast_ne_zero.mpr (by decide : (16:ℕ) ≠ 0)) hh
  have hn : (6912:S)*X^3 ≠ 0 := mul_ne_zero h6912 (pow_ne_zero _ X_ne_zero)
  have hn' : (16:S)*X*(1-C K z)^6 ≠ 0 :=
    mul_ne_zero (mul_ne_zero h16 X_ne_zero) (pow_ne_zero _ hz')
  have hnf := (mul_eq_zero.mp hf).resolve_left hn
  have hng := (mul_eq_zero.mp hg).resolve_left hn'
  apply VoloshynSeries.unique_polynomial_branch z hz
    (correction (Polynomial.C X) (Polynomial.C (C K z)) Polynomial.X)
  · rw [eval_correction]
    exact hnf
  · rw [eval_correction]
    exact hng

#print axioms forest_eq_gww_of_double_root
end
end Voloshyn

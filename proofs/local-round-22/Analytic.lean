import Mathlib.Analysis.Calculus.Deriv.Add
import Mathlib.Analysis.Calculus.Deriv.Pow
import Mathlib.Analysis.Complex.Basic
import Mathlib.Analysis.SpecificLimits.Normed
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.Positivity
import Mathlib.Tactic.Ring

namespace CriticalPerimeter

open Filter Topology
noncomputable section

def denominator {K : Type*} [CommRing K] (s : ℕ) (z : K) : K :=
  (1 - z) ^ 2 - (z ^ s) ^ 2

def numerator {K : Type*} [CommRing K] (s a u v : ℕ) (z : K) : K :=
  z ^ a * (1 - z + z ^ s) - z ^ u * (1 - z) - z ^ v

theorem denominator_root {r : ℝ} {s : ℕ} (h : 1 - r = r ^ s) :
    denominator s r = 0 := by simp [denominator, h]

/-- The positive root is the only complex root in its closed disk. -/
theorem unique_dominant_root {r : ℝ} {s : ℕ} (h : 1 - r = r ^ s)
    {z : ℂ} (hz : denominator s z = 0) (hbound : ‖z‖ ≤ r) : z = (r : ℂ) := by
  have hsq : (1 - z) ^ 2 = (z ^ s) ^ 2 := sub_eq_zero.mp hz
  have he : ‖1 - z‖ = ‖z‖ ^ s := by
    have hn := congrArg norm hsq
    simp only [norm_pow] at hn
    nlinarith [norm_nonneg (1-z), pow_nonneg (norm_nonneg z) s]
  have hre : 1 - z.re ≤ ‖1 - z‖ := by simpa using Complex.re_le_norm (1-z)
  have hp : ‖z‖ ^ s ≤ r ^ s := pow_le_pow_left₀ (norm_nonneg z) hbound _
  have hzr : z.re = r := by linarith [Complex.re_le_norm z]
  have hnr : ‖z‖ = r := le_antisymm hbound (hzr ▸ Complex.re_le_norm z)
  have him := Complex.sq_norm_sub_sq_re z
  rw [hnr, hzr] at him
  apply Complex.ext
  · simpa using hzr
  · change z.im = 0
    nlinarith [sq_nonneg z.im]

def slope (s : ℕ) (r : ℝ) : ℝ :=
  -2 * (1-r) - 2 * r^s * ((s : ℝ) * r^(s-1))

theorem denominator_hasDerivAt (s : ℕ) (r : ℝ) :
    HasDerivAt (denominator s) (slope s r) r := by
  have hid : HasDerivAt (fun x : ℝ => 1-x) (-1) r :=
    HasDerivAt.const_sub 1 (hasDerivAt_id r)
  have h₁ := hid.pow 2
  have h₂ := ((hasDerivAt_pow s r).pow 2)
  convert h₁.sub h₂ using 1
  simp [slope]

theorem slope_negative {r : ℝ} {s : ℕ} (hr : 0 < r) (hr1 : r < 1) :
    slope s r < 0 := by
  have hb : 0 ≤ 2 * r^s * ((s : ℝ) * r^(s-1)) := by positivity
  unfold slope
  linarith

theorem numerator_at_root {r : ℝ} {s : ℕ} (h : 1-r = r^s) (a u v : ℕ) :
    numerator s a u v r = 2*r^(a+s) - r^(u+s) - r^v := by
  simp only [numerator, h, pow_add]
  ring

/-- The real normalizing factor in the simple-pole coefficient is positive. -/
theorem normalizer_pos {r : ℝ} {s : ℕ} (hr : 0 < r) (hr1 : r < 1) :
    0 < -r * slope s r := mul_pos_of_neg_of_neg (neg_lt_zero.mpr hr) (slope_negative hr hr1)

/-- Finite simple-pole expansions converge after normalization if all remaining poles are larger. -/
theorem spectral_limit {ι : Type*} (I : Finset ι) (c : ℂ) (r : ℝ) (hr : 0 < r)
    (z w : ι → ℂ) (hz : ∀ i ∈ I, r < ‖z i‖) :
    Tendsto (fun n : ℕ => c + ∑ i ∈ I, w i * ((r : ℂ) / z i)^n) atTop (𝓝 c) := by
  have hi (i : ι) (mem : i ∈ I) : ‖(r : ℂ) / z i‖ < 1 := by
    rw [norm_div, Complex.norm_real, Real.norm_eq_abs, abs_of_pos hr]
    exact (div_lt_one (hr.trans (hz i mem))).mpr (hz i mem)
  have ht (i : ι) (mem : i ∈ I) :
      Tendsto (fun n : ℕ => w i * ((r : ℂ) / z i)^n) atTop (𝓝 0) := by
    simpa using (tendsto_pow_atTop_nhds_zero_of_norm_lt_one (hi i mem)).const_mul (w i)
  simpa using (tendsto_finset_sum I ht).const_add c

theorem diverges_of_positive_limit {c r : ℝ} (hr : 0 < r) (hr1 : r < 1)
    {d : ℕ → ℝ} (hc : 0 < c) (hd : Tendsto (fun n => r^n * d n) atTop (𝓝 c)) :
    Tendsto d atTop atTop := by
  have h := hd.pos_mul_atTop hc (tendsto_pow_atTop_atTop_of_one_lt ((one_lt_inv₀ hr).mpr hr1))
  simpa only [inv_pow, mul_comm (r ^ _) (d _), mul_assoc, mul_inv_cancel₀ (pow_ne_zero _ hr.ne'), mul_one] using h

theorem diverges_of_negative_limit {c r : ℝ} (hr : 0 < r) (hr1 : r < 1)
    {d : ℕ → ℝ} (hc : c < 0) (hd : Tendsto (fun n => r^n * d n) atTop (𝓝 c)) :
    Tendsto d atTop atBot := by
  have h := hd.neg_mul_atTop hc (tendsto_pow_atTop_atTop_of_one_lt ((one_lt_inv₀ hr).mpr hr1))
  simpa only [inv_pow, mul_comm (r ^ _) (d _), mul_assoc, mul_inv_cancel₀ (pow_ne_zero _ hr.ne'), mul_one] using h

end
end CriticalPerimeter

import Generators

namespace CriticalPerimeter

noncomputable section
open PowerSeries Filter Topology

/-- The coefficient difference for the two published generating functions. -/
def gapMinusResidue (s a u v n : ℕ) : ℝ :=
  coeff ℝ n (gapSeries s a) - coeff ℝ n (residueSeries s u v)

/-- At degree n, dilation multiplies the original coefficient by r^n. -/
def normalizedDifference (s a u v : ℕ) (r : ℝ) : PowerSeries ℂ :=
  rescale (r : ℂ) (PowerSeries.map Complex.ofRealHom (gapSeries s a - residueSeries s u v))

theorem coeff_normalizedDifference (s a u v n : ℕ) (r : ℝ) :
    coeff ℂ n (normalizedDifference s a u v r) = ((r^n * gapMinusResidue s a u v n : ℝ) : ℂ) := by
  simp [normalizedDifference, gapMinusResidue, coeff_rescale, coeff_map, mul_sub]

/-- Dilation substitutes C(r)X throughout the exact rational series identity. -/
theorem scaled_series_identity (s a u v : ℕ) (hs : 0<s) (r : ℝ) :
    normalizedDifference s a u v r *
        denominator s (C ℂ (r : ℂ) * X) = numerator s a u v (C ℂ (r : ℂ) * X) := by
  let x : PowerSeries ℝ := X
  have hd : constantCoeff ℝ (denominator s x) ≠ 0 := by simp [x, denominator, hs.ne']
  have h : (gapSeries s a - residueSeries s u v) * denominator s x = numerator s a u v x :=
    (eq_mul_inv_iff_mul_eq hd).mp (series_difference s a u v hs.ne')
  let mapScale : PowerSeries ℝ →+* PowerSeries ℂ :=
    (rescale (r : ℂ)).comp (PowerSeries.map Complex.ofRealHom)
  have hX : mapScale x = C ℂ (r : ℂ) * X := by
    dsimp [mapScale, x]
    rw [PowerSeries.map_X, rescale_X]
  change mapScale (gapSeries s a - residueSeries s u v) *
    denominator s (C ℂ (r : ℂ) * X) = numerator s a u v (C ℂ (r : ℂ) * X)
  simpa only [map_mul, denominator, numerator, map_pow, map_sub, map_add, map_one, hX]
    using congrArg mapScale h

/-- A complex coefficient limit of the dilation gives the real normalized limit. -/
theorem real_limit_of_normalized {s a u v : ℕ} {r c : ℝ}
    (h : Tendsto (fun n => coeff ℂ n (normalizedDifference s a u v r)) atTop (𝓝 (c : ℂ))) :
    Tendsto (fun n => r^n * gapMinusResidue s a u v n) atTop (𝓝 c) := by
  apply tendsto_ofReal_iff.mp
  simpa only [coeff_normalizedDifference] using h

end
end CriticalPerimeter

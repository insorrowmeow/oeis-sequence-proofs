import Critical
import DiskFactors
import Normalization
import Radius

/-! Classification of the coefficient differences of the fixed-perimeter
generating functions at modulus 2s. Complete.lean applies it to the partition
counts using the formal proofs of the two generating functions. -/

namespace CriticalPerimeter

open Filter Topology
noncomputable section

def criticalScore (s a u v : ℕ) (r : ℝ) : ℝ :=
  2*r^(a+s) - r^(u+s) - r^v

/-- The normalized coefficient difference has this limit even if the score is zero. -/
theorem normalized_gap_limit {s : ℕ} (hs : 0<s) (a u v : ℕ) {r : ℝ}
    (hr : 0<r) (hr1 : r<1) (he : r^s+r=1) :
    Tendsto (fun n => r^n * gapMinusResidue s a u v n) atTop
      (𝓝 (criticalScore s a u v r / (-r * slope s r))) := by
  have h : 1-r = r^s := by linarith
  have lim := real_limit_of_normalized
    (critical_coefficient_limit hs hr hr1 h _ (scaled_series_identity s a u v hs r))
  simpa only [numerator_at_root h, criticalScore] using lim

/-- At the critical modulus exactly aligned residues give zero. Each other
admissible pair has signed divergence determined by the displayed real score. -/
theorem critical_classification {s a u v : ℕ} (hs : 1<s)
    (hu : 0<u) (huv : u<v) (hv : v≤2*s) :
    let r := criticalRadius s (by omega)
    let j := criticalScore s a u v r
    (j = 0 ↔ u = a ∧ v = a+s) ∧
    (j = 0 → ∀ n, gapMinusResidue s a u v n = 0) ∧
    (0 < j → Tendsto (gapMinusResidue s a u v) atTop atTop) ∧
    (j < 0 → Tendsto (gapMinusResidue s a u v) atTop atBot) := by
  let hs₀ : 0<s := by omega
  let r := criticalRadius s hs₀
  obtain ⟨hr, hr1, he⟩ := criticalRadius_spec s hs₀
  have hz : criticalScore s a u v r = 0 ↔ u=a ∧ v=a+s :=
    CriticalResidues.critical_zero_iff hs hr hr1 he hu huv hv
  have hd : 0 < -r * slope s r := normalizer_pos hr hr1
  have lim := normalized_gap_limit hs₀ a u v hr hr1 he
  refine ⟨hz, ?_, ?_, ?_⟩
  · intro h
    obtain ⟨rfl,rfl⟩ := hz.mp h
    intro n
    exact sub_eq_zero.mpr (aligned_coefficient s _ n hs₀.ne')
  · intro h
    exact diverges_of_positive_limit hr hr1 (div_pos h hd) lim
  · intro h
    exact diverges_of_negative_limit hr hr1 (div_neg_of_neg_of_pos h hd) lim

#print axioms normalized_gap_limit
#print axioms critical_classification

end
end CriticalPerimeter

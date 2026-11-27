import Classification
import GapPartitions
import ResiduePartitions

/-! The critical comparison for the numbers of partitions of perimeter n,
expressed with the published parameter d and modulus 2(d+1). -/

namespace CriticalPerimeter
noncomputable section
open Filter Topology

/-- Signed difference: ascending gap-d tuples minus partitions in the two
residue classes. Subtraction takes place in ℝ to retain its sign. -/
def partitionDifference (d a u v n : ℕ) : ℝ :=
  (CriticalGap.partitionCount d a n : ℝ) - (Nat.card (PartitionsByLargest (2*(d+1)) u v n) : ℝ)

private theorem partition_difference_eq {d a u v : ℕ} (hd : 0<d) (hu : 0<u)
    (huv : u<v) (hv : v≤2*(d+1)) :
    gapMinusResidue (d+1) a u v = partitionDifference d a u v := by
  funext n
  unfold gapMinusResidue partitionDifference
  rw [coefficient_gap_count _ _ _ (by omega), coefficient_partitions_by_largest hu huv hv n,
    ← CriticalGap.gap_card (d+1) a n (by omega)]
  simp

/-- The normalized limit for the difference of the two literal partition counts. -/
theorem partition_count_limit {d a u v : ℕ} (hd : 0<d) (hu : 0<u)
    (huv : u<v) (hv : v≤2*(d+1)) :
    let r := criticalRadius (d+1) (by omega)
    Tendsto (fun n => r^n * partitionDifference d a u v n) atTop
      (𝓝 (criticalScore (d+1) a u v r / (-r * slope (d+1) r))) := by
  obtain ⟨hr,hr1,he⟩ := criticalRadius_spec (d+1) (by omega)
  simpa only [partition_difference_eq hd hu huv hv] using
    normalized_gap_limit (by omega : 0<d+1) a u v hr hr1 he

/-- For every positive lower bound a, including a=d+1, the two partition
counts agree for every perimeter exactly when the residues are a and a+d+1.
The sign of the score determines divergence. The tuple model also allows
a=0, in which case the least entry can be zero. -/
theorem partition_count_classification {d a u v : ℕ} (hd : 0<d)
    (hu : 0<u) (huv : u<v) (hv : v≤2*(d+1)) :
    let r := criticalRadius (d+1) (by omega)
    let j := criticalScore (d+1) a u v r
    (j = 0 ↔ u=a ∧ v=a+(d+1)) ∧
    ((∀ n, CriticalGap.partitionCount d a n = Nat.card (PartitionsByLargest (2*(d+1)) u v n)) ↔
      u=a ∧ v=a+(d+1)) ∧
    (0<j → Tendsto (partitionDifference d a u v) atTop atTop) ∧
    (j<0 → Tendsto (partitionDifference d a u v) atTop atBot) := by
  have eqcounts := partition_difference_eq (a:=a) hd hu huv hv
  have classif := critical_classification (a:=a) (by omega : 1<d+1) hu huv hv
  rw [eqcounts] at classif
  obtain ⟨hz,hall,hpos,hneg⟩ := classif
  refine ⟨hz, ⟨?_,?_⟩, hpos, hneg⟩
  · intro hequal
    apply hz.mp
    have hdiff (n : ℕ) : partitionDifference d a u v n = 0 := by
      simp [partitionDifference, hequal n]
    have hlim := partition_count_limit (a:=a) hd hu huv hv
    simp only [hdiff, mul_zero] at hlim
    have he : _ = (0:ℝ) := tendsto_nhds_unique hlim tendsto_const_nhds
    obtain ⟨hr,hr1,_⟩ := criticalRadius_spec (d+1) (by omega)
    exact (div_eq_zero_iff.mp he).resolve_right (normalizer_pos hr hr1).ne'
  · intro hequal n
    have he := sub_eq_zero.mp (hall (hz.mpr hequal) n)
    exact_mod_cast he

#print axioms partition_count_limit
#print axioms partition_count_classification

end
end CriticalPerimeter

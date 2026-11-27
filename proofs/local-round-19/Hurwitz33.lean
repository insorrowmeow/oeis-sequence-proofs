import HiveCount
import HiveCycles
import HurwitzZero

namespace Hurwitz33

/-- The polynomial obtained by counting all monotone transitive tuples
on six letters with product of cycle type (3,3) and six transpositions. -/
noncomputable def polynomial := HurwitzZero.evalCounts HiveCount.counts

theorem exact_zero : polynomial HurwitzZero.x HurwitzZero.y HurwitzZero.z
    HurwitzZero.w HurwitzZero.u = 0 := by
  unfold polynomial
  rw [HiveCount.counts_exact]
  exact HurwitzZero.exact_zero

theorem not_stable : ¬ HurwitzZero.Stable polynomial := by
  unfold polynomial
  rw [HiveCount.counts_exact]
  exact HurwitzZero.not_stable

#print axioms not_stable

/-- The same polynomial obtained from the cycle and component recurrence,
    whose finite counts are reduced inside the kernel. -/
noncomputable def cyclePolynomial := HurwitzZero.evalCounts HiveCycles.counts

theorem kernel_not_stable : ¬ HurwitzZero.Stable cyclePolynomial := by
  unfold cyclePolynomial
  rw [HiveCycles.counts_exact]
  exact HurwitzZero.not_stable

#print axioms kernel_not_stable

end Hurwitz33

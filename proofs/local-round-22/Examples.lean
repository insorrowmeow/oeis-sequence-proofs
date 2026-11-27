import Complete

namespace CriticalPerimeter
open Filter

/-- At modulus eight, the two neighboring choices 7 and 8 yield opposite limits. -/
theorem neighboring_residue_limits :
    Tendsto (partitionDifference 3 2 1 7) atTop atBot ∧
    Tendsto (partitionDifference 3 2 1 8) atTop atTop := by
  let r := criticalRadius 4 (by decide)
  obtain ⟨hr, hr1, he⟩ := criticalRadius_spec 4 (by decide)
  change 0 < r at hr
  change r < 1 at hr1
  change r^4 + r = 1 at he
  have hn : criticalScore 4 2 1 7 r < 0 := by
    have score : criticalScore 4 2 1 7 r = -(r^5 * (1-r)^2) := by
      unfold criticalScore
      ring
    rw [score]
    exact neg_lt_zero.mpr (mul_pos (pow_pos hr _) (pow_pos (sub_pos.mpr hr1) _))
  have hp : 0 < criticalScore 4 2 1 8 r := by
    have score : criticalScore 4 2 1 8 r = r^7 * (1-r) * (1-r^2) := by
      unfold criticalScore
      linear_combination (r^5 * (1-r)) * he
    rw [score]
    exact mul_pos (mul_pos (pow_pos hr _) (sub_pos.mpr hr1))
      (sub_pos.mpr (by nlinarith [mul_pos hr (sub_pos.mpr hr1)]))
  exact ⟨(partition_count_classification (d:=3) (a:=2) (u:=1) (v:=7)
    (by decide) (by decide) (by decide) (by decide)).2.2.2 hn,
    (partition_count_classification (d:=3) (a:=2) (u:=1) (v:=8)
    (by decide) (by decide) (by decide) (by decide)).2.2.1 hp⟩

#print axioms neighboring_residue_limits
end CriticalPerimeter

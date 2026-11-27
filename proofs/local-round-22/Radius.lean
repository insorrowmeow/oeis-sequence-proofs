import Mathlib.Analysis.Calculus.Deriv.Pow
import Mathlib.Data.Real.Basic
import Mathlib.Topology.Order.IntermediateValue
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.NormNum

namespace CriticalPerimeter

/-- The increasing continuous function x+x^s takes the value 1 exactly once
in the open unit interval. -/
theorem existsUnique_radius (s : ℕ) (hs : 0<s) :
    ∃! r : ℝ, 0<r ∧ r<1 ∧ r^s+r=1 := by
  let f : ℝ → ℝ := fun x => x^s+x
  have hcon : Continuous f := (continuous_id.pow s).add continuous_id
  have h₀ : f 0 = 0 := by simp [f, hs.ne']
  have h₁ : f 1 = 2 := by norm_num [f]
  have hI : (1:ℝ) ∈ Set.Icc (f 0) (f 1) := by rw [h₀,h₁]; constructor <;> norm_num
  obtain ⟨r, ⟨hz,ho⟩, hr⟩ := intermediate_value_Icc (zero_le_one : (0:ℝ)≤1) hcon.continuousOn hI
  have hstrict : 0<r ∧ r<1 := by
    constructor
    · apply lt_of_le_of_ne hz
      rintro rfl
      linarith
    · apply lt_of_le_of_ne ho
      rintro rfl
      linarith
  refine ⟨r, ⟨hstrict.1, hstrict.2, hr⟩, ?_⟩
  rintro w ⟨hw, _, hwf⟩
  change r^s+r=1 at hr
  rcases lt_trichotomy w r with h|h|h
  · have hpow := pow_le_pow_left₀ hw.le h.le s
    linarith
  · exact h
  · have hpow := pow_le_pow_left₀ hz h.le s
    linarith

noncomputable def criticalRadius (s : ℕ) (hs : 0<s) : ℝ :=
  (existsUnique_radius s hs).choose

theorem criticalRadius_spec (s : ℕ) (hs : 0<s) :
    0 < criticalRadius s hs ∧ criticalRadius s hs < 1 ∧
      criticalRadius s hs ^ s + criticalRadius s hs = 1 :=
  (existsUnique_radius s hs).choose_spec.1

end CriticalPerimeter

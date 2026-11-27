import Mathlib.Analysis.SpecialFunctions.Pow.Continuity
import Mathlib.Analysis.SpecificLimits.Basic
import Mathlib.Tactic.Linarith

open Filter
open scoped Topology

namespace GrayLimit

private theorem log_at_index {a : ℕ → ℕ}
    (bounds : ∀ k : ℕ, 2^(k+11) ≤ a (2*k+23) ∧ a (2*k+23) < 2^(k+12) ∧
      2^(k+11) ≤ a (2*k+24) ∧ a (2*k+24) < 2^(k+12))
    (n : ℕ) (hn : 23 ≤ n) :
    0 < (a n : ℝ) ∧ ((n : ℝ)/2-1)*Real.log 2 ≤ Real.log (a n) ∧
      Real.log (a n) ≤ ((n : ℝ)/2+1)*Real.log 2 := by
  let k := (n-23)/2
  have pair : n = 2*k+23 ∨ n = 2*k+24 := by dsimp [k]; omega
  obtain ⟨l₁,u₁,l₂,u₂⟩ := bounds k
  have hl : (2 : ℝ)^(k+11) ≤ (a n : ℝ) := by
    rcases pair with h|h <;> rw [h]
    · exact_mod_cast l₁
    · exact_mod_cast l₂
  have hu : (a n : ℝ) ≤ (2 : ℝ)^(k+12) := by
    rcases pair with h|h <;> rw [h]
    · exact_mod_cast u₁.le
    · exact_mod_cast u₂.le
  have ha : 0 < (a n : ℝ) := lt_of_lt_of_le (by positivity) hl
  have hll := Real.log_le_log (by positivity : 0 < (2 : ℝ)^(k+11)) hl
  have huu := Real.log_le_log ha hu
  rw [Real.log_pow] at hll huu
  push_cast at hll huu
  have h2 : 0 < Real.log 2 := Real.log_pos (by norm_num)
  refine ⟨ha, le_trans ?_ hll, le_trans huu ?_⟩
  · apply mul_le_mul_of_nonneg_right _ h2.le
    rcases pair with h|h <;> rw [h] <;> push_cast <;> linarith
  · apply mul_le_mul_of_nonneg_right _ h2.le
    rcases pair with h|h <;> rw [h] <;> push_cast <;> linarith

/-- The dyadic block bounds alone imply the conjectured root-ratio limit. -/
theorem ratio_limit (a : ℕ → ℕ)
    (bounds : ∀ k : ℕ, 2^(k+11) ≤ a (2*k+23) ∧ a (2*k+23) < 2^(k+12) ∧
      2^(k+11) ≤ a (2*k+24) ∧ a (2*k+24) < 2^(k+12)) :
    Tendsto (fun n : ℕ => ((a (2*n) : ℝ)/(a n : ℝ)) ^ (1 / (n : ℝ)))
      atTop (𝓝 (Real.sqrt 2)) := by
  let L := Real.log 2
  let f := fun n : ℕ => (Real.log (a (2*n)) - Real.log (a n))/(n:ℝ)
  have clos : ∀ᶠ n : ℕ in atTop, L/2-(2*L)/(n:ℝ) ≤ f n ∧ f n ≤ L/2+(2*L)/(n:ℝ) := by
    filter_upwards [eventually_ge_atTop 23] with n hn
    obtain ⟨_,lo,up⟩ := log_at_index bounds n hn
    obtain ⟨_,lo',up'⟩ := log_at_index bounds (2*n) (by omega)
    have hpos : (0 : ℝ) < n := by exact_mod_cast (by omega : 0 < n)
    push_cast at lo' up'
    dsimp [f,L]
    constructor
    · apply (le_div_iff₀ hpos).mpr
      rw [sub_mul, div_mul_cancel₀ _ hpos.ne']
      nlinarith
    · apply (div_le_iff₀ hpos).mpr
      rw [add_mul, div_mul_cancel₀ _ hpos.ne']
      nlinarith
  have z := tendsto_const_div_atTop_nhds_zero_nat (2*L)
  have c : Tendsto (fun _ : ℕ => L/2) atTop (𝓝 (L/2)) := tendsto_const_nhds
  have hf : Tendsto f atTop (𝓝 (L/2)) :=
    tendsto_of_tendsto_of_tendsto_of_le_of_le' (by simpa using c.sub z)
      (by simpa using c.add z) (clos.mono fun _ h => h.1) (clos.mono fun _ h => h.2)
  have hh := Real.continuous_exp.continuousAt.tendsto.comp hf
  have value : Real.sqrt 2 = Real.exp (L/2) := by
    rw [Real.sqrt_eq_rpow, Real.rpow_def_of_pos (by norm_num : (0 : ℝ) < 2)]
    congr 1
    dsimp [L]
    ring
  rw [value]
  apply hh.congr'
  filter_upwards [eventually_ge_atTop 23] with n hn
  have h1 := (log_at_index bounds n hn).1
  have h2 := (log_at_index bounds (2*n) (by omega)).1
  change Real.exp ((Real.log (a (2*n)) - Real.log (a n))/(n:ℝ)) =
    ((a (2*n) : ℝ)/(a n : ℝ)) ^ (1 / (n : ℝ))
  rw [Real.rpow_def_of_pos (div_pos h2 h1), Real.log_div h2.ne' h1.ne']
  congr 1
  ring

#print axioms ratio_limit
end GrayLimit

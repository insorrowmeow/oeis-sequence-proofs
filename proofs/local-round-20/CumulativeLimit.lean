import PerimeterLimit

/-! An additive (two-term) asymptotic is stable under the square-root
cutoff in the cumulative perimeter bounds. -/

open Filter Topology PerimeterLimit
namespace CumulativeLimit

noncomputable def mainTerm (c : ℝ) (n : ℕ) : ℝ :=
  c * (Real.log n + Real.log (Real.log n))

theorem mainTerm_shift (c : ℝ) :
    Tendsto (fun n => mainTerm c (leftIndex n) - mainTerm c n) atTop (𝓝 0) := by
  have avoid : ∀ᶠ n : ℕ in atTop, (1:ℝ)<n ∧ (1:ℝ)<leftIndex n := by
    filter_upwards [eventually_ge_atTop 2, leftIndex_atTop.eventually (eventually_ge_atTop 2)]
      with n hn hk
    change 2 ≤ leftIndex n at hk
    exact ⟨by exact_mod_cast (show 1 < n by omega),
      by exact_mod_cast (show 1 < leftIndex n by omega)⟩
  have logShift : Tendsto (fun n => Real.log (leftIndex n) - Real.log n) atTop (𝓝 0) := by
    have h : Tendsto (fun n : ℕ => Real.log ((leftIndex n:ℝ)/n)) atTop (𝓝 0) := by
      simpa using leftIndex_ratio.log (by norm_num)
    apply h.congr'
    filter_upwards [avoid] with n hn
    exact Real.log_div (by linarith [hn.2]) (by linarith [hn.1])
  have loglogShift : Tendsto
      (fun n => Real.log (Real.log (leftIndex n)) - Real.log (Real.log n)) atTop (𝓝 0) := by
    have h : Tendsto (fun n : ℕ => Real.log (Real.log (leftIndex n) / Real.log n))
        atTop (𝓝 0) := by simpa using leftIndex_log_ratio.log (by norm_num)
    apply h.congr'
    filter_upwards [avoid] with n hn
    exact Real.log_div (ne_of_gt (Real.log_pos hn.2)) (ne_of_gt (Real.log_pos hn.1))
  have both := (logShift.add loglogShift).const_mul c
  simp only [zero_add, mul_zero] at both
  apply both.congr
  intro n
  dsimp [mainTerm]
  ring

theorem cutoff_error_tendsto (C : ℝ) (d : ℕ) (hC : 0 ≤ C) :
    Tendsto (fun n => error C d n) atTop (𝓝 0) := by
  apply tendsto_of_tendsto_of_tendsto_of_le_of_le' tendsto_const_nhds (error_small C d hC)
  · exact .of_forall fun n => by dsimp [error]; positivity
  · filter_upwards [eventually_ge_atTop 1] with n hn
    have hn' : (1:ℝ) ≤ n := by exact_mod_cast hn
    have he : 0 ≤ error C d n := by dsimp [error]; positivity
    exact le_mul_of_one_le_left he hn'

theorem cumulative_limit (H W : ℕ → ℝ) (c C : ℝ) (d : ℕ) (hC : 0 ≤ C)
    (mertens : Tendsto (fun n => H n - mainTerm c n) atTop (𝓝 0))
    (lower : ∀ᶠ n in atTop, H (leftIndex n) - error C d n ≤ W n)
    (upper : ∀ᶠ n in atTop, W n ≤ H n) :
    Tendsto (fun n => W n - mainTerm c n) atTop (𝓝 0) := by
  have h := ((mertens.comp leftIndex_atTop).add (mainTerm_shift c)).sub
    (cutoff_error_tendsto C d hC)
  simp only [zero_add, sub_zero] at h
  apply tendsto_of_tendsto_of_tendsto_of_le_of_le' h mertens
  · filter_upwards [lower] with n hn
    dsimp
    linarith
  · filter_upwards [upper] with n hn
    exact sub_le_sub_right hn _

#print axioms cumulative_limit
end CumulativeLimit

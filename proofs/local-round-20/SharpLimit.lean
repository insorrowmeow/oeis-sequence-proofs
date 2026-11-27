import CumulativeLimit

open Filter Topology PerimeterLimit
namespace SharpLimit

private theorem avoid : ∀ᶠ n : ℕ in atTop,
    1 < Real.log (n:ℝ) ∧ 1 < Real.log (leftIndex n:ℝ) ∧
    (1:ℝ) < n ∧ (1:ℝ) < leftIndex n := by
  have h := Real.tendsto_log_atTop.comp tendsto_natCast_atTop_atTop
  filter_upwards [h.eventually_gt_atTop 1, (h.comp leftIndex_atTop).eventually_gt_atTop 1,
    eventually_ge_atTop 2, leftIndex_atTop.eventually (eventually_ge_atTop 2)] with n hn hk hn' hk'
  change 2 ≤ leftIndex n at hk'
  exact ⟨hn, hk, by exact_mod_cast (show 1<n by omega), by exact_mod_cast (show 1<leftIndex n by omega)⟩

private theorem inv_loglog_zero :
    Tendsto (fun n : ℕ => (Real.log (Real.log n))⁻¹) atTop (𝓝 0) :=
  tendsto_inv_atTop_zero.comp (Real.tendsto_log_atTop.comp
    (Real.tendsto_log_atTop.comp tendsto_natCast_atTop_atTop))

theorem left_loglog_ratio :
    Tendsto (fun n : ℕ => Real.log (Real.log (leftIndex n)) / Real.log (Real.log n))
      atTop (𝓝 1) := by
  have logsmall : Tendsto (fun n : ℕ => Real.log (Real.log (leftIndex n) / Real.log n))
      atTop (𝓝 0) := by simpa using leftIndex_log_ratio.log (by norm_num)
  have h := (tendsto_const_nhds (x := (1:ℝ))).add (logsmall.mul inv_loglog_zero)
  simp only [zero_mul, add_zero] at h
  apply h.congr'
  filter_upwards [avoid] with n hn
  rw [Real.log_div (ne_of_gt (Real.log_pos hn.2.2.2)) (ne_of_gt (Real.log_pos hn.2.2.1))]
  field_simp [ne_of_gt (Real.log_pos hn.1)]

/-- The localized boundary term retains both the Euler product and the first
length moment. The prime estimates and the two finite inequalities are explicit. -/
theorem sharp_limit (H B G p : ℕ → ℝ) (c C : ℝ) (d : ℕ)
    (hC : 0 ≤ C) (pp : ∀ n, 0 < p n)
    (mertens : Tendsto (fun n : ℕ => H n / Real.log n) atTop (𝓝 c))
    (pnt : Tendsto (fun n : ℕ => p n / ((n:ℝ) * Real.log n)) atTop (𝓝 1))
    (mean : Tendsto (fun n : ℕ => B n / Real.log (Real.log n)) atTop (𝓝 1))
    (lower : ∀ᶠ n in atTop, H (leftIndex n)*B (leftIndex n)/p n - error C d n ≤ G n)
    (upper : ∀ᶠ n in atTop, G n ≤ H n*B n/p (leftIndex n) + error C d n) :
    Tendsto (fun n : ℕ => (n:ℝ)*G n/Real.log (Real.log n)) atTop (𝓝 c) := by
  have low := (((mertens.comp leftIndex_atTop).mul leftIndex_log_ratio).mul
    ((mean.comp leftIndex_atTop).mul left_loglog_ratio)).div pnt (by norm_num)
  have high := (mertens.mul mean).div
    (((pnt.comp leftIndex_atTop).mul leftIndex_ratio).mul leftIndex_log_ratio) (by norm_num)
  simp only [mul_one, div_one] at low high
  have low' : Tendsto (fun n : ℕ => n * (H (leftIndex n)*B (leftIndex n)/p n) /
      Real.log (Real.log n)) atTop (𝓝 c) := by
    apply low.congr'
    filter_upwards [avoid] with n hn
    dsimp
    field_simp [ne_of_gt (pp n), ne_of_gt (Real.log_pos hn.2.2.2),
      ne_of_gt (Real.log_pos hn.2.2.1), ne_of_gt (Real.log_pos hn.1),
      ne_of_gt (Real.log_pos hn.2.1), show (n:ℝ)≠0 by linarith [hn.2.2.1]]
    ring
  have high' : Tendsto (fun n : ℕ => n*(H n*B n/p (leftIndex n)) /
      Real.log (Real.log n)) atTop (𝓝 c) := by
    apply high.congr'
    filter_upwards [avoid] with n hn
    dsimp
    field_simp [ne_of_gt (pp _), ne_of_gt (Real.log_pos hn.2.2.2),
      ne_of_gt (Real.log_pos hn.2.2.1), ne_of_gt (Real.log_pos hn.1),
      show (n:ℝ) ≠ 0 by linarith [hn.2.2.1],
      show (leftIndex n:ℝ) ≠ 0 by linarith [hn.2.2.2]]
    ring
  have et := (error_small C d hC).mul inv_loglog_zero
  simp only [mul_zero] at et
  have lo := low'.sub et
  have hi := high'.add et
  simp only [sub_zero, add_zero] at lo hi
  apply tendsto_of_tendsto_of_tendsto_of_le_of_le' lo hi
  · filter_upwards [lower, avoid] with n h hn
    have hh := div_le_div_of_nonneg_right (mul_le_mul_of_nonneg_left h (Nat.cast_nonneg n : (0:ℝ)≤n))
      (Real.log_pos hn.1).le
    simpa only [mul_sub, sub_mul, div_eq_mul_inv] using hh
  · filter_upwards [upper, avoid] with n h hn
    have hh := div_le_div_of_nonneg_right (mul_le_mul_of_nonneg_left h (Nat.cast_nonneg n : (0:ℝ)≤n))
      (Real.log_pos hn.1).le
    simpa only [mul_add, add_mul, div_eq_mul_inv] using hh

#print axioms sharp_limit
end SharpLimit

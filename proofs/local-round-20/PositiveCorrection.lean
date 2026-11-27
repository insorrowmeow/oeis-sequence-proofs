import CumulativeLimit

namespace PositiveCorrection
open Filter Topology
noncomputable section

def x (n : ℕ) := Real.log n
def y (n : ℕ) := Real.log (x n)

private theorem x_top : Tendsto x atTop atTop :=
  Real.tendsto_log_atTop.comp tendsto_natCast_atTop_atTop
private theorem y_top : Tendsto y atTop atTop := Real.tendsto_log_atTop.comp x_top
private theorem positive_logs : ∀ᶠ n : ℕ in atTop, 0 < (n:ℝ) ∧ 0 < x n ∧ 0 < y n := by
  filter_upwards [eventually_gt_atTop 0, x_top.eventually_gt_atTop 0, y_top.eventually_gt_atTop 0]
    with n hn hx hy using ⟨by exact_mod_cast hn,hx,hy⟩

/-- A finite constant error in the two leading terms of p_n/n suffices
for the next term in log(p_n). -/
theorem log_prime_correction (p : ℕ → ℝ) (d : ℝ) (pp : ∀ n, 0 < p n)
    (cipolla : Tendsto (fun n : ℕ => p n / n - x n - y n) atTop (𝓝 d)) :
    Tendsto (fun n => (Real.log (p n) - (x n + y n)) * x n / y n) atTop (𝓝 1) := by
  let u (n : ℕ) := p n / n / x n
  let z (n : ℕ) := (u n - 1) * x n / y n
  have scale : Tendsto z atTop (𝓝 1) := by
    have h := (cipolla.mul (tendsto_inv_atTop_zero.comp y_top)).const_add 1
    simp only [mul_zero, add_zero] at h
    apply h.congr'
    filter_upwards [positive_logs] with n hn
    dsimp [z,u]
    field_simp [hn.1.ne', hn.2.1.ne', hn.2.2.ne']
    ring
  have small : Tendsto (fun n => y n / x n) atTop (𝓝 0) := by
    exact Real.isLittleO_log_id_atTop.tendsto_div_nhds_zero.comp x_top
  have u_one : Tendsto u atTop (𝓝 1) := by
    have h := (scale.mul small).const_add 1
    simp only [mul_zero, add_zero] at h
    apply h.congr'
    filter_upwards [positive_logs] with n hn
    dsimp [z]
    field_simp [hn.2.1.ne', hn.2.2.ne']
  have lower := scale.div u_one (by norm_num)
  simp only [div_one] at lower
  have squeeze : Tendsto (fun n => Real.log (u n) * x n / y n) atTop (𝓝 1) := by
    apply tendsto_of_tendsto_of_tendsto_of_le_of_le' lower scale
    · filter_upwards [positive_logs] with n hn
      have hu : 0 < u n := div_pos (div_pos (pp n) hn.1) hn.2.1
      have h := div_le_div_of_nonneg_right
        (mul_le_mul_of_nonneg_right (Real.one_sub_inv_le_log_of_pos hu) hn.2.1.le) hn.2.2.le
      apply le_trans _ h
      apply le_of_eq
      change (u n - 1)*x n/y n/u n = (1-(u n)⁻¹)*x n/y n
      field_simp [hu.ne', hn.2.2.ne']
      ring_nf
      simp
    · filter_upwards [positive_logs] with n hn
      have hu : 0 < u n := div_pos (div_pos (pp n) hn.1) hn.2.1
      exact div_le_div_of_nonneg_right
        (mul_le_mul_of_nonneg_right (Real.log_le_sub_one_of_pos hu) hn.2.1.le) hn.2.2.le
  apply squeeze.congr'
  filter_upwards [positive_logs] with n hn
  dsimp only [u]
  rw [Real.log_div (div_pos (pp n) hn.1).ne' hn.2.1.ne', Real.log_div (pp n).ne' hn.1.ne']
  dsimp [x,y]
  ring

theorem product_correction (H p : ℕ → ℝ) (c K : ℝ)
    (bound : ∀ᶠ n in atTop, |H n - c*Real.log (p n)| ≤ K / (x n)^2) :
    Tendsto (fun n => (H n - c*Real.log (p n))*x n/y n) atTop (𝓝 0) := by
  apply tendsto_zero_iff_norm_tendsto_zero.mpr
  have h := ((tendsto_inv_atTop_zero.comp x_top).mul
    (tendsto_inv_atTop_zero.comp y_top)).const_mul K
  simp only [mul_zero] at h
  apply tendsto_of_tendsto_of_tendsto_of_le_of_le' tendsto_const_nhds h
  · exact .of_forall fun _ => norm_nonneg _
  · filter_upwards [bound, positive_logs] with n hb hn
    rw [Real.norm_eq_abs, abs_div, abs_mul, abs_of_pos hn.2.1, abs_of_pos hn.2.2]
    apply (div_le_div_of_nonneg_right (mul_le_mul_of_nonneg_right hb hn.2.1.le) hn.2.2.le).trans
    apply le_of_eq
    dsimp
    field_simp [hn.2.1.ne', hn.2.2.ne']
    ring

/-- The strong prime estimates used for the positive correction also supply
both leading-order hypotheses used in the perimeter and boundary formulas. -/
theorem weak_inputs (H p : ℕ → ℝ) (c d K : ℝ) (pp : ∀ n, 0 < p n)
    (cipolla : Tendsto (fun n : ℕ => p n / n - x n - y n) atTop (𝓝 d))
    (prod : ∀ᶠ n in atTop, |H n - c*Real.log (p n)| ≤ K / (x n)^2) :
    Tendsto (fun n : ℕ => H n / Real.log n) atTop (𝓝 c) ∧
    Tendsto (fun n : ℕ => p n / ((n:ℝ) * Real.log n)) atTop (𝓝 1) := by
  have invx := tendsto_inv_atTop_zero.comp x_top
  have small : Tendsto (fun n => y n / x n) atTop (𝓝 0) :=
    Real.isLittleO_log_id_atTop.tendsto_div_nhds_zero.comp x_top
  have pnt : Tendsto (fun n : ℕ => p n / (n*x n)) atTop (𝓝 1) := by
    have h := ((cipolla.mul invx).add small).const_add 1
    simp only [mul_zero, add_zero] at h
    apply h.congr'
    filter_upwards [positive_logs] with n hn
    dsimp
    field_simp [hn.1.ne', hn.2.1.ne']
    ring
  refine ⟨?_,pnt⟩
  have logp : Tendsto (fun n => Real.log (p n) / x n) atTop (𝓝 1) := by
    have h0 : Tendsto (fun n : ℕ => Real.log (p n / (n*x n))) atTop (𝓝 0) := by
      simpa using pnt.log (by norm_num)
    have h := ((h0.mul invx).add small).const_add 1
    simp only [mul_zero, add_zero] at h
    apply h.congr'
    filter_upwards [positive_logs] with n hn
    dsimp
    rw [Real.log_div (pp n).ne' (mul_pos hn.1 hn.2.1).ne', Real.log_mul hn.1.ne' hn.2.1.ne']
    change 1+((Real.log (p n)-(x n+y n))*(x n)⁻¹+y n/x n) = Real.log (p n)/x n
    field_simp [hn.2.1.ne']
    ring
  have h := (((product_correction H p c K prod).mul small).mul invx).add (logp.const_mul c)
  simp only [zero_mul, mul_one, zero_add] at h
  apply h.congr'
  filter_upwards [positive_logs] with n hn
  change ((H n-c*Real.log (p n))*x n/y n)*(y n/x n)*(x n)⁻¹+c*(Real.log (p n)/x n) = H n/x n
  field_simp [hn.2.1.ne', hn.2.2.ne']

theorem correction (H W p : ℕ → ℝ) (c : ℝ)
    (prime : Tendsto (fun n => (Real.log (p n) - (x n + y n)) * x n / y n) atTop (𝓝 1))
    (prod : Tendsto (fun n => (H n - c*Real.log (p n))*x n/y n) atTop (𝓝 0))
    (gap : Tendsto (fun n : ℕ => n*(H n-W n)/y n) atTop (𝓝 c)) :
    Tendsto (fun n => (W n - CumulativeLimit.mainTerm c n)*x n/y n) atTop (𝓝 c) := by
  have hsmall : Tendsto (fun n : ℕ => x n / n) atTop (𝓝 0) :=
    Real.isLittleO_log_id_atTop.tendsto_div_nhds_zero.comp tendsto_natCast_atTop_atTop
  have h := (prod.add (prime.const_mul c)).sub (gap.mul hsmall)
  simp only [mul_zero, mul_one, zero_add, sub_zero] at h
  apply h.congr'
  filter_upwards [positive_logs] with n hn
  change _ + _ - _ = (W n - c * (x n + y n))*x n/y n
  field_simp [hn.1.ne', hn.2.2.ne']
  ring

theorem eventually_positive (W : ℕ → ℝ) {c : ℝ} (hc : 0 < c)
    (lim : Tendsto (fun n => (W n-CumulativeLimit.mainTerm c n)*x n/y n) atTop (𝓝 c)) :
    ∀ᶠ n in atTop, CumulativeLimit.mainTerm c n < W n := by
  filter_upwards [lim.eventually (lt_mem_nhds hc), positive_logs] with n h hn
  change 0 < (W n - CumulativeLimit.mainTerm c n)*x n/y n at h
  exact sub_pos.mp ((mul_pos_iff_of_pos_right hn.2.1).mp ((div_pos_iff_of_pos_right hn.2.2).mp h))

theorem from_prime_estimates (H W p : ℕ → ℝ) (c d K : ℝ) (hc : 0 < c)
    (pp : ∀ n, 0 < p n)
    (cipolla : Tendsto (fun n : ℕ => p n / n - x n - y n) atTop (𝓝 d))
    (product : ∀ᶠ n in atTop, |H n - c*Real.log (p n)| ≤ K / (x n)^2)
    (gap : Tendsto (fun n : ℕ => n*(H n-W n)/y n) atTop (𝓝 c)) :
    Tendsto (fun n => (W n - CumulativeLimit.mainTerm c n)*x n/y n) atTop (𝓝 c) ∧
      ∀ᶠ n in atTop, CumulativeLimit.mainTerm c n < W n := by
  have h := correction H W p c (log_prime_correction p d pp cipolla)
    (product_correction H p c K product) gap
  exact ⟨h, eventually_positive W hc h⟩

#print axioms from_prime_estimates
#print axioms weak_inputs
end
end PositiveCorrection

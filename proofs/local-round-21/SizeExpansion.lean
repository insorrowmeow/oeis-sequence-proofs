import SizeCutoffs

namespace SizeLimit
open Filter Topology
noncomputable section

/-- Keep the constant after the second term in log(p_n), by bounding the
logarithmic Taylor remainder with the two first-order logarithm inequalities. -/
theorem prime_log_second (p : ℕ→ℝ) (d : ℝ) (pp : ∀ n,0 < p n)
    (cipolla : Tendsto (fun n : ℕ => p n/n-L n-loglog n) atTop (𝓝 d)) :
    Tendsto (fun n => L n*(Real.log (p n)-L n-loglog n)-loglog n) atTop (𝓝 d) := by
  let a (n : ℕ) := p n/n-L n-loglog n
  let u (n : ℕ) := p n/n/L n
  have ai : Tendsto a atTop (𝓝 d) := cipolla
  have invL := tendsto_inv_atTop_zero.comp L_top
  have yl : Tendsto (fun n => loglog n/L n) atTop (𝓝 0) := by simpa using loglogpower_small 1
  have h := ((ai.mul invL).add yl).const_add 1
  simp only [mul_zero,add_zero] at h
  have hu : Tendsto u atTop (𝓝 1) := by
    apply h.congr'
    filter_upwards [positives] with n hn
    dsimp [u,a]
    field_simp [hn.1.ne',hn.2.1.ne']
    ring
  have hh := (((ai.pow 2).mul invL).add ((ai.mul yl).const_mul 2)).add (loglogpower_small 2)
  simp only [mul_zero, add_zero] at hh
  have hsquare : Tendsto (fun n => L n*(u n-1)^2) atTop (𝓝 0) := by
    apply hh.congr'
    filter_upwards [positives] with n hn
    dsimp [u,a]
    field_simp [hn.1.ne',hn.2.1.ne']
    ring
  have hsq := hsquare.div hu (by norm_num)
  simp only [zero_div] at hsq
  have low := ai.sub hsq
  rw [sub_zero] at low
  have between : Tendsto (fun n => L n*Real.log (u n)-loglog n) atTop (𝓝 d) := by
    apply tendsto_of_tendsto_of_tendsto_of_le_of_le' low ai
    · filter_upwards [positives] with n hn
      have hp := div_pos (div_pos (pp n) hn.1) hn.2.1
      have up : 0<u n := hp
      have hfirst := mul_le_mul_of_nonneg_left (Real.one_sub_inv_le_log_of_pos up) hn.2.1.le
      have ident : a n = L n*(u n-1)-loglog n := by
        dsimp [a,u]
        field_simp [hn.1.ne',hn.2.1.ne']
        ring
      change a n - L n*(u n-1)^2/u n ≤ _
      rw [ident]
      have eq : L n*(u n-1)-loglog n-L n*(u n-1)^2/u n =
        L n*(1-(u n)⁻¹)-loglog n := by field_simp [up.ne']; ring
      rw [eq]
      linarith
    · filter_upwards [positives] with n hn
      have up : 0<u n := div_pos (div_pos (pp n) hn.1) hn.2.1
      have hfirst := mul_le_mul_of_nonneg_left (Real.log_le_sub_one_of_pos up) hn.2.1.le
      have idn : L n*(u n-1)-loglog n = a n := by
        dsimp [a,u]
        field_simp [hn.1.ne',hn.2.1.ne']
        ring
      rw [← idn]
      linarith
  apply between.congr'
  filter_upwards [positives] with n hn
  rw [show Real.log (u n) = Real.log (p n)-L n-loglog n by
    exact (Real.log_div (div_pos (pp n) hn.1).ne' hn.2.1.ne').trans
      (by rw [Real.log_div (pp n).ne' hn.1.ne']; rfl)]

theorem product_second (H p : ℕ→ℝ) (c K : ℝ)
    (bound : ∀ᶠ n in atTop, |H n-c*Real.log (p n)| ≤ K/(L n)^2) :
    Tendsto (fun n => L n*(H n-c*Real.log (p n))) atTop (𝓝 0) := by
  apply tendsto_zero_iff_norm_tendsto_zero.mpr
  have hu := (tendsto_inv_atTop_zero.comp L_top).const_mul K
  rw [mul_zero] at hu
  apply tendsto_of_tendsto_of_tendsto_of_le_of_le' tendsto_const_nhds hu
  · exact .of_forall fun _ => norm_nonneg _
  · filter_upwards [bound,positives] with n hb hn
    rw [Real.norm_eq_abs,abs_mul,abs_of_pos hn.2.1]
    apply (mul_le_mul_of_nonneg_left hb hn.2.1.le).trans
    apply le_of_eq
    dsimp
    field_simp [hn.2.1.ne']
    ring

/-- The limit that isolates the coefficient at 1/log n in the cumulative
size expansion. For d=-1 and S=π²/12 it is -c*(1+π²/12). -/
theorem size_second (A H p : ℕ→ℝ) (c d K S : ℝ)
    (pp : ∀ n,0 < p n)
    (cipolla : Tendsto (fun n : ℕ => p n/n-L n-loglog n) atTop (𝓝 d))
    (prod : ∀ᶠ n in atTop, |H n-c*Real.log (p n)| ≤ K/(L n)^2)
    (gap : Tendsto (fun n => L n*(H n-A n)) atTop (𝓝 (c*S))) :
    Tendsto (fun n => L n*(A n-c*(L n+loglog n))-c*loglog n) atTop (𝓝 (c*(d-S))) := by
  have h := ((product_second H p c K prod).add ((prime_log_second p d pp cipolla).const_mul c)).sub gap
  rw [zero_add,← mul_sub] at h
  apply h.congr
  intro n
  dsimp
  ring

/-- A finite third-order coefficient implies both boundedness in the Figure 6
question and the eventual positive sign of the centered statistic. -/
theorem size_remainder {R : ℕ→ℝ} {c d : ℝ} (hc : 0 < c)
    (h : Tendsto (fun n => L n*R n-c*loglog n) atTop (𝓝 d)) :
    Tendsto R atTop (𝓝 0) ∧
      Tendsto (fun n => R n * L n / loglog n) atTop (𝓝 c) ∧ ∀ᶠ n in atTop, 0 < R n := by
  have hscaled := (h.mul (tendsto_inv_atTop_zero.comp loglog_top)).const_add c
  simp only [mul_zero,add_zero] at hscaled
  have hr : Tendsto (fun n => R n * L n/loglog n) atTop (𝓝 c) := by
    apply hscaled.congr'
    filter_upwards [positives] with n hn
    dsimp
    field_simp [hn.2.2.ne']
    ring
  have small : Tendsto (fun n => loglog n/L n) atTop (𝓝 0) := by simpa using loglogpower_small 1
  have h0 := hr.mul small
  simp only [mul_zero] at h0
  refine ⟨h0.congr' ?_, hr, ?_⟩
  · filter_upwards [positives] with n hn
    field_simp [hn.2.1.ne',hn.2.2.ne']
  · filter_upwards [positives,hr.eventually_const_lt hc] with n hn hz
    have hz' : 0 < R n * L n := (div_pos_iff_of_pos_right hn.2.2).mp hz
    exact pos_of_mul_pos_left hz' hn.2.1.le

/-- Recover both first-order inputs needed for the gap from the sharper
prime estimates used by the size expansion. The first limit is one-based. -/
theorem first_order_inputs (H p : ℕ→ℝ) (c d K : ℝ) (pp : ∀ n,0 < p n)
    (cipolla : Tendsto (fun n : ℕ => p n/n-L n-loglog n) atTop (𝓝 d))
    (prod : ∀ᶠ n in atTop, |H n - c*Real.log (p n)| ≤ K/(L n)^2) :
    Tendsto (fun n : ℕ => (n:ℝ)*Real.log n*(1/p n)) atTop (𝓝 1) ∧
    Tendsto (fun n => H n/L n) atTop (𝓝 c) := by
  have invL := tendsto_inv_atTop_zero.comp L_top
  have yl : Tendsto (fun n => loglog n/L n) atTop (𝓝 0) := by simpa using loglogpower_small 1
  have pp1 := ((cipolla.mul invL).add yl).const_add 1
  simp only [mul_zero,add_zero] at pp1
  have pp' : Tendsto (fun n : ℕ => p n/((n:ℝ)*L n)) atTop (𝓝 1) := by
    apply pp1.congr'
    filter_upwards [positives] with n hn
    dsimp
    field_simp [hn.1.ne',hn.2.1.ne']
    ring
  constructor
  · have h := pp'.inv₀ (by norm_num)
    simpa [Function.comp_def,inv_div,div_eq_mul_inv,L] using h
  · have hp : Tendsto (fun n => L n*(Real.log (p n)-L n-loglog n)-1*loglog n) atTop (𝓝 d) := by
      simpa only [one_mul] using prime_log_second p d pp cipolla
    have hzero := (size_remainder zero_lt_one hp).1
    have hlog := ((hzero.mul invL).add yl).const_add 1
    simp only [zero_mul,add_zero] at hlog
    have hlog' : Tendsto (fun n => Real.log (p n)/L n) atTop (𝓝 1) := by
      apply hlog.congr'
      filter_upwards [positives] with n hn
      dsimp
      field_simp [hn.2.1.ne']
    have h := ((product_second H p c K prod).mul (invL.pow 2)).add (hlog'.const_mul c)
    simp only [zero_mul,mul_one,zero_add] at h
    apply h.congr'
    filter_upwards [positives] with n hn
    dsimp
    field_simp [hn.2.1.ne']
    ring

#print axioms size_second
end
end SizeLimit


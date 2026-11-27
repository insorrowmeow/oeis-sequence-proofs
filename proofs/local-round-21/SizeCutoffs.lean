import Mathlib.Analysis.SpecificLimits.Normed
import Mathlib.Analysis.SpecialFunctions.Log.Basic
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.FieldSimp
import Mathlib.Tactic.GCongr
import Mathlib.Tactic.Ring
import Mathlib.Tactic.NormNum

namespace SizeLimit
open Filter Topology
noncomputable section

def L (n : ℕ) : ℝ := Real.log n
def loglog (n : ℕ) : ℝ := Real.log (L n)
def scale (k n : ℕ) : ℝ := n / (L n)^k
def b (n : ℕ) := ⌊scale 6 n⌋₊
def t (n : ℕ) := ⌈scale 3 n⌉₊
def m (n : ℕ) := n - t n

theorem L_top : Tendsto L atTop atTop := Real.tendsto_log_atTop.comp tendsto_natCast_atTop_atTop
theorem loglog_top : Tendsto loglog atTop atTop := Real.tendsto_log_atTop.comp L_top
theorem positives : ∀ᶠ n : ℕ in atTop, 0 < (n:ℝ) ∧ 0 < L n ∧ 0 < loglog n := by
  filter_upwards [eventually_gt_atTop 0, L_top.eventually_gt_atTop 0,
    loglog_top.eventually_gt_atTop 0] with n hn hL hy using ⟨by exact_mod_cast hn,hL,hy⟩

theorem scale_top (k : ℕ) : Tendsto (scale k) atTop atTop := by
  apply ((Real.tendsto_exp_div_pow_atTop k).comp L_top).congr'
  filter_upwards [positives] with n h using by simp [Function.comp_def,scale,L,Real.exp_log h.1]

theorem logpower_small (k : ℕ) : Tendsto (fun n : ℕ => (L n)^k / n) atTop (𝓝 0) := by
  simpa [scale,Function.comp_def] using tendsto_inv_atTop_zero.comp (scale_top k)

theorem loglogpower_small (k : ℕ) : Tendsto (fun n => (loglog n)^k/L n) atTop (𝓝 0) := by
  apply ((Real.tendsto_pow_mul_exp_neg_atTop_nhds_zero k).comp loglog_top).congr'
  filter_upwards [positives] with n hn using by
    simp [loglog,Function.comp_def,Real.exp_neg,Real.exp_log hn.2.1,div_eq_mul_inv]

theorem floor_ratio (f : ℕ → ℝ) (hf : Tendsto f atTop atTop) :
    Tendsto (fun n => (⌊f n⌋₊:ℝ)/f n) atTop (𝓝 1) := by
  have h := (tendsto_const_nhds (x:=(1:ℝ))).sub (tendsto_inv_atTop_zero.comp hf)
  rw [sub_zero] at h
  apply tendsto_of_tendsto_of_tendsto_of_le_of_le' h tendsto_const_nhds
  · filter_upwards [hf.eventually_gt_atTop 0] with n hn
    apply (le_div_iff₀ hn).2
    change (1-(f n)⁻¹)*f n ≤ _
    rw [sub_mul, one_mul, inv_mul_cancel₀ hn.ne']
    linarith [Nat.lt_floor_add_one (f n)]
  · filter_upwards [hf.eventually_gt_atTop 0] with n hn
    exact (div_le_one hn).2 (Nat.floor_le hn.le)

theorem ceil_ratio (f : ℕ → ℝ) (hf : Tendsto f atTop atTop) :
    Tendsto (fun n => (⌈f n⌉₊:ℝ)/f n) atTop (𝓝 1) := by
  have h := (tendsto_const_nhds (x:=(1:ℝ))).add (tendsto_inv_atTop_zero.comp hf)
  rw [add_zero] at h
  apply tendsto_of_tendsto_of_tendsto_of_le_of_le' tendsto_const_nhds h
  · filter_upwards [hf.eventually_gt_atTop 0] with n hn
    exact (one_le_div hn).2 (Nat.le_ceil _)
  · filter_upwards [hf.eventually_gt_atTop 0] with n hn
    apply (div_le_iff₀ hn).2
    change _ ≤ (1+(f n)⁻¹)*f n
    rw [add_mul, one_mul, inv_mul_cancel₀ hn.ne']
    exact (Nat.ceil_lt_add_one hn.le).le

theorem b_ratio : Tendsto (fun n => (b n:ℝ)/scale 6 n) atTop (𝓝 1) :=
  floor_ratio _ (scale_top 6)
theorem t_ratio : Tendsto (fun n => (t n:ℝ)/scale 3 n) atTop (𝓝 1) :=
  ceil_ratio _ (scale_top 3)

theorem b_top : Tendsto b atTop atTop := by
  apply tendsto_atTop.2
  intro k
  filter_upwards [(scale_top 6).eventually_ge_atTop (k:ℝ)] with n hn using Nat.le_floor hn

theorem b_small : Tendsto (fun n : ℕ => (b n:ℝ)/n) atTop (𝓝 0) := by
  have h := b_ratio.mul ((tendsto_inv_atTop_zero.comp L_top).pow 6)
  simp only [zero_pow (by decide : 6 ≠ 0), mul_zero] at h
  apply h.congr'
  filter_upwards [positives] with n hn
  dsimp [scale]
  field_simp [hn.1.ne',hn.2.1.ne']
  ring

theorem cutoffs_low : Tendsto (fun n => (L n)^2 * (b n:ℝ)/(t n:ℝ)) atTop (𝓝 0) := by
  have h := (b_ratio.div t_ratio (by norm_num)).mul (tendsto_inv_atTop_zero.comp L_top)
  simp only [mul_zero] at h
  apply h.congr'
  filter_upwards [positives, (scale_top 3).eventually_gt_atTop 0] with n hn ht
  have htn : (0:ℝ) < t n := lt_of_lt_of_le ht (Nat.le_ceil _)
  dsimp [scale]
  field_simp [hn.1.ne',hn.2.1.ne',htn.ne']
  ring

theorem cutoff_single : Tendsto (fun n : ℕ => (L n)^2 * (t n:ℝ)/n) atTop (𝓝 0) := by
  have h := t_ratio.mul (tendsto_inv_atTop_zero.comp L_top)
  simp only [mul_zero] at h
  apply h.congr'
  filter_upwards [positives] with n hn
  dsimp [scale]
  field_simp [hn.1.ne',hn.2.1.ne']
  ring

theorem cutoff_repeat : Tendsto (fun n => (L n)^2 / (b n:ℝ)) atTop (𝓝 0) := by
  have h := (logpower_small 8).div b_ratio (by norm_num)
  simp only [zero_div] at h
  apply h.congr'
  filter_upwards [positives, b_top.eventually_gt_atTop 0] with n hn hb
  have hb' : (0:ℝ) < b n := by exact_mod_cast hb
  dsimp [scale]
  field_simp [hn.1.ne',hn.2.1.ne',hb'.ne']
  ring

theorem cutoff_triple : Tendsto (fun n => (L n)^2 * (loglog n / L n)^3) atTop (𝓝 0) := by
  apply (loglogpower_small 3).congr'
  filter_upwards [positives] with n hn
  field_simp [hn.2.1.ne']
  ring

theorem t_small : Tendsto (fun n : ℕ => (t n:ℝ)/n) atTop (𝓝 0) := by
  have h := t_ratio.mul ((tendsto_inv_atTop_zero.comp L_top).pow 3)
  simp only [zero_pow (by decide : 3 ≠ 0), mul_zero] at h
  apply h.congr'
  filter_upwards [positives] with n hn
  dsimp [scale]
  field_simp [hn.1.ne',hn.2.1.ne']
  ring

theorem t_lt : ∀ᶠ n : ℕ in atTop, t n < n := by
  filter_upwards [positives, t_small.eventually_lt_const (show (0:ℝ)<1 by norm_num)] with n hn ht
  exact_mod_cast (div_lt_one hn.1).mp ht

theorem m_ratio : Tendsto (fun n : ℕ => (m n:ℝ)/n) atTop (𝓝 1) := by
  have h := (tendsto_const_nhds (x:=(1:ℝ))).sub t_small
  rw [sub_zero] at h
  apply h.congr'
  filter_upwards [positives,t_lt] with n hn ht
  dsimp [m]
  rw [Nat.cast_sub ht.le]
  field_simp [hn.1.ne']

theorem m_top : Tendsto m atTop atTop := by
  have h := (tendsto_natCast_atTop_atTop (R := ℝ)).atTop_mul_const (by norm_num : (0:ℝ)<1/2)
  apply tendsto_atTop.2
  intro k
  filter_upwards [positives,h.eventually_ge_atTop (k:ℝ),
    m_ratio.eventually_const_lt (by norm_num : (1/2:ℝ)<1)] with n hn hk hm
  have h' := (lt_div_iff₀ hn.1).mp hm
  change (k:ℝ) ≤ (n:ℝ) * (1/2) at hk
  exact_mod_cast (show (k:ℝ)≤m n by linarith)

theorem log_b_ratio : Tendsto (fun n => Real.log (b n)/L n) atTop (𝓝 1) := by
  have hlog : Tendsto (fun n => Real.log ((b n:ℝ)/scale 6 n)) atTop (𝓝 0) := by
    simpa using b_ratio.log (by norm_num)
  have small : Tendsto (fun n => loglog n / L n) atTop (𝓝 0) :=
    Real.isLittleO_log_id_atTop.tendsto_div_nhds_zero.comp L_top
  have h := ((hlog.mul (tendsto_inv_atTop_zero.comp L_top)).const_add 1).sub (small.const_mul 6)
  simp only [mul_zero,add_zero,sub_zero] at h
  apply h.congr'
  filter_upwards [positives,b_top.eventually_gt_atTop 0] with n hn hb
  have hb' : (0:ℝ) < b n := by exact_mod_cast hb
  have hp := pow_pos hn.2.1 6
  dsimp only [Pi.sub_apply,Pi.mul_apply,Function.comp_apply]
  rw [scale,Real.log_div hb'.ne' (div_pos hn.1 hp).ne']
  rw [Real.log_div hn.1.ne' hp.ne',Real.log_pow]
  change 1+ (Real.log (b n)-(L n-6*loglog n))*(L n)⁻¹-6*(loglog n/L n) = _
  field_simp [hn.2.1.ne']
  ring

/-- Every choice of an index in the large-part block has the same asymptotic weight. -/
theorem prime_weight {q : ℕ → ℝ}
    (pnt : Tendsto (fun j : ℕ => (j:ℝ)*Real.log j*q j) atTop (𝓝 1))
    {i : ℕ → ℕ} (hlo : ∀ᶠ n in atTop, b n ≤ i n) (hhi : ∀ᶠ n in atTop, i n ≤ n) :
    Tendsto (fun n => (i n:ℝ)*L n*q (i n)) atTop (𝓝 1) := by
  have itop : Tendsto i atTop atTop := tendsto_atTop_mono' atTop hlo b_top
  have rat : Tendsto (fun n => Real.log (i n)/L n) atTop (𝓝 1) := by
    apply tendsto_of_tendsto_of_tendsto_of_le_of_le' log_b_ratio tendsto_const_nhds
    · filter_upwards [positives,hlo,b_top.eventually_gt_atTop 0] with n hn hI hb
      exact div_le_div_of_nonneg_right (Real.log_le_log (by exact_mod_cast hb) (by exact_mod_cast hI)) hn.2.1.le
    · filter_upwards [positives,hhi,itop.eventually_gt_atTop 0] with n hn hI hi
      exact (div_le_one hn.2.1).mpr (Real.log_le_log (by exact_mod_cast hi) (by exact_mod_cast hI))
  have h := (pnt.comp itop).div rat (by norm_num)
  simp only [div_one] at h
  apply h.congr'
  filter_upwards [positives,itop.eventually_gt_atTop 1] with n hn hi
  have hx : (1:ℝ) < i n := by exact_mod_cast hi
  dsimp [Function.comp_def]
  field_simp [hn.2.1.ne',(Real.log_pos hx).ne']
  ring

theorem b_le : ∀ᶠ n : ℕ in atTop, b n ≤ n := by
  filter_upwards [positives,b_small.eventually_lt_const (show (0:ℝ)<1 by norm_num)] with n hn hb
  exact_mod_cast ((div_lt_one hn.1).mp hb).le

theorem b_over_m : Tendsto (fun n => (b n:ℝ)/(m n:ℝ)) atTop (𝓝 0) := by
  have h := b_small.div m_ratio (by norm_num)
  simp only [zero_div] at h
  apply h.congr'
  filter_upwards [positives] with n hn
  exact div_div_div_cancel_right₀ hn.1.ne' _ _

private def choices (n : ℕ) := Finset.Icc (b n) (max (b n) n)
private theorem choices_ne (n : ℕ) : (choices n).Nonempty :=
  ⟨b n,Finset.mem_Icc.mpr ⟨le_rfl,le_max_left _ _⟩⟩
private def weighted (q : ℕ→ℝ) (n i : ℕ) := (i:ℝ)*L n*q i
private def imin (q : ℕ→ℝ) (n : ℕ) :=
  ((choices n).exists_min_image (weighted q n) (choices_ne n)).choose
private def imax (q : ℕ→ℝ) (n : ℕ) :=
  ((choices n).exists_max_image (weighted q n) (choices_ne n)).choose
def lowerWeight (q : ℕ→ℝ) (n : ℕ) := weighted q n (imin q n)
def upperWeight (q : ℕ→ℝ) (n : ℕ) := weighted q n (imax q n)

theorem weight_envelope (q : ℕ→ℝ) {i n : ℕ} (hbi : b n ≤ i) (hin : i≤n) :
    lowerWeight q n ≤ (i:ℝ)*L n*q i ∧ (i:ℝ)*L n*q i ≤ upperWeight q n := by
  have mem : i ∈ choices n := Finset.mem_Icc.mpr ⟨hbi,hin.trans (le_max_right _ _)⟩
  exact ⟨((choices n).exists_min_image (weighted q n) (choices_ne n)).choose_spec.2 i mem,
    ((choices n).exists_max_image (weighted q n) (choices_ne n)).choose_spec.2 i mem⟩

theorem weight_envelope_limit {q : ℕ→ℝ}
    (pnt : Tendsto (fun j : ℕ => (j:ℝ)*Real.log j*q j) atTop (𝓝 1)) :
    Tendsto (lowerWeight q) atTop (𝓝 1) ∧ Tendsto (upperWeight q) atTop (𝓝 1) := by
  have both {i : ℕ→ℕ} (hi : ∀ n, i n ∈ choices n) :
      Tendsto (fun n => (i n:ℝ)*L n*q (i n)) atTop (𝓝 1) := by
    apply prime_weight pnt
    · exact .of_forall fun n => (Finset.mem_Icc.mp (hi n)).1
    · filter_upwards [b_le] with n hn
      exact (Finset.mem_Icc.mp (hi n)).2.trans (max_le hn le_rfl)
  exact ⟨both (fun n => ((choices n).exists_min_image (weighted q n) (choices_ne n)).choose_spec.1),
    both (fun n => ((choices n).exists_max_image (weighted q n) (choices_ne n)).choose_spec.1)⟩

theorem log_width : Tendsto (fun n : ℕ => Real.log ((n:ℝ)/(b n:ℝ)) / loglog n) atTop (𝓝 6) := by
  have hlog : Tendsto (fun n => Real.log ((b n:ℝ)/scale 6 n)) atTop (𝓝 0) := by
    simpa using b_ratio.log (by norm_num)
  have h := (tendsto_const_nhds (x:=(6:ℝ))).sub (hlog.mul (tendsto_inv_atTop_zero.comp loglog_top))
  simp only [zero_mul,sub_zero] at h
  apply h.congr'
  filter_upwards [positives,b_top.eventually_gt_atTop 0] with n hn hb
  have hb' : (0:ℝ)< b n := by exact_mod_cast hb
  have hp := pow_pos hn.2.1 6
  dsimp only [Pi.sub_apply,Pi.mul_apply,Function.comp_apply]
  rw [scale,Real.log_div hb'.ne' (div_pos hn.1 hp).ne',Real.log_div hn.1.ne' hp.ne',
    Real.log_pow,Real.log_div hn.1.ne' hb'.ne']
  change 6-(Real.log (b n)-(L n-6*loglog n))*(loglog n)⁻¹ = (L n-Real.log (b n))/_
  field_simp [hn.2.2.ne']
  ring

end
end SizeLimit

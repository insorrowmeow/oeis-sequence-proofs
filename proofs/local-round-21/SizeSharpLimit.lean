import SizeCutoffs
import Triangle

namespace SizeLimit
open Finset Filter Topology SizeTriangle
noncomputable section

private theorem pair_scale (a : ℝ) (w : ℕ→ℝ) (k N : ℕ) :
    pairSum (fun i => a*w i) k N = a^2 * pairSum w k N := by
  unfold pairSum
  simp only [mul_sum]
  apply sum_congr rfl
  intro i hi
  apply sum_congr rfl
  intro j hj
  split_ifs <;> ring

private theorem pair_mono {w v : ℕ→ℝ} {k N : ℕ}
    (hw : ∀ i, k < i → i ≤ N → 0≤w i) (hv : ∀ i, k < i → i≤N → w i≤v i) :
    pairSum w k N ≤ pairSum v k N := by
  apply sum_le_sum
  intro i hi
  apply sum_le_sum
  intro j hj
  have hi' := mem_range.mp hi
  have hj' := mem_range.mp hj
  split_ifs with h
  · exact mul_le_mul (hv _ h.1 (by omega)) (hv _ (by omega) (by omega))
      (hw _ (by omega) (by omega)) ((hw _ h.1 (by omega)).trans (hv _ h.1 (by omega)))
  · rfl

theorem weighted_pair_limit {q : ℕ→ℝ} (hq : ∀ j, 0≤q j)
    (pnt : Tendsto (fun j : ℕ => (j:ℝ)*Real.log j*q j) atTop (𝓝 1))
    (N : ℕ→ℕ) (S : ℝ) (hN : Tendsto N atTop atTop) (hcap : ∀ n,N n ≤ n)
    (hb : Tendsto (fun n => (b n:ℝ)/(N n:ℝ)) atTop (𝓝 0))
    (hs : HasSum (fun i => recip i^2) S) :
    Tendsto (fun n => (L n)^2 * pairSum q (b n) (N n)) atTop (𝓝 (S/2)) := by
  have ht := pair_limit b N S hN hb hs
  obtain ⟨hl,hu⟩ := weight_envelope_limit pnt
  have low := (hl.pow 2).mul ht
  have high := (hu.pow 2).mul ht
  simp only [one_pow,one_mul] at low high
  apply tendsto_of_tendsto_of_tendsto_of_le_of_le' low high
  · filter_upwards [positives,hl.eventually_const_lt (by norm_num : (0:ℝ)<1)] with n hn hlo
    change (lowerWeight q n)^2 * pairSum recip (b n) (N n) ≤ _
    rw [← pair_scale, ← pair_scale]
    apply pair_mono
    · intro i _ _
      unfold recip
      positivity
    · intro i hI hi
      have hin : (0:ℝ)< i := by exact_mod_cast (show 0< i by omega)
      rw [recip, ← div_eq_mul_inv, div_le_iff₀ hin]
      simpa only [mul_comm _ (i:ℝ),mul_assoc] using (weight_envelope q hI.le (hi.trans (hcap _))).1
  · filter_upwards [positives] with n hn
    change _ ≤ (upperWeight q n)^2 * pairSum recip (b n) (N n)
    rw [← pair_scale, ← pair_scale]
    apply pair_mono
    · intro i _ _
      exact mul_nonneg hn.2.1.le (hq i)
    · intro i hI hi
      have hin : (0:ℝ)< i := by exact_mod_cast (show 0< i by omega)
      rw [recip, ← div_eq_mul_inv, le_div_iff₀ hin]
      simpa only [mul_comm _ (i:ℝ),mul_assoc] using (weight_envelope q hI.le (hi.trans (hcap _))).2

/-- Total probability weights in the large-index block (one-based indices). -/
def mass (q : ℕ→ℝ) (a n : ℕ) : ℝ := ∑ j ∈ Ioc a n, q j

theorem recip_mass_bound {a n : ℕ} (ha : 0<a) (han : a≤n) :
    mass recip a n ≤ Real.log n - Real.log a := by
  induction n,han using Nat.le_induction with
  | base => simp [mass]
  | succ n han ih =>
    have hp : (0:ℝ)<n := by exact_mod_cast ha.trans_le han
    have hpos : (0:ℝ)<(n:ℝ)+1 := by positivity
    have hle := Real.log_le_sub_one_of_pos (div_pos hp hpos)
    rw [Real.log_div hp.ne' hpos.ne'] at hle
    have hstep : ((n:ℝ)+1)⁻¹ ≤ Real.log ((n:ℝ)+1) - Real.log n := by
      have hid : (n:ℝ)/((n:ℝ)+1) - 1 = -((n:ℝ)+1)⁻¹ := by
        field_simp [hpos.ne']
      linarith [hid]
    have eq : Ioc a (n+1) = insert (n+1) (Ioc a n) := by ext x; simp; omega
    rw [mass, eq, sum_insert (by simp)]
    change recip (n+1) + mass recip a n ≤ _
    simp only [recip,Nat.cast_add,Nat.cast_one]
    linarith

theorem mass_bound {q : ℕ→ℝ}
    (pnt : Tendsto (fun j : ℕ => (j:ℝ)*Real.log j*q j) atTop (𝓝 1)) :
    ∀ᶠ n : ℕ in atTop, mass q (b n) n ≤ 14 * loglog n / L n := by
  obtain ⟨_,hu⟩ := weight_envelope_limit pnt
  filter_upwards [positives,hu.eventually_lt_const (by norm_num : (1:ℝ)<2),
    log_width.eventually_lt_const (by norm_num : (6:ℝ)<7),b_le,b_top.eventually_gt_atTop 0]
    with n hn hmax hlog hbn hbp
  have hlo : (0:ℝ)< b n := by exact_mod_cast hbp
  have hbound : L n * mass q (b n) n ≤ 2 * mass recip (b n) n := by
    simp only [mass,mul_sum]
    apply sum_le_sum
    intro j hj
    obtain ⟨hj₀,hj₁⟩ := Finset.mem_Ioc.mp hj
    have hj' : (0:ℝ)<j := by exact_mod_cast hbp.trans hj₀
    rw [recip,← div_eq_mul_inv,le_div_iff₀ hj']
    have he := (weight_envelope q hj₀.le hj₁).2.trans hmax.le
    linarith only [show (L n*q j)*(j:ℝ) ≤ 2 by simpa [mul_comm,mul_left_comm,mul_assoc] using he]
  have hlog' := (div_lt_iff₀ hn.2.2).mp hlog
  rw [Real.log_div hn.1.ne' hlo.ne'] at hlog'
  rw [le_div_iff₀ hn.2.1]
  linarith [recip_mass_bound hbp hbn]

theorem mass_small {q : ℕ→ℝ} (hq : ∀ j,0≤q j)
    (pnt : Tendsto (fun j : ℕ => (j:ℝ)*Real.log j*q j) atTop (𝓝 1)) :
    Tendsto (fun n => mass q (b n) n) atTop (𝓝 0) := by
  have h : Tendsto (fun n => loglog n/L n) atTop (𝓝 0) :=
    Real.isLittleO_log_id_atTop.tendsto_div_nhds_zero.comp L_top
  have hc := h.const_mul 14
  simp only [mul_zero] at hc
  apply tendsto_of_tendsto_of_tendsto_of_le_of_le' tendsto_const_nhds hc
  · exact .of_forall fun _ => sum_nonneg fun i _ => hq i
  · filter_upwards [mass_bound pnt] with n hn
    simpa only [mul_div_assoc] using hn

theorem mass_cube_small {q : ℕ→ℝ}
    (hq : ∀ j,0≤q j)
    (pnt : Tendsto (fun j : ℕ => (j:ℝ)*Real.log j*q j) atTop (𝓝 1)) :
    Tendsto (fun n => (L n)^2*(mass q (b n) n)^3) atTop (𝓝 0) := by
  have h := cutoff_triple.const_mul (14^3:ℝ)
  simp only [mul_zero] at h
  apply tendsto_of_tendsto_of_tendsto_of_le_of_le' tendsto_const_nhds h
  · exact .of_forall fun n => mul_nonneg (sq_nonneg _) (pow_nonneg (sum_nonneg fun i _ => hq i) _)
  · filter_upwards [mass_bound pnt] with n hn
    calc
      _ ≤ (L n)^2 *(14 * loglog n / L n)^3 :=
        mul_le_mul_of_nonneg_left (pow_le_pow_left₀ (sum_nonneg fun i _ => hq i) hn _) (sq_nonneg _)
      _ = _ := by ring

theorem single_over_m : Tendsto (fun n => (L n)^2 * (t n:ℝ)/(m n:ℝ)) atTop (𝓝 0) := by
  have h := cutoff_single.div m_ratio (by norm_num)
  simp only [zero_div] at h
  apply h.congr'
  filter_upwards [positives] with n hn
  exact div_div_div_cancel_right₀ hn.1.ne' _ _

/-- Analytic conclusion of the probability bounds for independent geometric
multiplicities. The cutoff error and both weighted triangular sums are evaluated here. -/
theorem sharp_limit {q : ℕ→ℝ} (hq : ∀ j,0≤q j)
    (pnt : Tendsto (fun j : ℕ => (j:ℝ)*Real.log j*q j) atTop (𝓝 1))
    (D : ℕ→ℝ) (S : ℝ) (hs : HasSum (fun i => recip i^2) S)
    (lower : ∀ᶠ n in atTop, (1-mass q (b n) n)*pairSum q (b n) n ≤ D n)
    (upper : ∀ᶠ n in atTop, D n ≤ pairSum q (b n) (m n)
      + (b n:ℝ)/(t n:ℝ) + (t n:ℝ)/(m n:ℝ) + 1/(b n:ℝ) + (mass q (b n) n)^3) :
    Tendsto (fun n => (L n)^2 * D n) atTop (𝓝 (S/2)) := by
  have lo := (tendsto_const_nhds (x:=(1:ℝ))).sub (mass_small hq pnt)
  have a := weighted_pair_limit hq pnt id S tendsto_id (fun _ => le_rfl) b_small hs
  have z := weighted_pair_limit hq pnt m S m_top (fun n => Nat.sub_le n _) b_over_m hs
  have low := lo.mul a
  have high := (((z.add cutoffs_low).add single_over_m).add cutoff_repeat).add (mass_cube_small hq pnt)
  simp only [sub_zero,one_mul] at low
  simp only [add_zero] at high
  apply tendsto_of_tendsto_of_tendsto_of_le_of_le' low high
  · filter_upwards [lower] with n hn
    change (1-mass q (b n) n)*((L n)^2 * pairSum q (b n) n) ≤ _
    simpa only [mul_left_comm] using mul_le_mul_of_nonneg_left hn (sq_nonneg (L n))
  · filter_upwards [upper] with n hn
    change _ ≤ ((((L n)^2 * pairSum q (b n) (m n) + (L n)^2 * b n/t n) +
      (L n)^2 * t n/m n) + (L n)^2/b n) + (L n)^2*(mass q (b n) n)^3
    simpa only [mul_add, ← mul_div_assoc,mul_one] using mul_le_mul_of_nonneg_left hn (sq_nonneg (L n))

theorem weighted_gap {D H : ℕ→ℝ} {S c : ℝ}
    (hD : Tendsto (fun n => (L n)^2 * D n) atTop (𝓝 S))
    (hH : Tendsto (fun n => H n / L n) atTop (𝓝 c)) :
    Tendsto (fun n => L n*(H n*D n)) atTop (𝓝 (c*S)) := by
  apply (hH.mul hD).congr'
  filter_upwards [positives] with n hn

  field_simp [hn.2.1.ne']
  ring

#print axioms sharp_limit
end
end SizeLimit


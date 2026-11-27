import Mathlib.Analysis.SpecificLimits.Normed
import Mathlib.Analysis.SpecialFunctions.Log.Basic
import Mathlib.Data.Nat.Sqrt
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.FieldSimp
import Mathlib.Tactic.GCongr
import Mathlib.Tactic.Ring
import Mathlib.Tactic.NormNum

/-! Square-root localization for a reciprocal-supernorm perimeter sum.
The analytic inputs are the two classical prime asymptotics written in
the hypotheses of `perimeter_limit`. The remaining hypotheses are the
two finite window bounds, with a polynomial-exponential error. -/

open Filter Topology
namespace PerimeterLimit

def leftIndex (n : ℕ) := n - n.sqrt
noncomputable def error (C : ℝ) (d n : ℕ) : ℝ :=
  C * ((n:ℝ)+1)^d / (3/2:ℝ)^n.sqrt

theorem sqrt_atTop : Tendsto Nat.sqrt atTop atTop := by
  apply tendsto_atTop.2
  intro k
  filter_upwards [eventually_ge_atTop (k*k)] with n hn
  exact Nat.le_sqrt.mpr hn

theorem leftIndex_atTop : Tendsto leftIndex atTop atTop := by
  apply tendsto_atTop.2
  intro k
  filter_upwards [(sqrt_atTop.eventually (eventually_ge_atTop (k+2)))] with n hn
  have h := Nat.sqrt_le n
  change k+2 ≤ n.sqrt at hn
  unfold leftIndex
  have hx : k+n.sqrt ≤ n.sqrt*n.sqrt := by nlinarith
  omega

theorem leftIndex_ratio :
    Tendsto (fun n : ℕ => (leftIndex n : ℝ) / n) atTop (𝓝 1) := by
  have small : Tendsto (fun n : ℕ => (n.sqrt:ℝ)/(n:ℝ)) atTop (𝓝 0) := by
    apply tendsto_of_tendsto_of_tendsto_of_le_of_le' tendsto_const_nhds
      (tendsto_one_div_atTop_nhds_zero_nat.comp sqrt_atTop)
    · exact .of_forall fun n => by positivity
    · filter_upwards [eventually_ge_atTop 1] with n hn
      have h1 : (0:ℝ) < n := by exact_mod_cast (show 0<n by omega)
      have h2 : (0:ℝ) < n.sqrt := by exact_mod_cast Nat.sqrt_pos.mpr (show 0<n by omega)
      change _ ≤ 1/(n.sqrt:ℝ)
      rw [div_le_div_iff₀ h1 h2, one_mul]
      exact_mod_cast Nat.sqrt_le n
  have h := (tendsto_const_nhds (x:=(1:ℝ))).sub small
  rw [sub_zero] at h
  apply h.congr'
  filter_upwards [eventually_ge_atTop 1] with n hn
  have h1 : (n:ℝ) ≠ 0 := by exact_mod_cast (show n ≠ 0 by omega)
  simp only [Pi.sub_apply, leftIndex, Nat.cast_sub (Nat.sqrt_le_self n)]
  field_simp

theorem leftIndex_log_ratio :
    Tendsto (fun n : ℕ => Real.log (leftIndex n) / Real.log n) atTop (𝓝 1) := by
  have logsmall : Tendsto (fun n : ℕ => Real.log ((leftIndex n:ℝ)/n)) atTop (𝓝 0) := by
    simpa using leftIndex_ratio.log (by norm_num)
  have hinv : Tendsto (fun n : ℕ => (Real.log (n:ℝ))⁻¹) atTop (𝓝 0) :=
    tendsto_inv_atTop_zero.comp (Real.tendsto_log_atTop.comp tendsto_natCast_atTop_atTop)
  have h := (tendsto_const_nhds (x:=(1:ℝ))).add (logsmall.mul hinv)
  have h' : Tendsto (fun n : ℕ => 1 + Real.log ((leftIndex n:ℝ)/n) * (Real.log n)⁻¹)
      atTop (𝓝 1) := by simpa using h
  apply h'.congr'
  filter_upwards [eventually_ge_atTop 2,
    (leftIndex_atTop.eventually (eventually_ge_atTop 1))] with n hn hk
  have yn : (1:ℝ) < n := by exact_mod_cast (show 1<n by omega)
  have yk : (leftIndex n:ℝ) ≠ 0 := by exact_mod_cast (show leftIndex n ≠ 0 by change 1 ≤ leftIndex n at hk; omega)
  rw [Real.log_div yk (by linarith)]
  field_simp [ne_of_gt (Real.log_pos yn)]

theorem error_small (C : ℝ) (d : ℕ) (hC : 0≤C) :
    Tendsto (fun n : ℕ => (n:ℝ) * error C d n) atTop (𝓝 0) := by
  let t := 2*(d+1)
  have h := ((tendsto_pow_const_div_const_pow_of_one_lt t (r:=(3/2:ℝ)) (by norm_num)).comp
    sqrt_atTop).const_mul (C * 2^t)
  have hu : Tendsto (fun n : ℕ => (C*2^t)*((n.sqrt:ℝ)^t/(3/2:ℝ)^n.sqrt))
      atTop (𝓝 0) := by simpa [Function.comp_def] using h
  apply tendsto_of_tendsto_of_tendsto_of_le_of_le' tendsto_const_nhds hu
  · exact .of_forall fun n => by dsimp [error]; positivity
  · filter_upwards [eventually_ge_atTop 1] with n hn
    have hs : (1:ℝ) ≤ n.sqrt := by exact_mod_cast Nat.sqrt_pos.mpr (show 0<n by omega)
    have hsq : (n:ℝ)+1 ≤ ((n.sqrt:ℝ)+1)^2 := by exact_mod_cast Nat.succ_le_succ_sqrt' n
    have hbound : (n:ℝ)+1 ≤ (2*(n.sqrt:ℝ))^2 := by
      apply hsq.trans
      gcongr
      linarith
    have hpow : (n:ℝ)*((n:ℝ)+1)^d ≤ (2*(n.sqrt:ℝ))^t := by
      calc
        _ ≤ ((n:ℝ)+1)^d * ((n:ℝ)+1) := by
          rw [mul_comm (n:ℝ)]
          gcongr
          linarith
        _ = ((n:ℝ)+1)^(d+1) := (pow_succ _ _).symm
        _ ≤ ((2*(n.sqrt:ℝ))^2)^(d+1) := by gcongr
        _ = _ := (pow_mul ..).symm
    unfold error
    rw [mul_div_assoc' (n:ℝ), mul_div_assoc']
    apply div_le_div_of_nonneg_right _ (by positivity)
    rw [mul_pow] at hpow
    nlinarith [mul_le_mul_of_nonneg_left hpow hC]

theorem perimeter_limit (W H p : ℕ → ℝ) (c C : ℝ) (d : ℕ)
    (hC : 0 ≤ C) (pp : ∀ n, 0 < p n)
    (mertens : Tendsto (fun n : ℕ => H n / Real.log n) atTop (𝓝 c))
    (pnt : Tendsto (fun n : ℕ => p n / ((n:ℝ) * Real.log n)) atTop (𝓝 1))
    (lower : ∀ᶠ n in atTop, H (leftIndex n) / p n - error C d n ≤ W n)
    (upper : ∀ᶠ n in atTop, W n ≤ H n / p (leftIndex n) + error C d n) :
    Tendsto (fun n : ℕ => (n:ℝ) * W n) atTop (𝓝 c) := by
  have avoid : ∀ᶠ n : ℕ in atTop, (1:ℝ)<n ∧ (1:ℝ)<leftIndex n := by
    filter_upwards [eventually_ge_atTop 2,leftIndex_atTop.eventually (eventually_ge_atTop 2)]
      with n hn hk
    change 2 ≤ leftIndex n at hk
    exact ⟨by exact_mod_cast (show 1<n by omega),by exact_mod_cast (show 1<leftIndex n by omega)⟩
  have low : Tendsto (fun n : ℕ => (n:ℝ)* (H (leftIndex n)/p n)) atTop (𝓝 c) := by
    have h := ((mertens.comp leftIndex_atTop).mul leftIndex_log_ratio).div pnt (by norm_num)
    simp only [mul_one,div_one] at h
    apply h.congr'
    filter_upwards [avoid] with n hn
    simp only [Pi.div_apply, Pi.mul_apply, Function.comp_apply]
    field_simp [ne_of_gt (Real.log_pos hn.1),ne_of_gt (Real.log_pos hn.2),
      ne_of_gt (pp n), show (n:ℝ)≠0 by linarith [hn.1]]
    ring
  have high : Tendsto (fun n : ℕ => (n:ℝ)* (H n/p (leftIndex n))) atTop (𝓝 c) := by
    have h := mertens.div (((pnt.comp leftIndex_atTop).mul leftIndex_ratio).mul leftIndex_log_ratio)
      (by norm_num)
    simp only [mul_one,div_one] at h
    apply h.congr'
    filter_upwards [avoid] with n hn
    simp only [Pi.div_apply, Pi.mul_apply, Function.comp_apply]
    field_simp [ne_of_gt (Real.log_pos hn.1),ne_of_gt (Real.log_pos hn.2),
      ne_of_gt (pp _), show (n:ℝ)≠0 by linarith [hn.1],
      show (leftIndex n:ℝ)≠0 by linarith [hn.2]]
    ring
  have l := low.sub (error_small C d hC)
  have u := high.add (error_small C d hC)
  simp only [sub_zero,add_zero] at l u
  apply tendsto_of_tendsto_of_tendsto_of_le_of_le' l u
  · filter_upwards [lower] with n hn
    simpa [mul_sub] using mul_le_mul_of_nonneg_left hn (Nat.cast_nonneg n : (0:ℝ)≤n)
  · filter_upwards [upper] with n hn
    simpa [mul_add] using mul_le_mul_of_nonneg_left hn (Nat.cast_nonneg n : (0:ℝ)≤n)

#print axioms perimeter_limit
end PerimeterLimit

import SizeFinite
import Mathlib.Analysis.Asymptotics.SpecificAsymptotics
import Mathlib.Analysis.SpecialFunctions.Log.Basic
import Mathlib.Data.Nat.Prime.Nth
import Mathlib.Data.Nat.PrimeFin
import Mathlib.NumberTheory.Harmonic.Defs

namespace SizeEnsemble
open Finset Filter Topology
noncomputable section

/-- Fixed relative window, convenient for taking n to infinity first and k second. -/
theorem fixed_window {q : ℕ → ℝ} (hq : ∀ i, 0 ≤ q i) (hq' : ∀ i, q i < 1)
    (K : ℝ) (hK0 : 0 ≤ K) (hK : ∀ j : ℕ, (j+1:ℝ)*(q j*H q (j+1)) ≤ K)
    (n k : ℕ) (hn : 0<n) (hk : 2≤k) :
    gap q n n ≤ (k:ℝ)*((n:ℝ)⁻¹ * ∑ j ∈ range n, q j*moment q (j+1)) + 2*K/k := by
  let r := n/k
  have hr : r≤n := Nat.div_le_self n k
  have hk' : 0<k := by omega
  have hn' : (0:ℝ)<n := by exact_mod_cast hn
  have hk0 : (0:ℝ)<k := by exact_mod_cast hk'
  have hkr : k*r≤n := by simpa [r,Nat.mul_comm] using Nat.div_mul_le_self n k
  have hnr : n < k*(r+1) := by
    have hdiv := Nat.div_add_mod n k
    have hm := Nat.mod_lt n hk'
    change n < k * (n/k+1)
    rw [Nat.mul_add, Nat.mul_one]
    omega
  have hwidth : (n:ℝ) ≤ (k:ℝ)*((r:ℝ)+1) := by exact_mod_cast hnr.le
  have hkR : (k:ℝ)*r ≤ n := by exact_mod_cast hkr
  have h2 : (2:ℝ) ≤ k := by exact_mod_cast hk
  have hrest : 2*((n-r:ℕ):ℝ) ≥ n := by
    rw [Nat.cast_sub hr]
    nlinarith [mul_le_mul_of_nonneg_right h2 (Nat.cast_nonneg r : (0:ℝ)≤r)]
  apply (window hq hq' K hK n r hr).trans
  apply add_le_add
  · rw [div_eq_inv_mul, ← mul_assoc]
    apply mul_le_mul_of_nonneg_right _ (sum_nonneg fun j _ => mul_nonneg (hq j) (moment_nonneg hq hq' _))
    rw [← div_eq_mul_inv, le_div_iff₀ hn', inv_mul_eq_div, div_le_iff₀ (by positivity)]
    exact hwidth
  · apply (div_le_div_iff₀ (by positivity) hk0).mpr
    nlinarith [mul_le_mul_of_nonneg_right hkR hK0, mul_le_mul_of_nonneg_right hrest hK0]

/-- General cumulative gap limit from a bounded shell and vanishing mean size
per index. The diagonal uses all canonical weighted partitions of total size ≤n. -/
theorem vanishing_gap {q : ℕ → ℝ} (hq : ∀ i, 0 ≤ q i) (hq' : ∀ i, q i < 1)
    (K : ℝ) (hK0 : 0 ≤ K) (hK : ∀ j : ℕ, (j+1:ℝ)*(q j*H q (j+1)) ≤ K)
    (small : Tendsto (fun j => q j * moment q (j+1)) atTop (𝓝 0)) :
    Tendsto (fun n => gap q n n) atTop (𝓝 0) := by
  apply tendsto_order.mpr
  constructor
  · intro b hb
    exact .of_forall fun n => hb.trans_le (gap_nonneg hq hq' n n)
  · intro b hb
    obtain ⟨k₀,hk₀⟩ := exists_nat_gt (4*K/b)
    let k := k₀ + 2
    have hk : (2:ℕ)≤k := by dsimp only [k]; omega
    have hkpos : (0:ℝ)<k := by exact_mod_cast (show 0<k by omega)
    have hk' : 4*K/b<(k:ℝ) := hk₀.trans_le (by dsimp [k]; push_cast; linarith)
    have hconst : 2*K/(k:ℝ)<b/2 := by
      rw [div_lt_iff₀ hkpos]
      have := (div_lt_iff₀ hb).mp hk'
      nlinarith
    have hsmall := small.cesaro.const_mul (k:ℝ)
    rw [mul_zero] at hsmall
    filter_upwards [hsmall.eventually_lt_const (show 0<b/2 by linarith), eventually_ge_atTop 1]
      with n hn hn'
    exact (fixed_window hq hq' K hK0 hK n k hn' hk).trans_lt (by linarith)



/-- The prime estimates used here are the nth-prime theorem and the
first-order reciprocal Mertens product. The function p is one-based. -/
theorem gap_limit (p : ℕ → ℝ) (c : ℝ) (hp : ∀ n : ℕ, 1 < p (n+1))
    (mertens : Tendsto (fun n : ℕ => H (fun j => 1/p (j+1)) n / Real.log n) atTop (𝓝 c))
    (pnt : Tendsto (fun n : ℕ => p n / ((n:ℝ)*Real.log n)) atTop (𝓝 1)) :
    Tendsto (fun n => gap (fun j => 1/p (j+1)) n n) atTop (𝓝 0) := by
  let q := fun j => 1/p (j+1)
  have hq : ∀ j, 0 ≤ q j := fun j => div_nonneg zero_le_one (by linarith [hp j])
  have hq' : ∀ j, q j < 1 := fun j => (div_lt_one (by linarith [hp j])).2 (hp j)
  have avoid : ∀ᶠ n : ℕ in atTop, (0:ℝ) < n ∧ 0<Real.log n ∧ 0<p n := by
    filter_upwards [eventually_ge_atTop 2] with n hn
    have hn' : (1:ℝ)<n := by exact_mod_cast (show 1<n by omega)
    have pp := hp (n-1)
    rw [Nat.sub_add_cancel (show 1≤n by omega)] at pp
    exact ⟨by linarith, Real.log_pos hn', by linarith⟩
  have log_top : Tendsto (fun n : ℕ => Real.log n) atTop atTop :=
    Real.tendsto_log_atTop.comp tendsto_natCast_atTop_atTop
  have ninv : Tendsto (fun n : ℕ => (n:ℝ)⁻¹) atTop (𝓝 0) :=
    tendsto_inv_atTop_zero.comp tendsto_natCast_atTop_atTop
  have shell : Tendsto (fun n : ℕ => n * ((1/p n)*H q n)) atTop (𝓝 c) := by
    have h := mertens.div pnt (by norm_num)
    rw [div_one] at h
    apply h.congr'
    filter_upwards [avoid] with n hn
    change (H q n/Real.log n)/(p n/(n*Real.log n)) = _
    field_simp [hn.1.ne', hn.2.1.ne', hn.2.2.ne']
    ring
  have rn : Tendsto (fun n : ℕ => (n:ℝ)/p n) atTop (𝓝 0) := by
    have h := (tendsto_inv_atTop_zero.comp log_top).div pnt (by norm_num)
    rw [zero_div] at h
    apply h.congr'
    filter_upwards [avoid] with n hn
    change (Real.log n)⁻¹/(p n/(n*Real.log n)) = _
    field_simp [hn.1.ne', hn.2.1.ne', hn.2.2.ne']
  have pr : Tendsto (fun n : ℕ => 1/p n) atTop (𝓝 0) := by
    have h := ninv.mul rn
    rw [mul_zero] at h
    apply h.congr'
    filter_upwards [avoid] with n hn
    field_simp [hn.1.ne', hn.2.2.ne']
  have hterm : Tendsto (fun j : ℕ => (j+1:ℝ)*q j/(1-q j)) atTop (𝓝 0) := by
    have den := tendsto_const_nhds.sub pr (a := (1:ℝ))
    rw [sub_zero] at den
    have h := (rn.div den (by norm_num)).comp (tendsto_add_atTop_nat 1)
    rw [zero_div] at h
    simpa [q,mul_one_div, Function.comp_def] using h
  let B := fun j : ℕ => (j+1:ℝ)*(q j*H q (j+1))
  have hB : Tendsto B atTop (𝓝 c) := by
    simpa [B, q, Function.comp_def] using shell.comp (tendsto_add_atTop_nat 1)
  obtain ⟨N,hN⟩ := eventually_atTop.mp (hB.eventually_lt_const (show c<c+1 by linarith))
  let K := max (c+1) (∑ i ∈ range N, B i)
  have hK' : ∀ j, B j ≤ K := by
    intro j
    by_cases hj : N≤j
    · exact (hN _ hj).le.trans (le_max_left ..)
    · apply le_trans _ (le_max_right ..)
      exact single_le_sum (f := B) (fun i _ => mul_nonneg (by positivity) (mul_nonneg (hq _) (H_nonneg hq' _)))
        (mem_range.mpr (by omega))
  have K0 : 0≤K := by
    apply le_trans _ (hK' 0)
    exact mul_nonneg (by positivity) (mul_nonneg (hq _) (H_nonneg hq' _))
  have hav : Tendsto (fun n : ℕ => (n:ℝ)⁻¹ * mean q n) atTop (𝓝 0) := hterm.cesaro
  have hh := hB.mul (hav.comp (tendsto_add_atTop_nat 1))
  rw [mul_zero] at hh
  apply vanishing_gap hq hq' K K0 hK'
  apply hh.congr'
  exact .of_forall fun j => by
    change ((j+1:ℝ)*(q j*H q (j+1)))*((↑(j+1:ℕ):ℝ)⁻¹*mean q (j+1)) = q j * moment q (j+1)
    push_cast
    rw [moment]
    field_simp
    ring

#print axioms gap_limit


/-- The actual one-based prime sequence. Its padding value at zero never
appears as the index of a part. -/
def primeAt (n : ℕ) : ℝ := Nat.nth Nat.Prime (n-1)

def qPrime (j : ℕ) : ℝ := 1/primeAt (j+1)

/-- The standard defining limit of Euler's constant in mathlib. -/
def eulerGamma : ℝ := limUnder atTop (fun n : ℕ => (harmonic n : ℝ) - Real.log ((n:ℝ)+1))

def literalSize (n : ℕ) : ℝ := ∑ xs ∈ parts n n, 1 / (xs.map primeAt).prod

theorem C_eq_literal (n : ℕ) : C qPrime n n = literalSize n := by
  apply sum_congr rfl
  intro xs hx
  have hall : ∀ a ∈ xs, 0<a := fun a ha => ((mem_parts xs n n).mp hx).2.2 a ha |>.1
  clear hx
  induction xs with
  | nil => simp [weight]
  | cons a xs ih =>
    have ha : 0<a := hall a (by simp)
    change qPrime (a-1)*weight qPrime xs = 1/(primeAt a*(xs.map primeAt).prod)
    rw [qPrime, show a-1+1=a by omega, ih (fun b hb => hall b (List.mem_cons_of_mem _ hb))]
    simp [one_div, mul_comm]

theorem prime_gt_one (n : ℕ) : 1 < primeAt (n+1) := by
  have hp : Nat.Prime (Nat.nth Nat.Prime n) := Nat.nth_mem_of_infinite Nat.infinite_setOf_prime n
  simpa only [primeAt, Nat.add_sub_cancel] using
    (show (1:ℝ) < (Nat.nth Nat.Prime n : ℝ) by exact_mod_cast hp.one_lt)

def center (c : ℝ) (n : ℕ) := c*(Real.log n + Real.log (Real.log n))

/-- Zero additive size remainder for the statistic of the original paper.
Inputs are the authors' Theorem 3.2 and the prime number theorem. -/
theorem size_remainder_zero
    (mertens : Tendsto (fun n : ℕ => H qPrime n - center (Real.exp eulerGamma) n) atTop (𝓝 0))
    (pnt : Tendsto (fun n : ℕ => primeAt n/((n:ℝ)*Real.log n)) atTop (𝓝 1)) :
    Tendsto (fun n : ℕ => literalSize n - center (Real.exp eulerGamma) n) atTop (𝓝 0) := by
  let c := Real.exp eulerGamma
  have hx : Tendsto (fun n : ℕ => Real.log n) atTop atTop :=
    Real.tendsto_log_atTop.comp tendsto_natCast_atTop_atTop
  have hy : Tendsto (fun n : ℕ => Real.log (Real.log n) / Real.log n) atTop (𝓝 0) :=
    Real.isLittleO_log_id_atTop.tendsto_div_nhds_zero.comp hx
  have hweak : Tendsto (fun n : ℕ => H qPrime n / Real.log n) atTop (𝓝 c) := by
    have t := (mertens.mul (tendsto_inv_atTop_zero.comp hx)).add
      ((hy.const_add 1).const_mul c)
    simp only [mul_zero, add_zero, mul_one, zero_add] at t
    apply t.congr'
    filter_upwards [hx.eventually_gt_atTop 0] with n hn
    change (H qPrime n - c*(Real.log n + Real.log (Real.log n))) * (Real.log n)⁻¹ +
      c*(1 + Real.log (Real.log n)/Real.log n) = _
    field_simp [ne_of_gt hn]
  have hgap := gap_limit primeAt c prime_gt_one hweak pnt
  have h := mertens.sub hgap
  rw [sub_zero] at h
  apply h.congr'
  exact .of_forall fun n => by
    change (H qPrime n-center _ n)-(H qPrime n-C qPrime n n) = _
    rw [C_eq_literal]
    ring

#print axioms size_remainder_zero

end
end SizeEnsemble

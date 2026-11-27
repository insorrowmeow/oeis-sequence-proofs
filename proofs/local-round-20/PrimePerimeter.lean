import PerimeterPartitions
import PerimeterLimit
import PerimeterCumulative
import CumulativeLimit
import SharpFinite
import SharpLimit
import MeanLimit
import PositiveCorrection
import Mathlib.Data.Nat.Prime.Nth
import Mathlib.Data.Nat.PrimeFin
import Mathlib.NumberTheory.Harmonic.Defs

namespace PrimePerimeter

open Filter
open scoped Topology BigOperators
noncomputable section

/-- The defining limit used for Real.eulerMascheroniConstant in mathlib 4.19. -/
def eulerGamma : ℝ := limUnder atTop (fun n : ℕ => (harmonic n : ℝ) - Real.log ((n:ℝ)+1))

/-- One-based prime indexing. The padding value p(0) = 2 is never a part. -/
def primeAt (n : ℕ) : ℝ := Nat.nth Nat.Prime (n-1)

theorem primeAt_mono : Monotone primeAt := by
  intro i j hij
  unfold primeAt
  exact_mod_cast Nat.nth_monotone (p := Nat.Prime) Nat.infinite_setOf_prime (Nat.sub_le_sub_right hij 1)

theorem prime_lower (j : ℕ) : (j:ℝ)+2 ≤ primeAt (j+1) := by
  have h : j+2 ≤ Nat.nth Nat.Prime j := by
    induction j with
    | zero => simp
    | succ j ih =>
      have hnext : Nat.nth Nat.Prime j < Nat.nth Nat.Prime (j+1) :=
        Nat.nth_strictMono (p := Nat.Prime) Nat.infinite_setOf_prime (Nat.lt_succ_self j)
      omega
  simpa [primeAt] using (show ((j:ℝ)+2) ≤ (Nat.nth Nat.Prime j : ℝ) by exact_mod_cast h)

theorem prime_pos (j : ℕ) : 0 < primeAt j := by
  have h := primeAt_mono (Nat.zero_le j)
  have : primeAt 0 = 2 := by simp [primeAt]
  linarith

def productAt := PerimeterFinite.euler (fun j => 1 / primeAt (j+1))

/-- At the length marker 3/2, the entire product grows at most quadratically. -/
theorem tilted_product (m : ℕ) :
    PerimeterFinite.euler (fun j => (3/2:ℝ) * (1 / primeAt (j+1))) m ≤ ((m:ℝ)+1)^2 := by
  induction m with
  | zero => simp [PerimeterFinite.euler]
  | succ m ih =>
    simp only [PerimeterFinite.euler, Finset.prod_range_succ] at ih ⊢
    have hp := prime_lower m
    have hpos := prime_pos (m+1)
    have hd : 0 < 1 - (3/2:ℝ) * (1 / primeAt (m+1)) := by
      rw [mul_one_div, sub_pos, div_lt_one hpos]
      linarith [(Nat.cast_nonneg m : (0:ℝ) ≤ m)]
    apply (mul_le_mul_of_nonneg_right ih (inv_nonneg.mpr hd.le)).trans
    rw [← div_eq_mul_inv, div_le_iff₀ hd, mul_one_div]
    push_cast
    field_simp [ne_of_gt hpos]
    apply (le_div_iff₀ (show 0 < 2 * primeAt (m+1) by positivity)).2
    nlinarith [mul_nonneg (sub_nonneg.mpr hp)
      (show 0 ≤ 2*(m:ℝ)+3 by positivity), sq_nonneg (m:ℝ), (Nat.cast_nonneg m : (0:ℝ) ≤ m)]

/-- Lagarias–Sun's exact-perimeter coefficient statistic, from the two
classical prime estimates stated explicitly as hypotheses. -/
theorem conjecture_3_6
    (mertens : Tendsto (fun n : ℕ => productAt n / Real.log n) atTop
      (𝓝 (Real.exp eulerGamma)))
    (pnt : Tendsto (fun n : ℕ => primeAt n / ((n:ℝ) * Real.log n)) atTop (𝓝 1)) :
    Tendsto (fun n : ℕ => (n:ℝ) * PerimeterFinite.shell primeAt n) atTop
      (𝓝 (Real.exp eulerGamma)) := by
  have hb : ∀ᶠ n : ℕ in atTop,
      productAt (PerimeterLimit.leftIndex n) / primeAt n - PerimeterLimit.error 1 2 n
        ≤ PerimeterFinite.shell primeAt n ∧
      PerimeterFinite.shell primeAt n ≤ productAt n / primeAt (PerimeterLimit.leftIndex n)
        + PerimeterLimit.error 1 2 n := by
    filter_upwards [eventually_ge_atTop 2] with n hn
    have hp (j : ℕ) : (3/2:ℝ) < primeAt (j+1) := by
      linarith [prime_lower j, (Nat.cast_nonneg j : (0:ℝ) ≤ j)]
    simpa [productAt, PerimeterLimit.leftIndex, PerimeterLimit.error] using
      PerimeterFinite.quadratic_sandwich primeAt_mono hp tilted_product (Nat.sqrt_lt_self hn)
  exact PerimeterLimit.perimeter_limit _ _ _ _ 1 2 (by norm_num) prime_pos mertens pnt
    (hb.mono fun _ h => h.1) (hb.mono fun _ h => h.2)

/-- The empty partition has perimeter one under the convention of the paper. -/
def exactPerimeter (n : ℕ) : ℝ :=
  (if n = 1 then 1 else 0) +
  ∑ x ∈ PerimeterFinite.perimeterParts n, 1 / PerimeterFinite.indexedNorm primeAt x

theorem literal_perimeter_limit
    (mertens : Tendsto (fun n : ℕ => productAt n / Real.log n) atTop
      (𝓝 (Real.exp eulerGamma)))
    (pnt : Tendsto (fun n : ℕ => primeAt n / ((n:ℝ)*Real.log n)) atTop (𝓝 1)) :
    Tendsto (fun n : ℕ => (n:ℝ) * exactPerimeter n) atTop
      (𝓝 (Real.exp eulerGamma)) := by
  apply (conjecture_3_6 mertens pnt).congr'
  filter_upwards [eventually_ge_atTop 2] with n hn
  simp [exactPerimeter, show n ≠ 1 by omega, PerimeterFinite.shell_eq_perimeter_sum]

#print axioms literal_perimeter_limit

/-- The cumulative statistic with per(empty)=1, including the value at zero. -/
def cumulativePerimeter (n : ℕ) : ℝ :=
  if n = 0 then 0 else
    ∑ x ∈ PerimeterFinite.cumulativeParts n, 1 / PerimeterFinite.indexedNorm primeAt x

theorem cumulative_eq {n : ℕ} (hn : 0 < n) :
    cumulativePerimeter n = PerimeterFinite.cumulative (fun j => 1 / primeAt (j+1)) n := by
  rw [cumulativePerimeter, if_neg (Nat.ne_of_gt hn)]
  exact (PerimeterFinite.cumulative_eq_norm_sum primeAt n).symm

/-- The correction contemplated immediately after Theorem 3.3 converges to
zero. The sole external hypothesis is the o(1) consequence of the authors'
Theorem 3.2 for the finite Mertens product. -/
theorem correction_zero
    (mertens : Tendsto (fun n => productAt n -
      CumulativeLimit.mainTerm (Real.exp eulerGamma) n) atTop (𝓝 0)) :
    Tendsto (fun n => cumulativePerimeter n -
      CumulativeLimit.mainTerm (Real.exp eulerGamma) n) atTop (𝓝 0) := by
  let q := fun j => 1 / primeAt (j+1)
  have hq (j : ℕ) : 0 ≤ q j := div_nonneg zero_le_one (prime_pos _).le
  have hq' (j : ℕ) : q j < 1 :=
    (div_lt_one (prime_pos _)).mpr (by linarith [prime_lower j, (Nat.cast_nonneg j : (0:ℝ) ≤ j)])
  have hqr (j : ℕ) : (3/2:ℝ) * q j < 1 := by
    dsimp only [q]
    rw [mul_one_div, div_lt_one (prime_pos _)]
    linarith [prime_lower j, (Nat.cast_nonneg j : (0:ℝ) ≤ j)]
  have hb : ∀ᶠ n : ℕ in atTop, productAt (PerimeterLimit.leftIndex n) -
      PerimeterLimit.error 1 2 n ≤ cumulativePerimeter n ∧ cumulativePerimeter n ≤ productAt n := by
    filter_upwards [eventually_ge_atTop 1] with n hn
    have hL := Nat.sqrt_le_self n
    have h := PerimeterFinite.cumulative_bounds hq hq' hL
    have ht := PerimeterFinite.tail_le_tilt (by norm_num : (1:ℝ) ≤ 3/2) hq hq' hqr (n-n.sqrt) n.sqrt
    have hmn : ((n-n.sqrt:ℕ):ℝ) ≤ n := by exact_mod_cast Nat.sub_le n n.sqrt
    have hp : ((n-n.sqrt:ℕ):ℝ) + 1 ≤ (n:ℝ)+1 := by linarith
    have he : PerimeterFinite.tail q (n-n.sqrt) n.sqrt ≤ PerimeterLimit.error 1 2 n := by
      apply ht.trans
      simp only [PerimeterLimit.error, one_mul]
      apply div_le_div_of_nonneg_right _ (by positivity)
      exact (tilted_product _).trans (by gcongr)
    rw [cumulative_eq hn]
    exact ⟨(sub_le_sub_left he _).trans h.1, h.2⟩
  exact CumulativeLimit.cumulative_limit _ _ _ 1 2 (by norm_num) mertens
    (hb.mono fun _ h => h.1) (hb.mono fun _ h => h.2)

#print axioms correction_zero

/-- The alternative convention retaining only nonempty partitions. -/
def nonemptyCumulative (n : ℕ) : ℝ :=
  ∑ x ∈ (PerimeterFinite.cumulativeParts n).erase [], 1 / PerimeterFinite.indexedNorm primeAt x

theorem correction_nonempty
    (mertens : Tendsto (fun n => productAt n -
      CumulativeLimit.mainTerm (Real.exp eulerGamma) n) atTop (𝓝 0)) :
    Tendsto (fun n => nonemptyCumulative n -
      CumulativeLimit.mainTerm (Real.exp eulerGamma) n) atTop (𝓝 (-1)) := by
  have h := (correction_zero mertens).sub_const 1
  rw [zero_sub] at h
  apply h.congr'
  filter_upwards [eventually_ge_atTop 1] with n hn
  have hs := Finset.sum_erase_add (PerimeterFinite.cumulativeParts n)
    (fun x => 1 / PerimeterFinite.indexedNorm primeAt x) (PerimeterFinite.nil_mem_cumulativeParts n)
  have hx : nonemptyCumulative n + 1 = cumulativePerimeter n := by
    rw [cumulativePerimeter, if_neg (show n ≠ 0 by omega)]
    simpa only [nonemptyCumulative, PerimeterFinite.indexedNorm, List.map_nil, List.prod_nil,
      div_one] using hs
  linarith

#print axioms correction_nonempty

def meanAt := PerimeterFinite.meanLength (fun j => 1 / primeAt (j+1))

theorem gap_limit_of_mean
    (mertens : Tendsto (fun n : ℕ => productAt n / Real.log n) atTop (𝓝 (Real.exp eulerGamma)))
    (pnt : Tendsto (fun n : ℕ => primeAt n / ((n:ℝ)*Real.log n)) atTop (𝓝 1))
    (mean : Tendsto (fun n : ℕ => meanAt n / Real.log (Real.log n)) atTop (𝓝 1)) :
    Tendsto (fun n : ℕ => (n:ℝ)*(productAt n - cumulativePerimeter n)/Real.log (Real.log n))
      atTop (𝓝 (Real.exp eulerGamma)) := by
  have hb : ∀ᶠ n : ℕ in atTop,
      productAt (PerimeterLimit.leftIndex n)*meanAt (PerimeterLimit.leftIndex n)/primeAt n -
        PerimeterLimit.error 3 2 n ≤ productAt n - cumulativePerimeter n ∧
      productAt n - cumulativePerimeter n ≤ productAt n*meanAt n/primeAt (PerimeterLimit.leftIndex n) +
        PerimeterLimit.error 3 2 n := by
    filter_upwards [eventually_ge_atTop 2] with n hn
    rw [cumulative_eq (show 0<n by omega)]
    exact PerimeterFinite.sharp_finite primeAt_mono prime_lower tilted_product hn
  exact SharpLimit.sharp_limit _ _ _ _ _ 3 2 (by norm_num) prime_pos mertens pnt mean
    (hb.mono fun _ h => h.1) (hb.mono fun _ h => h.2)

#print axioms gap_limit_of_mean

/-- Normalized boundary gap, from the same two prime estimates as the
exact-perimeter asymptotic. No further prime-sum limit is assumed. -/
theorem boundary_gap_limit
    (mertens : Tendsto (fun n : ℕ => productAt n / Real.log n) atTop (𝓝 (Real.exp eulerGamma)))
    (pnt : Tendsto (fun n : ℕ => primeAt n / ((n:ℝ)*Real.log n)) atTop (𝓝 1)) :
    Tendsto (fun n : ℕ => (n:ℝ)*(productAt n - cumulativePerimeter n)/Real.log (Real.log n))
      atTop (𝓝 (Real.exp eulerGamma)) :=
  gap_limit_of_mean mertens pnt (MeanLimit.mean_limit primeAt _ (Real.exp_pos _) prime_lower mertens)

#print axioms boundary_gap_limit

/-- The leading correction and its eventual sign for the literal partition
sum. The two hypotheses follow respectively from Cipolla's nth-prime
expansion and the effective reciprocal Mertens estimate. -/
theorem correction_positive (K : ℝ)
    (cipolla : Tendsto (fun n : ℕ => primeAt n / n - Real.log n - Real.log (Real.log n))
      atTop (𝓝 (-1)))
    (mertens : ∀ᶠ n : ℕ in atTop, |productAt n - Real.exp eulerGamma * Real.log (primeAt n)| ≤
      K/(Real.log n)^2) :
    Tendsto (fun n : ℕ => (cumulativePerimeter n -
      CumulativeLimit.mainTerm (Real.exp eulerGamma) n) * Real.log n / Real.log (Real.log n))
      atTop (𝓝 (Real.exp eulerGamma)) ∧
    ∀ᶠ n : ℕ in atTop, CumulativeLimit.mainTerm (Real.exp eulerGamma) n < cumulativePerimeter n := by
  obtain ⟨hM, hP⟩ := PositiveCorrection.weak_inputs productAt primeAt (Real.exp eulerGamma)
    (-1) K prime_pos cipolla mertens
  exact PositiveCorrection.from_prime_estimates productAt cumulativePerimeter primeAt _
    (-1) K (Real.exp_pos _) prime_pos cipolla mertens (boundary_gap_limit hM hP)

#print axioms correction_positive
end
end PrimePerimeter

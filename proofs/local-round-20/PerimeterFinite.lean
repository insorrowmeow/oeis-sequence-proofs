import Mathlib.Analysis.SpecificLimits.Normed
import Mathlib.Topology.Algebra.InfiniteSum.Real
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.Ring

/-! Weighted partitions with parts in 1,...,m, marked by their length.
The recurrence selects the multiplicity of the largest allowed part. -/

namespace PerimeterFinite

open Finset
open scoped BigOperators

noncomputable section

def coeff (q : ℕ → ℝ) : ℕ → ℕ → ℝ
  | 0, l => if l = 0 then 1 else 0
  | m+1, l => ∑ j ∈ range (l+1), q m ^ j * coeff q m (l-j)

def euler (q : ℕ → ℝ) (m : ℕ) : ℝ := ∏ j ∈ range m, (1-q j)⁻¹

def shell (p : ℕ → ℝ) (n : ℕ) : ℝ :=
  ∑ l ∈ range n, coeff (fun j => 1 / p (j+1)) (n-l) l / p (n-l)

theorem coeff_nonneg {q : ℕ → ℝ} (hq : ∀ j, 0 ≤ q j) (m l : ℕ) :
    0 ≤ coeff q m l := by
  induction m generalizing l with
  | zero => simp only [coeff]; split <;> norm_num
  | succ m ih => exact sum_nonneg fun j _ => mul_nonneg (pow_nonneg (hq m) _) (ih _)

theorem coeff_mono {q : ℕ → ℝ} (hq : ∀ j, 0 ≤ q j) (l : ℕ) :
    Monotone (fun m => coeff q m l) := by
  apply monotone_nat_of_le_succ
  intro m
  change coeff q m l ≤ ∑ j ∈ range (l+1), q m ^ j * coeff q m (l-j)
  simpa using single_le_sum (f := fun j => q m ^ j * coeff q m (l-j))
    (fun j _ => mul_nonneg (pow_nonneg (hq m) _) (coeff_nonneg hq _ _))
    (show 0 ∈ range (l+1) by simp)

theorem coeff_tilt (q : ℕ → ℝ) (r : ℝ) (m l : ℕ) :
    coeff (fun j => r * q j) m l = r ^ l * coeff q m l := by
  induction m generalizing l with
  | zero => by_cases h : l = 0 <;> simp [coeff, h]
  | succ m ih =>
    simp only [coeff, mul_sum]
    apply sum_congr rfl
    intro j hj
    have hj' : j ≤ l := by simpa [Nat.lt_succ_iff] using hj
    have E : r ^ l = r ^ j * r ^ (l-j) := by rw [← pow_add, Nat.add_sub_of_le hj']
    rw [ih, mul_pow, E]
    ring

theorem coeff_hasSum {q : ℕ → ℝ} (hq : ∀ j, 0 ≤ q j) (hq' : ∀ j, q j < 1) (m : ℕ) :
    HasSum (coeff q m) (euler q m) := by
  induction m with
  | zero =>
    simpa [coeff, euler] using (hasSum_ite_eq (0 : ℕ) (1 : ℝ))
  | succ m ih =>
    have hg := hasSum_geometric_of_lt_one (hq m) (hq' m)
    have hgn : Summable (fun j : ℕ => ‖q m ^ j‖) := by
      simpa only [Real.norm_eq_abs, abs_of_nonneg (pow_nonneg (hq m) _)] using hg.summable
    have hin : Summable (fun j => ‖coeff q m j‖) := by
      simpa only [Real.norm_eq_abs, abs_of_nonneg (coeff_nonneg hq _ _)] using ih.summable
    have hc := hasSum_sum_range_mul_of_summable_norm hgn hin
    simpa [coeff, euler, Finset.prod_range_succ, hg.tsum_eq, ih.tsum_eq,
      mul_comm] using hc

/-- Total weight of partitions longer than the cutoff. -/
def tail (q : ℕ → ℝ) (m L : ℕ) := ∑' i : ℕ, coeff q m (i + (L+1))

theorem tail_le_tilt {q : ℕ → ℝ} {r : ℝ} (hr : 1 ≤ r)
    (hq : ∀ j, 0 ≤ q j) (hq' : ∀ j, q j < 1) (hqr : ∀ j, r * q j < 1)
    (m L : ℕ) : tail q m L ≤ euler (fun j => r * q j) m / r ^ L := by
  have hr0 : 0 < r := lt_of_lt_of_le zero_lt_one hr
  have hsm := coeff_hasSum hq hq' m
  have htm := coeff_hasSum (fun j => mul_nonneg hr0.le (hq j)) hqr m
  apply (le_div_iff₀ (pow_pos hr0 L)).2
  rw [mul_comm, tail, ← tsum_mul_left, ← htm.tsum_eq]
  apply Summable.tsum_le_tsum_of_inj (fun i : ℕ => i+(L+1))
  · intro a b e
    exact Nat.add_right_cancel e
  · exact fun j _ => coeff_nonneg (fun i => mul_nonneg hr0.le (hq i)) _ _
  · intro i
    rw [coeff_tilt]
    exact mul_le_mul_of_nonneg_right (pow_le_pow_right₀ hr (by omega))
      (coeff_nonneg hq _ _)
  · exact ((summable_nat_add_iff (L+1)).mpr hsm.summable).mul_left _
  · exact htm.summable

/-- Simultaneous bounds before estimating the tilted tails. The sequence p need
only be increasing and greater than one at all positive indices. -/
theorem central {p : ℕ → ℝ} (hmono : Monotone p) (hp : ∀ i, 1 < p (i+1))
    {n L : ℕ} (hL : L < n) :
    let q := fun j => 1 / p (j+1)
    euler q (n-L) / p n - tail q (n-L) L ≤ shell p n ∧
      shell p n ≤ euler q n / p (n-L) + tail q n L := by
  let q := fun j => 1 / p (j+1)
  let f := fun l => coeff q (n-l) l / p (n-l)
  have hp1 : ∀ {j : ℕ}, 0 < j → 1 ≤ p j := by
    intro j hj
    obtain ⟨a, rfl⟩ := Nat.exists_eq_succ_of_ne_zero (Nat.ne_of_gt hj)
    exact (hp a).le
  have hp0 : ∀ {j : ℕ}, 0 < j → 0 < p j := fun hj => lt_of_lt_of_le zero_lt_one (hp1 hj)
  have hq : ∀ j, 0 ≤ q j := fun j => div_nonneg zero_le_one (by linarith [hp j])
  have hq' : ∀ j, q j < 1 := fun j => (div_lt_one (by linarith [hp j])).2 (hp j)
  have hsplit (m : ℕ) :
      (∑ i ∈ range (L+1), coeff q m i) + tail q m L = euler q m := by
    have hs := coeff_hasSum hq hq' m
    exact (hs.summable.sum_add_tsum_nat_add (L+1)).trans hs.tsum_eq
  have htail (m : ℕ) : 0 ≤ tail q m L := tsum_nonneg (fun _ => coeff_nonneg hq _ _)
  change euler q (n-L) / p n - tail q (n-L) L ≤ ∑ l ∈ range n, f l ∧
    ∑ l ∈ range n, f l ≤ euler q n / p (n-L) + tail q n L
  constructor
  · have hsmall : (∑ i ∈ range (L+1), coeff q (n-L) i) / p n ≤ ∑ i ∈ range (L+1), f i := by
      rw [div_eq_mul_inv, Finset.sum_mul]
      apply sum_le_sum
      intro i hi
      have hi' := mem_range.mp hi
      rw [← div_eq_mul_inv]
      exact div_le_div₀ (coeff_nonneg hq _ _) (coeff_mono hq i (by omega))
        (hp0 (by omega)) (hmono (Nat.sub_le n i))
    have hpartial : (∑ i ∈ range (L+1), f i) ≤ ∑ i ∈ range n, f i :=
      sum_le_sum_of_subset_of_nonneg (range_mono hL) (fun i hi _ =>
        div_nonneg (coeff_nonneg hq _ _) (hp0 (by have := mem_range.mp hi; omega)).le)
    have hterr := div_le_self (htail (n-L)) (hp1 (show 0<n by omega))
    rw [← hsplit (n-L), add_div]
    linarith
  · have hsmall : ∑ i ∈ range (L+1), f i ≤ euler q n / p (n-L) := by
      calc
        _ ≤ ∑ i ∈ range (L+1), coeff q n i / p (n-L) := by
          apply sum_le_sum
          intro i hi
          have hi' := mem_range.mp hi
          exact div_le_div₀ (coeff_nonneg hq _ _) (coeff_mono hq i (Nat.sub_le n i))
            (hp0 (by omega)) (hmono (by omega))
        _ = (∑ i ∈ range (L+1), coeff q n i) / p (n-L) := by
          simp only [div_eq_mul_inv, Finset.sum_mul]
        _ ≤ _ := div_le_div_of_nonneg_right (by linarith [hsplit n, htail n]) (hp0 (by omega)).le
    have hlarge : ∑ j ∈ range (n-(L+1)), f ((L+1)+j) ≤ tail q n L := by
      calc
        _ ≤ ∑ j ∈ range (n-(L+1)), coeff q n (j+(L+1)) := by
          apply sum_le_sum
          intro j hj
          have hj' := mem_range.mp hj
          dsimp only [f]
          rw [add_comm (L+1) j]
          exact (div_le_self (coeff_nonneg hq _ _) (hp1 (by omega))).trans
            (coeff_mono hq _ (Nat.sub_le n _))
        _ ≤ _ := Summable.sum_le_tsum _ (fun i _ => coeff_nonneg hq _ _)
          ((summable_nat_add_iff (L+1)).mpr (coeff_hasSum hq hq' n).summable)
    have hs := Finset.sum_range_add f (L+1) (n-(L+1))
    rw [Nat.add_sub_of_le hL] at hs
    rw [hs]
    exact add_le_add hsmall hlarge

theorem quadratic_sandwich {p : ℕ → ℝ} (hmono : Monotone p)
    (hp : ∀ i, (3/2 : ℝ) < p (i+1))
    (hprod : ∀ m : ℕ, euler (fun j => (3/2 : ℝ) * (1 / p (j+1))) m ≤ ((m:ℝ)+1)^2)
    {n L : ℕ} (hL : L < n) :
    let q := fun j => 1 / p (j+1)
    let E := ((n:ℝ)+1)^2 / (3/2 : ℝ)^L
    euler q (n-L) / p n - E ≤ shell p n ∧
      shell p n ≤ euler q n / p (n-L) + E := by
  let q := fun j => 1 / p (j+1)
  have hp' (i : ℕ) : 1 < p (i+1) := by linarith [hp i]
  have hq (i : ℕ) : 0 ≤ q i := div_nonneg zero_le_one (by linarith [hp i])
  have hq' (i : ℕ) : q i < 1 := (div_lt_one (by linarith [hp i])).2 (hp' i)
  have hqr (i : ℕ) : (3 / 2 : ℝ) * q i < 1 := by
    dsimp only [q]
    rw [← mul_div_assoc, mul_one]
    exact (div_lt_one (by linarith [hp i])).2 (hp i)
  have bounds (m : ℕ) (hm : m ≤ n) : tail q m L ≤ ((n:ℝ)+1)^2 / (3/2 : ℝ)^L := by
    apply (tail_le_tilt (by norm_num : (1:ℝ) ≤ 3/2) hq hq' hqr m L).trans
    apply div_le_div_of_nonneg_right _ (pow_nonneg (by norm_num) L)
    apply (hprod m).trans
    have hmn : (m:ℝ) ≤ n := by exact_mod_cast hm
    nlinarith [sq_nonneg ((n:ℝ)-m), mul_nonneg (sub_nonneg.mpr hmn) (Nat.cast_nonneg m : (0:ℝ) ≤ m)]
  obtain ⟨hlo, hhi⟩ := central hmono hp' hL
  change euler q (n-L) / p n - _ ≤ shell p n at hlo
  change shell p n ≤ euler q n / p (n-L) + _ at hhi
  exact ⟨le_trans (sub_le_sub_left (bounds (n-L) (Nat.sub_le n L)) _) hlo,
    le_trans hhi (add_le_add_left (bounds n le_rfl) _)⟩

end
end PerimeterFinite

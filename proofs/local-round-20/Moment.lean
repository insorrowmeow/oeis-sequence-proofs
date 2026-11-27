import PerimeterFinite
import Mathlib.Tactic.FieldSimp

namespace PerimeterFinite
open Finset
noncomputable section

private theorem geom_moment {x : ℝ} (hx : 0 ≤ x) (hx' : x < 1) :
    HasSum (fun n : ℕ => (n : ℝ) * x^n) (x / (1-x)^2) := by
  have h := hasSum_choose_mul_geometric_of_norm_lt_one 1 (r := x)
    (by simpa [Real.norm_eq_abs, abs_of_nonneg hx] using hx')
  have h' := h.sub (hasSum_geometric_of_lt_one hx hx')
  convert h' using 1
  · ext n
    simp [Nat.choose_one_right]
    ring
  · norm_num
    field_simp [ne_of_gt (sub_pos.mpr hx')]
    ring

private theorem hasSum_conv {f g : ℕ → ℝ} {a b : ℝ} (hf : HasSum f a) (hg : HasSum g b)
    (fn : ∀ i, 0 ≤ f i) (gn : ∀ i, 0 ≤ g i) :
    HasSum (fun n => ∑ i ∈ range (n+1), f i * g (n-i)) (a*b) := by
  have hfn : Summable (fun i => ‖f i‖) := by simpa [Real.norm_eq_abs, abs_of_nonneg, fn] using hf.summable
  have hgn : Summable (fun i => ‖g i‖) := by simpa [Real.norm_eq_abs, abs_of_nonneg, gn] using hg.summable
  simpa [hf.tsum_eq, hg.tsum_eq] using hasSum_sum_range_mul_of_summable_norm hfn hgn

theorem hasSum_length_moment {q : ℕ → ℝ} (hq : ∀ i, 0 ≤ q i) (hq' : ∀ i, q i < 1)
    (m : ℕ) : HasSum (fun k : ℕ => (k:ℝ) * coeff q m k)
      (euler q m * ∑ i ∈ range m, q i / (1-q i)) := by
  induction m with
  | zero =>
    simp only [sum_range_zero, mul_zero]
    apply (hasSum_zero (β := ℕ) (α := ℝ)).congr_fun
    intro k
    by_cases h : k = 0 <;> simp [coeff, h]
  | succ m ih =>
    have a := hasSum_conv (geom_moment (hq m) (hq' m)) (coeff_hasSum hq hq' m)
      (fun i => mul_nonneg (Nat.cast_nonneg i) (pow_nonneg (hq m) _)) (coeff_nonneg hq m)
    have b := hasSum_conv (hasSum_geometric_of_lt_one (hq m) (hq' m)) ih
      (pow_nonneg (hq m)) (fun i => mul_nonneg (Nat.cast_nonneg i) (coeff_nonneg hq m i))
    convert a.add b using 1
    · ext n
      simp only [coeff, mul_sum, ← sum_add_distrib]
      apply sum_congr rfl
      intro j hj
      have hj' : j ≤ n := by simpa [Nat.lt_succ_iff] using hj
      rw [Nat.cast_sub hj']
      ring
    · simp only [euler, prod_range_succ, sum_range_succ, div_eq_mul_inv, ← inv_pow]
      ring

theorem length_moment {q : ℕ → ℝ} (hq : ∀ i, 0 ≤ q i) (hq' : ∀ i, q i < 1)
    (m : ℕ) : (∑' k : ℕ, (k:ℝ) * coeff q m k) =
      euler q m * ∑ i ∈ range m, q i / (1-q i) :=
  (hasSum_length_moment hq hq' m).tsum_eq

/-- Interchanging the length and the threshold counts a partition of length k
exactly k times. -/
theorem hasSum_tail {q : ℕ → ℝ} (hq : ∀ i, 0 ≤ q i) (hq' : ∀ i, q i < 1)
    (m : ℕ) : HasSum (tail q m) (euler q m * ∑ i ∈ range m, q i / (1-q i)) := by
  let F (k t : ℕ) := if t < k then coeff q m k else 0
  have rows (k : ℕ) : HasSum (F k) ((k:ℝ) * coeff q m k) := by
    have hf := hasSum_sum_of_ne_finset_zero (s := range k) (f := F k)
      (fun i hi => if_neg (by simpa only [mem_range] using hi))
    convert hf using 1
    calc
      _ = ∑ _ ∈ range k, coeff q m k := by simp
      _ = _ := sum_congr rfl fun i hi => (if_pos (mem_range.mp hi)).symm
  have cols (t : ℕ) : HasSum (fun k => F k t) (tail q m t) := by
    have hprec : ∑ k ∈ range (t+1), F k t = 0 :=
      sum_eq_zero fun k hk => if_neg (by have := mem_range.mp hk; omega)
    have hs := (summable_nat_add_iff (t+1)).mpr (coeff_hasSum hq hq' m).summable
    have h : HasSum (fun k : ℕ => F (k+(t+1)) t) (tail q m t) := by
      apply hs.hasSum.congr_fun
      intro k
      simp [F, show t < k+(t+1) by omega]
    simpa only [hprec, add_zero] using (hasSum_nat_add_iff (f := fun k => F k t) (t+1)).mp h
  have hsum := hasSum_length_moment hq hq' m
  have hs : Summable (Function.uncurry F) := by
    refine (summable_prod_of_nonneg ?_).mpr ⟨fun k => (rows k).summable, ?_⟩
    · intro z
      dsimp [Function.uncurry, F]
      split
      · exact coeff_nonneg hq _ _
      · exact le_rfl
    · simpa only [Function.uncurry_apply_pair, fun k => (rows k).tsum_eq] using hsum.summable
  have hs' := hs.prod_symm.prod
  have htot := hs.tsum_comm
  simp_rw [fun t => (cols t).tsum_eq, fun k => (rows k).tsum_eq] at htot
  have finish : Summable (tail q m) := by
    simpa only [Prod.swap_prod_mk, Function.uncurry_apply_pair, fun t => (cols t).tsum_eq] using hs'
  exact finish.hasSum_iff.mpr (htot.trans hsum.tsum_eq)

#print axioms hasSum_tail

end
end PerimeterFinite

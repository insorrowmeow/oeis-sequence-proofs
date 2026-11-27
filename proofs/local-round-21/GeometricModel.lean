import Mathlib.Algebra.BigOperators.Ring.Finset
import Mathlib.Analysis.SpecificLimits.Normed
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.Ring

/-!
The multiplicity at an index is capped at K. The last bucket includes every
multiplicity ≥ K. Taking K=n+1 preserves the event that total size exceeds n.
-/

namespace SizeGeom
open Finset
noncomputable section

def atom (q : ℝ) (K k : ℕ) : ℝ := if k = K then q^K else (1-q)*q^k

theorem atom_nonneg {q : ℝ} (h₀ : 0 ≤ q) (h₁ : q ≤ 1) (K k : ℕ) :
    0 ≤ atom q K k := by
  unfold atom
  split
  · exact pow_nonneg h₀ _
  · exact mul_nonneg (sub_nonneg.mpr h₁) (pow_nonneg h₀ _)

private theorem telescope (q : ℝ) (K : ℕ) :
    ∑ k ∈ range K, (1-q)*q^k = 1-q^K := by
  induction K with
  | zero => simp
  | succ K ih => rw [sum_range_succ, ih, pow_succ]; ring

theorem atom_total (q : ℝ) (K : ℕ) :
    ∑ k : Fin (K+1), atom q K k = 1 := by
  rw [Fin.sum_univ_eq_sum_range, sum_range_succ]
  have he : (∑ k ∈ range K, atom q K k) = 1-q^K := by
    rw [← telescope]
    exact sum_congr rfl fun k hk => if_neg (Nat.ne_of_lt (mem_range.mp hk))
  rw [he]
  simp [atom]

theorem atom_tail (q : ℝ) {k K : ℕ} (hk : k ≤ K) :
    ∑ d : Fin (K+1), (if k ≤ (d:ℕ) then atom q K d else 0) = q^k := by
  have hpre : ∑ d ∈ range (K+1), (if d < k then atom q K d else 0) = 1-q^k := by
    rw [← sum_filter, show ((range (K+1)).filter fun d => d<k) = range k by
      ext d; simp; omega, ← telescope]
    exact sum_congr rfl fun d hd => if_neg (show d ≠ K by have := mem_range.mp hd; omega)
  have full := atom_total q K
  rw [Fin.sum_univ_eq_sum_range] at full
  rw [Fin.sum_univ_eq_sum_range (fun d : ℕ => if k ≤ d then atom q K d else 0)]
  have halg : (∑ d ∈ range (K+1), (if k ≤ d then atom q K d else 0)) +
      (∑ d ∈ range (K+1), (if d < k then atom q K d else 0)) =
      ∑ d ∈ range (K+1), atom q K d := by
    rw [← sum_add_distrib]
    apply sum_congr rfl
    intro d _
    by_cases h : k≤d <;> simp [h, Nat.lt_of_not_ge, Nat.not_lt.mpr]
  linarith

def mass {ι : Type*} [Fintype ι] [DecidableEq ι] (q : ι → ℝ) (K : ℕ) (v : ι → Fin (K+1)) : ℝ :=
  ∏ i, atom (q i) K (v i)

theorem mass_total {ι : Type*} [Fintype ι] [DecidableEq ι] (q : ι → ℝ) (K : ℕ) :
    ∑ v, mass q K v = 1 := by
  classical
  unfold mass
  rw [← Fintype.prod_sum (fun (i : ι) (k : Fin (K+1)) => atom (q i) K k)]
  simp [atom_total]

/-- Each coordinate may have its own allowed set of multiplicities. -/
theorem rectangle {ι : Type*} [Fintype ι] [DecidableEq ι] (q : ι → ℝ) (K : ℕ)
    (s : ι → Finset (Fin (K+1))) :
    ∑ v ∈ Fintype.piFinset s, mass q K v =
      ∏ i, ∑ k ∈ s i, atom (q i) K k := by
  classical
  exact (prod_univ_sum s (fun i k => atom (q i) K k)).symm

def size {ι : Type*} [Fintype ι] [DecidableEq ι] {K : ℕ} (part : ι → ℕ) (v : ι → Fin (K+1)) : ℕ :=
  ∑ i, part i * (v i : ℕ)

def normalizer {ι : Type*} [Fintype ι] [DecidableEq ι] (q : ι → ℝ) : ℝ := ∏ i, (1-q i)⁻¹

/-- For positive part labels, an admissible vector cannot hit the last bucket.
The summands therefore reduce to the original reciprocal partition weights. -/
theorem normalize_small {ι : Type*} [Fintype ι] [DecidableEq ι] (q : ι → ℝ)
    (hq : ∀ i, q i < 1) (part : ι → ℕ) (hp : ∀ i, 0 < part i) (n : ℕ)
    (v : ι → Fin ((n+1)+1)) (hv : size part v ≤ n) :
    normalizer q * mass q (n+1) v = ∏ i, q i ^ (v i : ℕ) := by
  classical
  unfold normalizer mass
  rw [← prod_mul_distrib]
  apply prod_congr rfl
  intro i _
  have h : part i * (v i : ℕ) ≤ size part v :=
    single_le_sum (f := fun j => part j * (v j : ℕ)) (fun _ _ => Nat.zero_le _) (mem_univ i)
  have hle : (v i : ℕ) ≤ part i * (v i : ℕ) := Nat.le_mul_of_pos_left _ (hp i)
  rw [atom, if_neg (show (v i : ℕ) ≠ n+1 by omega), ← mul_assoc,
    inv_mul_cancel₀ (sub_ne_zero.mpr (ne_of_gt (hq i))), one_mul]

theorem gap_probability {ι : Type*} [Fintype ι] [DecidableEq ι] (q : ι → ℝ) (hq : ∀ i, q i < 1)
    (part : ι → ℕ) (hp : ∀ i, 0 < part i) (n : ℕ) :
    normalizer q - (∑ v : ι → Fin ((n+1)+1),
      if size part v ≤ n then ∏ i, q i^(v i : ℕ) else 0) =
    normalizer q * (∑ v : ι → Fin ((n+1)+1), if n < size part v then mass q (n+1) v else 0) := by
  classical
  have ht := mass_total q (n+1)
  calc
    _ = normalizer q * (∑ v, mass q (n+1) v) -
        (∑ v : ι → Fin ((n+1)+1), if size part v ≤ n then ∏ i, q i^(v i : ℕ) else 0) := by rw [ht, mul_one]
    _ = _ := by
      simp only [mul_sum, ← sum_sub_distrib]
      apply sum_congr rfl
      intro v _
      by_cases h : size part v ≤ n
      · simp [h, Nat.not_lt.mpr h, normalize_small q hq part hp n v h]
      · simp [h, Nat.lt_of_not_ge h]

end
end SizeGeom

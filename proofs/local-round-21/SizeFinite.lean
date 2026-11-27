import Mathlib.Analysis.SpecificLimits.Normed
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.Ring
import Mathlib.Tactic.FieldSimp

/-! Cumulative reciprocal-norm weights on partitions bounded by total size.
The parameter q i is the weight of the positive part i+1. -/

namespace SizeEnsemble
open Finset
noncomputable section

/-- Canonical weakly decreasing partitions with bounded parts and bounded sum. -/
def parts (m n : ℕ) : Finset (List ℕ) :=
  {[]} ∪ (range m).biUnion fun j =>
    if _h : j < n then (parts (j+1) (n-(j+1))).image (List.cons (j+1)) else ∅
termination_by n
decreasing_by omega

@[simp] theorem nil_mem_parts (m n : ℕ) : [] ∈ parts m n := by
  rw [parts]; simp

theorem cons_mem_parts (a : ℕ) (xs : List ℕ) (m n : ℕ) :
    a::xs ∈ parts m n ↔ 0<a ∧ a≤m ∧ a≤n ∧ xs ∈ parts a (n-a) := by
  rw [parts]
  simp only [mem_union, mem_singleton, List.cons_ne_nil, false_or, mem_biUnion, mem_range]
  constructor
  · rintro ⟨j, hj, h⟩
    split at h
    · obtain ⟨ys, hy, eq⟩ := mem_image.mp h
      obtain ⟨rfl, rfl⟩ := List.cons.inj eq
      exact ⟨by omega, by omega, by omega, hy⟩
    · simp at h
  · rintro ⟨ha, hm, hn, hx⟩
    cases a with
    | zero => omega
    | succ j =>
      refine ⟨j, by omega, ?_⟩
      simp only [dif_pos (show j<n by omega)]
      exact mem_image.mpr ⟨_, hx, rfl⟩

theorem mem_parts (xs : List ℕ) (m n : ℕ) :
    xs ∈ parts m n ↔ xs.sum ≤ n ∧ xs.Pairwise (· ≥ ·) ∧ ∀ a ∈ xs, 0<a ∧ a≤m := by
  induction xs generalizing m n with
  | nil => simp
  | cons a xs ih =>
    rw [cons_mem_parts, ih]
    simp only [List.sum_cons, List.pairwise_cons, List.mem_cons]
    constructor
    · rintro ⟨ha, hm, hn, hsum, hs, h⟩
      refine ⟨by omega, ⟨fun b hb => (h b hb).2, hs⟩, ?_⟩
      intro b hb
      rcases hb with rfl | hb
      · exact ⟨ha,hm⟩
      · exact ⟨(h b hb).1, (h b hb).2.trans hm⟩
    · rintro ⟨hsum, ⟨hh,hs⟩, h⟩
      have ha := h a (Or.inl rfl)
      exact ⟨ha.1, ha.2, by omega, by omega, hs,
        fun b hb => ⟨(h b (Or.inr hb)).1, hh b hb⟩⟩

def weight (q : ℕ → ℝ) (xs : List ℕ) : ℝ := (xs.map fun a => q (a-1)).prod

def C (q : ℕ → ℝ) (m n : ℕ) : ℝ := ∑ xs ∈ parts m n, weight q xs

def H (q : ℕ → ℝ) (m : ℕ) : ℝ := ∏ j ∈ range m, (1-q j)⁻¹

def mean (q : ℕ → ℝ) (m : ℕ) : ℝ := ∑ j ∈ range m, (j+1:ℝ)*q j/(1-q j)

def moment (q : ℕ → ℝ) (m : ℕ) : ℝ := H q m * mean q m

theorem C_eq (q : ℕ → ℝ) (m n : ℕ) : C q m n =
    1 + ∑ j ∈ range m, if j<n then q j * C q (j+1) (n-(j+1)) else 0 := by
  let blocks := fun j => if j<n then (parts (j+1) (n-(j+1))).image (List.cons (j+1)) else ∅
  have head (j : ℕ) (x : List ℕ) (hx : x ∈ blocks j) :
      ∃ y, x = (j+1)::y := by
    dsimp only [blocks] at hx
    split at hx
    · obtain ⟨y,_,rfl⟩ := mem_image.mp hx
      exact ⟨y,rfl⟩
    · simp at hx
  have hd : Disjoint ({[]} : Finset (List ℕ)) ((range m).biUnion blocks) := by
    apply disjoint_left.mpr
    intro x hx h
    obtain rfl := mem_singleton.mp hx
    obtain ⟨j,_,hj⟩ := mem_biUnion.mp h
    obtain ⟨_,e⟩ := head j [] hj
    cases e
  have hb : ∀ i ∈ range m, ∀ j ∈ range m, i ≠ j → Disjoint (blocks i) (blocks j) := by
    intro i _ j _ hij
    apply disjoint_left.mpr
    intro x hx hy
    obtain ⟨y,rfl⟩ := head i x hx
    obtain ⟨z,e⟩ := head j _ hy
    exact hij (Nat.add_right_cancel (List.cons.inj e).1)
  unfold C
  conv_lhs => rw [parts]
  change (∑ x ∈ {[]} ∪ (range m).biUnion blocks, weight q x) = _
  rw [sum_union hd, sum_biUnion hb, sum_singleton]
  have hw : weight q [] = 1 := rfl
  rw [hw]
  congr 1
  apply sum_congr rfl
  intro j _
  by_cases hj : j<n
  · simp only [blocks, if_pos hj]
    rw [sum_image]
    · simp [weight, mul_sum]
    · intro x _ y _ eq
      exact (List.cons.inj eq).2
  · simp [blocks,hj]

theorem H_succ (q : ℕ → ℝ) (m : ℕ) : H q (m+1) = H q m / (1-q m) := by
  simp only [H, prod_range_succ, div_eq_mul_inv]

theorem mean_succ (q : ℕ → ℝ) (m : ℕ) : mean q (m+1) =
    mean q m + (m+1:ℝ)*q m/(1-q m) := by simp only [mean, sum_range_succ]

theorem H_eq (q : ℕ → ℝ) (hq' : ∀ i, q i < 1) (m : ℕ) :
    H q m = 1 + ∑ j ∈ range m, q j * H q (j+1) := by
  induction m with
  | zero => simp [H]
  | succ m ih =>
    rw [sum_range_succ, ← add_assoc, ← ih]
    rw [H_succ]
    field_simp [ne_of_gt (sub_pos.mpr (hq' m))]
    ring

theorem moment_eq (q : ℕ → ℝ) (hq' : ∀ i, q i < 1) (m : ℕ) :
    moment q m = ∑ j ∈ range m, q j * (moment q (j+1)+(j+1:ℝ)*H q (j+1)) := by
  induction m with
  | zero => simp [H, moment, mean]
  | succ m ih =>
    rw [sum_range_succ, ← ih]
    simp only [moment, mean_succ, H_succ]
    field_simp [ne_of_gt (sub_pos.mpr (hq' m))]
    ring



def gap (q : ℕ → ℝ) (m n : ℕ) := H q m - C q m n

theorem H_nonneg {q : ℕ → ℝ} (hq' : ∀ i, q i < 1) (m : ℕ) : 0 ≤ H q m :=
  prod_nonneg fun i _ => inv_nonneg.mpr (sub_nonneg.mpr (hq' i).le)

theorem C_nonneg {q : ℕ → ℝ} (hq : ∀ i, 0 ≤ q i) (m n : ℕ) : 0 ≤ C q m n := by
  apply sum_nonneg
  intro x hx
  clear hx
  induction x with
  | nil => simp [weight]
  | cons a x ih => exact mul_nonneg (hq _) ih

theorem moment_nonneg {q : ℕ → ℝ} (hq : ∀ i, 0 ≤ q i) (hq' : ∀ i, q i < 1)
    (m : ℕ) : 0 ≤ moment q m := by
  apply mul_nonneg (H_nonneg hq' m)
  exact sum_nonneg fun i _ => div_nonneg (mul_nonneg (by positivity) (hq i)) (sub_nonneg.mpr (hq' i).le)

theorem gap_eq (q : ℕ → ℝ) (hq' : ∀ i, q i < 1) (m n : ℕ) :
    gap q m n = ∑ j ∈ range m, q j * (if j<n then gap q (j+1) (n-(j+1)) else H q (j+1)) := by
  rw [gap, H_eq q hq', C_eq, add_sub_add_left_eq_sub, ← sum_sub_distrib]
  apply sum_congr rfl
  intro i _
  by_cases h : i<n <;> simp [h, gap, mul_sub]

theorem gap_nonneg {q : ℕ → ℝ} (hq : ∀ i, 0 ≤ q i) (hq' : ∀ i, q i < 1) (m n : ℕ) :
    0 ≤ gap q m n := by
  induction n using Nat.strong_induction_on generalizing m with
  | h n ih =>
    rw [gap_eq q hq']
    apply sum_nonneg
    intro j _
    apply mul_nonneg (hq j)
    split
    · exact ih _ (by omega) _
    · exact H_nonneg hq' _

/-- A deterministic Markov bound for the mass of partitions exceeding the
budget n. The moment is explicit for every part cutoff m. -/
theorem markov {q : ℕ → ℝ} (hq : ∀ i, 0 ≤ q i) (hq' : ∀ i, q i < 1)
    (m n : ℕ) : (n+1:ℝ) * gap q m n ≤ moment q m := by
  induction n using Nat.strong_induction_on generalizing m with
  | h n ih =>
    rw [gap_eq q hq', moment_eq q hq', mul_sum]
    apply sum_le_sum
    intro j _
    rw [mul_left_comm]
    apply mul_le_mul_of_nonneg_left _ (hq j)
    by_cases h : j<n
    · rw [if_pos h]
      have hrem := ih (n-(j+1)) (by omega) (j+1)
      rw [Nat.cast_sub (show j+1≤n by omega), Nat.cast_add, Nat.cast_one] at hrem
      have hgap : gap q (j+1) (n-(j+1)) ≤ H q (j+1) := sub_le_self _ (C_nonneg hq _ _)
      nlinarith [mul_le_mul_of_nonneg_left hgap (show (0:ℝ)≤j+1 by positivity)]
    · rw [if_neg h]
      have hn : (n:ℝ) ≤ j := by exact_mod_cast (Nat.le_of_not_gt h)
      exact le_add_of_nonneg_of_le (moment_nonneg hq hq' _)
        (mul_le_mul_of_nonneg_right (by linarith) (H_nonneg hq' _))

theorem diagonal_gap (q : ℕ → ℝ) (hq' : ∀ i, q i < 1) (n : ℕ) :
    gap q n n = ∑ j ∈ range n, q j * gap q (j+1) (n-(j+1)) := by
  rw [gap_eq q hq']
  exact sum_congr rfl fun j hj => by rw [if_pos (mem_range.mp hj)]

/-- Split the largest part into those <= n-r and the remaining r parts.
K bounds the normalized mass of a single largest-part class. -/
theorem window {q : ℕ → ℝ} (hq : ∀ i, 0 ≤ q i) (hq' : ∀ i, q i < 1) (K : ℝ)
    (hK : ∀ j : ℕ, (j+1:ℝ)*(q j*H q (j+1)) ≤ K)
    (n r : ℕ) (hr : r ≤ n) :
    gap q n n ≤ (∑ j ∈ range n, q j * moment q (j+1))/(r+1:ℝ)
      + (r:ℝ)*K/((n-r:ℕ)+1:ℝ) := by
  let f := fun j => q j * gap q (j+1) (n-(j+1))
  have hfar : (∑ j ∈ range (n-r), f j) ≤ (∑ j ∈ range n, q j*moment q (j+1))/(r+1:ℝ) := by
    apply (le_div_iff₀ (by positivity)).mpr
    rw [sum_mul]
    calc
      _ ≤ ∑ j ∈ range (n-r), q j*moment q (j+1) := by
        apply sum_le_sum
        intro j hj
        dsimp only [f]
        rw [mul_assoc, mul_comm (gap ..)]
        apply mul_le_mul_of_nonneg_left _ (hq j)
        apply le_trans _ (markov hq hq' (j+1) (n-(j+1)))
        apply mul_le_mul_of_nonneg_right _ (gap_nonneg hq hq' _ _)
        have hj' := mem_range.mp hj
        exact_mod_cast (show r+1 ≤ n-(j+1)+1 by omega)
      _ ≤ _ := sum_le_sum_of_subset_of_nonneg (range_mono (Nat.sub_le ..))
        (fun j _ _ => mul_nonneg (hq j) (moment_nonneg hq hq' _))
  have hnear : (∑ j ∈ range r, f ((n-r)+j)) ≤ (r:ℝ)*K/((n-r:ℕ)+1:ℝ) := by
    calc
      _ ≤ ∑ _j ∈ range r, K/((n-r:ℕ)+1:ℝ) := by
        apply sum_le_sum
        intro j _
        dsimp only [f]
        apply (mul_le_mul_of_nonneg_left (sub_le_self _ (C_nonneg hq _ _)) (hq _)).trans
        apply (le_div_iff₀ (by positivity)).mpr
        rw [mul_comm]
        apply le_trans _ (hK (n-r+j))
        apply mul_le_mul_of_nonneg_right _ (mul_nonneg (hq _) (H_nonneg hq' _))
        exact_mod_cast (show n-r+1 ≤ n-r+j+1 by omega)
      _ = _ := by simp [mul_div_assoc]
  have hsum := sum_range_add f (n-r) r
  rw [Nat.sub_add_cancel hr] at hsum
  rw [diagonal_gap q hq']
  exact hsum.le.trans (add_le_add hfar hnear)

#print axioms window

end
end SizeEnsemble

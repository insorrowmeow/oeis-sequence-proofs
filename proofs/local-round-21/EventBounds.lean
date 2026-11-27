import GeometricModel
import Mathlib.Data.Finset.Powerset

namespace SizeGeom
open Finset
open Classical in
noncomputable def prob {Ω : Type*} [Fintype Ω] (w : Ω → ℝ) (A : Ω → Prop) : ℝ :=
  ∑ v, if A v then w v else 0

noncomputable section
variable {Ω ι : Type*} [Fintype Ω] [Fintype ι] [DecidableEq ι]

theorem cover {w : Ω → ℝ} (hw : ∀ v, 0 ≤ w v) {J : Type*} (s : Finset J)
    {A : Ω → Prop} (B : J → Ω → Prop) (h : ∀ v, A v → ∃ j ∈ s, B j v) :
    prob w A ≤ ∑ j ∈ s, prob w (B j) := by
  classical
  unfold prob
  rw [sum_comm]
  apply sum_le_sum
  intro v _
  by_cases ha : A v
  · obtain ⟨j, hj, hb⟩ := h v ha
    simp only [if_pos ha]
    exact (show w v ≤ (if B j v then w v else 0) by simp [hb]).trans
      (single_le_sum (f := fun k => if B k v then w v else 0)
        (fun k _ => by by_cases hh : B k v <;> simp [hh, hw]) hj)
  · simpa only [if_neg ha] using
      sum_nonneg (s := s) (f := fun j => if B j v then w v else 0)
        (fun j _ => by by_cases hh : B j v <;> simp [hh, hw])

theorem disjoint_lower {w : Ω → ℝ} (hw : ∀ v, 0 ≤ w v)
    {J : Type*} (s : Finset J) (f : Ω → J) {A : Ω → Prop}
    (h : ∀ v, f v ∈ s → A v) :
    ∑ j ∈ s, prob w (fun v => f v = j) ≤ prob w A := by
  classical
  unfold prob
  rw [sum_comm]
  apply sum_le_sum
  intro v _
  rw [sum_ite_eq]
  by_cases ht : f v ∈ s
  · simp [ht, h v ht]
  · simp only [if_neg ht]
    split <;> simp [hw]

theorem box (q : ι → ℝ) (K : ℕ) (s : ι → Finset (Fin (K+1))) :
    prob (mass q K) (fun v => ∀ i, v i ∈ s i) =
    ∏ i, ∑ k ∈ s i, atom (q i) K k := by
  classical
  rw [← rectangle, prob]
  have he : ∀ v : ι → Fin (K+1), (∀ i, v i ∈ s i) ↔ v ∈ Fintype.piFinset s :=
    fun _ => Fintype.mem_piFinset.symm
  simp only [he, sum_ite_mem, univ_inter]

theorem nonnegative_mass {q : ι → ℝ} (h0 : ∀ i, 0 ≤ q i) (h1 : ∀ i, q i ≤ 1)
    (K : ℕ) (v : ι → Fin (K+1)) : 0 ≤ mass q K v :=
  prod_nonneg fun i _ => atom_nonneg (h0 i) (h1 i) _ _

theorem threshold {K : ℕ} (q : ι → ℝ) (r : ι → ℕ) (hr : ∀ i, r i ≤ K) :
    prob (mass q K) (fun v => ∀ i, r i ≤ (v i : ℕ)) = ∏ i, q i^(r i) := by
  classical
  let s (i : ι) := univ.filter fun d : Fin (K+1) => r i ≤ (d:ℕ)
  have h := box q K s
  simp only [s, mem_filter, mem_univ, true_and, sum_filter] at h
  simpa only [fun i => atom_tail (q i) (hr i)] using h

theorem all_hit {K : ℕ} (q : ι → ℝ) (T : Finset ι) (k : ℕ) (hk : k ≤ K) :
    prob (mass q K) (fun v => ∀ i ∈ T, k ≤ (v i : ℕ)) = ∏ i ∈ T, q i ^ k := by
  classical
  let r (i : ι) := if i ∈ T then k else 0
  have h := threshold (K:=K) q r (fun i => by dsimp [r]; split <;> omega)
  have he (v : ι → Fin (K+1)) : (∀ i, r i ≤ (v i : ℕ)) ↔ ∀ i ∈ T, k ≤ (v i : ℕ) := by
    constructor
    · intro h i hi; simpa [r, hi] using h i
    · intro h i; by_cases hi : i ∈ T <;> simp [r, hi, h]
  have hr (i : ι) : q i ^ r i = if i ∈ T then q i ^ k else 1 := by
    by_cases hi : i ∈ T <;> simp [r, hi]
  simpa only [he, hr, prod_ite_mem, univ_inter] using h

theorem single_tail {K : ℕ} (q : ι → ℝ) (i : ι) (k : ℕ) (hk : k ≤ K) :
    prob (mass q K) (fun v => k ≤ (v i : ℕ)) = q i ^ k := by
  simpa using all_hit q {i} k hk

def occupied {K : ℕ} (B : Finset ι) (v : ι → Fin (K+1)) : Finset ι :=
  B.filter fun i => 0 < (v i : ℕ)

/-- Lower bound on a specified occupancy set, using the union bound for
unwanted additional occupied coordinates. -/
theorem exactly_lower {K : ℕ} (q : ι → ℝ) (h0 : ∀ i, 0 ≤ q i) (h1 : ∀ i, q i ≤ 1)
    (hK : 1 ≤ K) (B T : Finset ι) (hT : T ⊆ B) :
    (1 - ∑ i ∈ B, q i) * (∏ i ∈ T, q i) ≤
      prob (mass q K) (fun v => occupied B v = T) := by
  classical
  let w := mass q K
  have hw := nonnegative_mass h0 h1 K
  let A (v : ι → Fin (K+1)) := ∀ i ∈ T, 1 ≤ (v i : ℕ)
  let C (v : ι → Fin (K+1)) := A v ∧ occupied B v ≠ T
  have hhit : prob w A = ∏ i ∈ T, q i := by simpa [w,A] using all_hit q T 1 hK
  have he : prob w A ≤ prob w (fun v => occupied B v = T) + prob w C := by
    unfold prob
    rw [← sum_add_distrib]
    apply sum_le_sum
    intro v _
    by_cases ha : A v <;> by_cases ht : occupied B v = T <;> simp [C, ha, ht, hw, w]
  let X (i : ι) (v : ι → Fin (K+1)) := ∀ j ∈ insert i T, 1 ≤ (v j : ℕ)
  have huv : prob w C ≤ ∑ i ∈ B \ T, prob w (X i) := by
    apply cover hw
    intro v hv
    have hsub : T ⊆ occupied B v := fun i hi => mem_filter.mpr ⟨hT hi, hv.1 i hi⟩
    obtain ⟨i, hi, hnot⟩ := Finset.not_subset.mp (show ¬ occupied B v ⊆ T from
      fun h' => hv.2 (Subset.antisymm h' hsub))
    refine ⟨i, mem_sdiff.mpr ⟨(mem_filter.mp hi).1, hnot⟩, ?_⟩
    intro j hj
    rcases mem_insert.mp hj with rfl | hj
    · exact (mem_filter.mp hi).2
    · exact hv.1 j hj
  have hx : (∑ i ∈ B \ T, prob w (X i)) ≤ (∑ i ∈ B, q i) * ∏ i ∈ T, q i := by
    rw [sum_mul]
    calc
      _ = ∑ i ∈ B \ T, q i * ∏ j ∈ T, q j := by
        apply sum_congr rfl
        intro i hi
        simpa [w, X, prod_insert (mem_sdiff.mp hi).2] using all_hit q (insert i T) 1 hK
      _ ≤ _ := sum_le_sum_of_subset_of_nonneg sdiff_subset
        (fun i _ _ => mul_nonneg (h0 i) (prod_nonneg fun j _ => h0 j))
  rw [hhit] at he
  linarith [huv.trans hx]

end
end SizeGeom

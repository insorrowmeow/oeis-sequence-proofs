import Mathlib.Combinatorics.Enumerative.Partition
import Mathlib.Data.Fintype.Card
import Mathlib.Data.Fintype.Sum
import Mathlib.Data.Finset.Max

/-! The small-rank comparison for symmetric differences of Gaussian coefficients.
Partitions are mathlib's unordered multisets of positive parts. -/

namespace GaussianEdge

open Multiset

/-- Partitions of weight n with allowed parts in [l,k]. -/
abbrev Restricted (l k n : ℕ) :=
  {p : Nat.Partition n // ∀ j ∈ p.parts, l ≤ j ∧ j ≤ k}

noncomputable def count (l k n : ℕ) : ℕ := by
  classical
  exact Fintype.card (Restricted l k n)

private theorem padding (s : ℕ) (hs : s ≠ 1) :
    ∃ t : Multiset ℕ, t.sum = s ∧ ∀ j ∈ t, j = 2 ∨ j = 3 := by
  by_cases he : s % 2 = 0
  · refine ⟨replicate (s / 2) 2, ?_, ?_⟩
    · simp; omega
    · exact fun _ hj => Or.inl (eq_of_mem_replicate hj)
  · refine ⟨3 ::ₘ replicate ((s-3)/2) 2, ?_, ?_⟩
    · simp; omega
    · intro j hj
      rcases mem_cons.mp hj with h | h
      · exact Or.inr h
      · exact Or.inl (eq_of_mem_replicate h)

/-- Adjoining a fixed partition of s into twos and threes is injective. -/
theorem padding_embedding_of_le (d k n s : ℕ) (hd : d ≤ k) (hk : 3 ≤ k) (hs : s ≠ 1) :
    Nonempty (Restricted 2 d n ↪ Restricted 2 k (n+s)) := by
  obtain ⟨t, hsum, hparts⟩ := padding s hs
  let f : Restricted 2 d n → Restricted 2 k (n+s) := fun x =>
    ⟨⟨x.val.parts + t,
       fun hj => by
         rcases mem_add.mp hj with h | h
         · exact x.val.parts_pos h
         · rcases hparts _ h with h₂ | h₃ <;> omega,
       by rw [sum_add, hsum, x.val.parts_sum]⟩,
     fun j hj => by
       rcases mem_add.mp hj with h | h
       · have := x.property j h
         omega
       · rcases hparts _ h with h₂ | h₃ <;> omega⟩
  refine ⟨⟨f, ?_⟩⟩
  intro x y h
  apply Subtype.ext
  apply Nat.Partition.ext
  exact add_right_cancel (congrArg (fun z : Restricted 2 k (n+s) => z.val.parts) h)

theorem padding_embedding (k n s : ℕ) (hk : 3 ≤ k) (hs : s ≠ 1) :
    Nonempty (Restricted 2 (k-2) n ↪ Restricted 2 k (n+s)) :=
  padding_embedding_of_le _ _ _ _ (by omega) hk hs

theorem padding_count_of_le (d k n s : ℕ) (hd : d ≤ k) (hk : 3 ≤ k) (hs : s ≠ 1) :
    count 2 d n ≤ count 2 k (n+s) := by
  classical
  obtain ⟨f⟩ := padding_embedding_of_le d k n s hd hk hs
  exact Fintype.card_le_of_embedding f

theorem padding_count (k n s : ℕ) (hk : 3 ≤ k) (hs : s ≠ 1) :
    count 2 (k-2) n ≤ count 2 k (n+s) := by
  classical
  obtain ⟨f⟩ := padding_embedding k n s hk hs
  exact Fintype.card_le_of_embedding f

private def hasOneEquiv (k n : ℕ) (hk : 1 ≤ k) :
    {x : Restricted 1 k (n+1) // 1 ∈ x.val.parts} ≃ Restricted 1 k n where
  toFun x :=
    ⟨⟨x.val.val.parts.erase 1,
        fun hj => x.val.val.parts_pos (mem_of_le (erase_le _ _) hj),
        by
          have h := congrArg Multiset.sum (cons_erase x.property)
          rw [sum_cons, x.val.val.parts_sum] at h
          omega⟩,
      fun j hj => x.val.property j (mem_of_le (erase_le _ _) hj)⟩
  invFun x :=
    ⟨⟨⟨1 ::ₘ x.val.parts, fun hj => by
          rcases mem_cons.mp hj with h | h
          · omega
          · exact x.val.parts_pos h,
        by simp [x.val.parts_sum, Nat.add_comm]⟩,
       fun j hj => by
        rcases mem_cons.mp hj with h | h
        · omega
        · exact x.property j h⟩, mem_cons_self _ _⟩
  left_inv x := Subtype.ext (Subtype.ext (Nat.Partition.ext (cons_erase x.property)))
  right_inv x := Subtype.ext (Nat.Partition.ext (by simp))

private def noOneEquiv (k n : ℕ) :
    {x : Restricted 1 k n // 1 ∉ x.val.parts} ≃ Restricted 2 k n where
  toFun x := ⟨x.val.val, fun j hj => by
    have h := x.val.property j hj
    have hj1 : j ≠ 1 := fun h => x.property (h ▸ hj)
    omega⟩
  invFun x := ⟨⟨x.val, fun j hj => by have := x.property j hj; omega⟩,
    fun hj => by have := x.property 1 hj; omega⟩
  left_inv _ := rfl
  right_inv _ := rfl

/-- The first difference for unrestricted length counts partitions without ones. -/
theorem count_step (k n : ℕ) (hk : 1 ≤ k) :
    count 1 k (n+1) = count 1 k n + count 2 k (n+1) := by
  classical
  let e := (Equiv.sumCompl (fun x : Restricted 1 k (n+1) => 1 ∈ x.val.parts)).symm.trans
    (Equiv.sumCongr (hasOneEquiv k n hk) (noOneEquiv k (n+1)))
  exact (Fintype.card_congr e).trans Fintype.card_sum

private theorem length_le_weight (t : Multiset ℕ) (h : ∀ j ∈ t, 0 < j) : t.card ≤ t.sum := by
  induction t using Multiset.induction_on with
  | empty => simp
  | cons a t ih =>
    have ha := h a (mem_cons_self _ _)
    have hi := ih (fun j hj => h j (mem_cons_of_mem hj))
    simp only [card_cons, sum_cons]
    omega

/-- The coefficient of q^n in the Gaussian for a k-by-w rectangle, counted
in its transposed orientation (at most w positive parts, each at most k). -/
noncomputable def gaussianRank (k w n : ℕ) : ℕ := by
  classical
  exact Fintype.card {x : Restricted 1 k n // x.val.parts.card ≤ w}

theorem gaussianRank_at_edge (k w n : ℕ) (hw : n ≤ w) :
    gaussianRank k w n = count 1 k n := by
  classical
  let e : {x : Restricted 1 k n // x.val.parts.card ≤ w} ≃ Restricted 1 k n :=
    { toFun := Subtype.val
      invFun := fun x => ⟨x, by
        have h := length_le_weight x.val.parts (fun _ hj => x.val.parts_pos hj)
        rw [x.val.parts_sum] at h
        omega⟩
      left_inv := fun _ => rfl
      right_inv := fun _ => rfl }
  exact Fintype.card_congr e

theorem gaussian_first_difference (k w n : ℕ) (hk : 1 ≤ k) (hn : n+1 ≤ w) :
    gaussianRank k w (n+1) - gaussianRank k w n = count 2 k (n+1) := by
  rw [gaussianRank_at_edge _ _ _ hn, gaussianRank_at_edge _ _ _ (show n ≤ w by omega),
      count_step k n hk]
  omega

/-- The comparison of the *actual* two rectangle first differences in the
range in which both upper-length restrictions are inactive. -/
theorem gaussian_difference_comparison (k w v n s : ℕ)
    (hk : 3 ≤ k) (hs : s ≠ 1) (hv : n+1 ≤ v) (hw : n+s+1 ≤ w) :
    gaussianRank (k-2) v (n+1) - gaussianRank (k-2) v n ≤
      gaussianRank k w (n+s+1) - gaussianRank k w (n+s) := by
  rw [gaussian_first_difference _ _ _ (by omega) hv,
    gaussian_first_difference _ _ _ (by omega) hw]
  rw [show n+s+1 = n+1+s by omega]
  exact padding_count k (n+1) s hk hs

private theorem largePartWitness (k r : ℕ) (hk : 5 ≤ k) (hr : k-1 ≤ r) :
    ∃ x : Restricted 2 k r, ∃ j ∈ x.val.parts, k-2 < j := by
  let j := if r = k-1 ∨ r = k+1 then k-1 else k
  have hjk : k-2 < j ∧ 2 ≤ j ∧ j ≤ k ∧ j ≤ r ∧ r-j ≠ 1 := by
    dsimp [j]; split <;> omega
  obtain ⟨t, ht, hparts⟩ := padding (r-j) hjk.2.2.2.2
  refine ⟨⟨⟨j ::ₘ t, ?_, ?_⟩, ?_⟩, j, mem_cons_self _ _, hjk.1⟩
  · intro u hu
    rcases mem_cons.mp hu with h | h
    · omega
    · rcases hparts _ h with h₂ | h₃ <;> omega
  · simp only [sum_cons, ht]; omega
  · intro u hu
    rcases mem_cons.mp hu with h | h
    · omega
    · rcases hparts _ h with h₂ | h₃ <;> omega

/-- The stronger strict comparison from rank k−1 onward. Every partition
with a part larger than k−2 escapes the image of the padding map. -/
theorem strict_padding_count (k n s : ℕ) (hk : 5 ≤ k) (hs : s ≠ 1) (hr : k-1 ≤ n+s) :
    count 2 (k-2) n < count 2 k (n+s) := by
  classical
  have h := padding_count_of_le (k-2) (k-2) n s le_rfl (by omega) hs
  apply lt_of_le_of_lt h
  let incl : Restricted 2 (k-2) (n+s) → Restricted 2 k (n+s) := fun x =>
    ⟨x.val, fun i hi => by have := x.property i hi; omega⟩
  obtain ⟨w, j, hj, hlarge⟩ := largePartWitness k (n+s) hk hr
  apply Fintype.card_lt_of_injective_of_not_mem incl (b := w)
  · intro x y hxy
    exact Subtype.ext (congrArg (fun z : Restricted 2 k (n+s) => z.val) hxy)
  · rintro ⟨x, hx⟩
    have hval : x.val = w.val := congrArg Subtype.val hx
    have hjx := x.property j (hval ▸ hj)
    omega

theorem count_zero (l k : ℕ) : count l k 0 = 1 := by
  classical
  letI : Unique (Restricted l k 0) :=
    { default := ⟨default, by simp [Nat.Partition.partition_zero_parts]⟩
      uniq := fun _ => Subtype.ext (Subsingleton.elim _ _) }
  exact Fintype.card_unique

/-- At the first nonzero coefficient of the shifted rectangle, its first
difference is one. Padding the empty partition deals with this endpoint. -/
theorem onset (k w t : ℕ) (hk : 3 ≤ k) (hs : t+1 ≠ 1) (hw : t+1 ≤ w) :
    1 ≤ gaussianRank k w (t+1) - gaussianRank k w t := by
  rw [gaussian_first_difference k w t (by omega) hw]
  have h := padding_count k 0 (t+1) hk hs
  rwa [count_zero, Nat.zero_add] at h

private theorem count_one (k : ℕ) (hk : 1 ≤ k) : count 1 k 1 = 1 := by
  classical
  letI : Unique (Restricted 1 k 1) :=
    { default := ⟨default, fun j hj => by
        rw [Nat.Partition.partition_one_parts] at hj
        have h := mem_singleton.mp hj
        omega⟩
      uniq := fun _ => Subtype.ext (Subsingleton.elim _ _) }
  exact Fintype.card_unique

private theorem count_single_two (k : ℕ) (hk : 2 ≤ k) : count 2 k 2 = 1 := by
  classical
  let p : Restricted 2 k 2 :=
    ⟨⟨{2}, fun hj => by have := mem_singleton.mp hj; omega, by simp⟩,
      fun j hj => by have := mem_singleton.mp hj; omega⟩
  letI : Unique (Restricted 2 k 2) :=
    { default := p
      uniq := by
        intro x
        apply Subtype.ext
        apply Nat.Partition.ext
        have hall (j : ℕ) (hj : j ∈ x.val.parts) : j = 2 := by
          have := (Multiset.le_sum_of_mem hj).trans_eq x.val.parts_sum
          have := x.property j hj
          omega
        have he := Multiset.eq_replicate_card.mpr hall
        have hw := congrArg Multiset.sum he
        rw [x.val.parts_sum, Multiset.sum_replicate] at hw
        simp only [nsmul_eq_mul] at hw
        have hcast : 2 = x.val.parts.card * 2 := hw
        have hc : x.val.parts.card = 1 := by omega
        simpa [hc] using he }
  exact Fintype.card_unique

/-- Coefficients of the centered difference at shift one, counting each
rectangle by actual partitions and using integer coefficient subtraction. -/
noncomputable def shiftOneCoeff (k w v : ℕ) : ℕ → ℤ
  | 0 => (gaussianRank k w 0 : ℤ)
  | n+1 => (gaussianRank k w (n+1) : ℤ) - (gaussianRank (k-2) v n : ℤ)

theorem shift_one_exception (k w v : ℕ) (hk : 5 ≤ k) (hw : 2 ≤ w) (hv : 2 ≤ v) :
    shiftOneCoeff k w v 0 = 1 ∧ shiftOneCoeff k w v 1 = 0 ∧ shiftOneCoeff k w v 2 = 1 := by
  have htwo : count 1 k 2 = 2 := by
    rw [count_step k 1 (by omega), count_one k (by omega), count_single_two k (by omega)]
  simp only [shiftOneCoeff, gaussianRank_at_edge _ _ _ (show 0 ≤ w by omega),
    gaussianRank_at_edge _ _ _ (show 1 ≤ w by omega), gaussianRank_at_edge _ _ _ hw,
    gaussianRank_at_edge _ _ _ (show 0 ≤ v by omega), gaussianRank_at_edge _ _ _ (show 1 ≤ v by omega),
    count_zero, count_one k (by omega), count_one (k-2) (by omega), htwo]
  decide

/-- A positive source weight also allows a one-unit shift. Raising a largest
part gives a uniquely largest part in the image, which identifies the inverse. -/
theorem raise_max_embedding (d k n : ℕ) (hdk : d < k) (hn : 0 < n) :
    Nonempty (Restricted 2 d n ↪ Restricted 2 k (n+1)) := by
  classical
  have nonempty (x : Restricted 2 d n) : x.val.parts.toFinset.Nonempty := by
    have hne : x.val.parts ≠ 0 := by
      intro h
      have hs := x.val.parts_sum
      rw [h, sum_zero] at hs
      omega
    obtain ⟨j,hj⟩ := exists_mem_of_ne_zero hne
    exact ⟨j, mem_toFinset.mpr hj⟩
  let top (x : Restricted 2 d n) := x.val.parts.toFinset.max' (nonempty x)
  have present (x : Restricted 2 d n) : top x ∈ x.val.parts :=
    mem_toFinset.mp (Finset.max'_mem _ _)
  have bound (x : Restricted 2 d n) (j : ℕ) (hj : j ∈ x.val.parts) : j ≤ top x :=
    Finset.le_max' _ j (mem_toFinset.mpr hj)
  let raised (x : Restricted 2 d n) := (top x + 1) ::ₘ x.val.parts.erase (top x)
  have newbound (x : Restricted 2 d n) (j : ℕ) (hj : j ∈ raised x) : j ≤ top x + 1 := by
    rcases mem_cons.mp hj with h | h
    · omega
    · exact (bound x j (mem_of_le (erase_le _ _) h)).trans (by omega)
  let f : Restricted 2 d n → Restricted 2 k (n+1) := fun x =>
    ⟨⟨raised x, fun hj => by
        rcases mem_cons.mp hj with h | h
        · omega
        · exact x.val.parts_pos (mem_of_le (erase_le _ _) h),
       by
        have h := congrArg Multiset.sum (cons_erase (present x))
        rw [sum_cons, x.val.parts_sum] at h
        change ((top x + 1) ::ₘ x.val.parts.erase (top x)).sum = _
        rw [sum_cons]
        omega⟩,
      fun j hj => by
        have hmax := x.property (top x) (present x)
        rcases mem_cons.mp hj with h | h
        · omega
        · have := x.property j (mem_of_le (erase_le _ _) h)
          omega⟩
  refine ⟨⟨f, ?_⟩⟩
  intro x y hxy
  have he : raised x = raised y :=
    congrArg (fun z : Restricted 2 k (n+1) => z.val.parts) hxy
  have htx : top x + 1 ∈ raised x := mem_cons_self _ _
  have hty : top y + 1 ∈ raised y := mem_cons_self _ _
  have h₁ := newbound y _ (he ▸ htx)
  have h₂ := newbound x _ (he.symm ▸ hty)
  have htop : top x = top y := by omega
  change (top x + 1) ::ₘ x.val.parts.erase (top x) =
    (top y + 1) ::ₘ y.val.parts.erase (top y) at he
  rw [htop] at he
  have hrest := (cons_inj_right _).mp he
  apply Subtype.ext
  apply Nat.Partition.ext
  calc
    x.val.parts = top x ::ₘ x.val.parts.erase (top x) := (cons_erase (present x)).symm
    _ = top y ::ₘ y.val.parts.erase (top y) := by rw [htop, hrest]
    _ = y.val.parts := cons_erase (present y)

theorem raise_max_count (d k n : ℕ) (hdk : d < k) (hn : 0 < n) :
    count 2 d n ≤ count 2 k (n+1) := by
  classical
  obtain ⟨f⟩ := raise_max_embedding d k n hdk hn
  exact Fintype.card_le_of_embedding f

#print axioms gaussian_difference_comparison
#print axioms onset
#print axioms strict_padding_count
#print axioms shift_one_exception
#print axioms raise_max_count

end GaussianEdge

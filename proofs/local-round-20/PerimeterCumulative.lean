import PerimeterPartitions

/-! Cumulative perimeter is grouped by total length. A nonempty partition with
length t has perimeter at most n exactly when its largest part is at most
n+1-t. The empty partition contributes one. -/

namespace PerimeterFinite

open Finset
noncomputable section

def cumulative (q : ℕ → ℝ) (n : ℕ) : ℝ :=
  ∑ l ∈ range (n+1), coeff q (n+1-l) l

def cumulativeParts (n : ℕ) : Finset (List ℕ) :=
  (range (n+1)).biUnion fun l => parts (n+1-l) l

@[simp] theorem nil_mem_cumulativeParts (n : ℕ) : [] ∈ cumulativeParts n := by
  exact mem_biUnion.mpr ⟨0, by simp, by simp [parts]⟩

theorem mem_cumulativeParts (a : ℕ) (xs : List ℕ) (n : ℕ) :
    a::xs ∈ cumulativeParts n ↔ a + xs.length ≤ n ∧
      (a::xs).Pairwise (· ≥ ·) ∧ ∀ b ∈ a::xs, 0 < b := by
  simp only [cumulativeParts, mem_biUnion, mem_range, mem_parts, List.length_cons,
    List.pairwise_cons, List.mem_cons]
  constructor
  · rintro ⟨l, hl, hlen, ⟨hm, hs⟩, hb⟩
    have ha := hb a (Or.inl rfl)
    exact ⟨by omega, ⟨hm, hs⟩, fun b h => (hb b h).1⟩
  · rintro ⟨H, ⟨hm, hs⟩, hp⟩
    have ha := hp a (Or.inl rfl)
    refine ⟨xs.length+1, by omega, rfl, ⟨hm, hs⟩, ?_⟩
    intro b hb
    refine ⟨hp b hb, ?_⟩
    rcases hb with rfl | hb
    · omega
    · have := hm b hb
      omega

theorem cumulative_eq_weight_sum (q : ℕ → ℝ) (n : ℕ) :
    cumulative q n = ∑ x ∈ cumulativeParts n, weight q x := by
  dsimp only [cumulative, cumulativeParts]
  rw [sum_biUnion]
  · apply sum_congr rfl
    intro l _
    exact coeff_eq_parts q _ _
  · intro i hi j hj hne
    apply disjoint_left.mpr
    intro x hx hy
    exact hne (((mem_parts _ _ _).mp hx).1.symm.trans ((mem_parts _ _ _).mp hy).1)

theorem cumulative_eq_norm_sum (p : ℕ → ℝ) (n : ℕ) :
    cumulative (fun j => 1 / p (j+1)) n = ∑ x ∈ cumulativeParts n, 1 / indexedNorm p x := by
  rw [cumulative_eq_weight_sum]
  apply sum_congr rfl
  intro x hx
  apply weight_eq_inv
  cases x with
  | nil => simp
  | cons a xs => exact ((mem_cumulativeParts a xs n).mp hx).2.2

theorem cumulative_bounds {q : ℕ → ℝ} (hq : ∀ j, 0 ≤ q j) (hq' : ∀ j, q j < 1)
    {n L : ℕ} (hL : L ≤ n) :
    euler q (n-L) - tail q (n-L) L ≤ cumulative q n ∧ cumulative q n ≤ euler q n := by
  have hs := coeff_hasSum hq hq' (n-L)
  have he : (∑ l ∈ range (L+1), coeff q (n-L) l) + tail q (n-L) L =
      euler q (n-L) := (hs.summable.sum_add_tsum_nat_add (L+1)).trans hs.tsum_eq
  constructor
  · calc
      _ = ∑ l ∈ range (L+1), coeff q (n-L) l := by linarith
      _ ≤ ∑ l ∈ range (L+1), coeff q (n+1-l) l := by
        apply sum_le_sum
        intro l hl
        exact coeff_mono hq l (by have := mem_range.mp hl; omega)
      _ ≤ _ := sum_le_sum_of_subset_of_nonneg (range_mono (Nat.succ_le_succ hL))
        (fun _ _ _ => coeff_nonneg hq _ _)
  · calc
      _ ≤ ∑ l ∈ range (n+1), coeff q n l := by
        apply sum_le_sum
        intro l _
        cases l with
        | zero => simp only [Nat.sub_zero]; rw [coeff_eq_parts, coeff_eq_parts]; simp [parts]
        | succ l => exact coeff_mono hq _ (by omega)
      _ ≤ ∑' l, coeff q n l := Summable.sum_le_tsum _ (fun _ _ => coeff_nonneg hq _ _)
        (coeff_hasSum hq hq' _).summable
      _ = _ := (coeff_hasSum hq hq' n).tsum_eq

theorem cumulative_gap {q : ℕ → ℝ} {r : ℝ} (hr : 1 ≤ r)
    (hq : ∀ j, 0 ≤ q j) (hq' : ∀ j, q j < 1) (hqr : ∀ j, r*q j < 1)
    {n L : ℕ} (hL : L ≤ n) :
    0 ≤ euler q n - cumulative q n ∧ euler q n - cumulative q n ≤
      euler q n - euler q (n-L) + euler (fun j => r*q j) (n-L) / r^L := by
  obtain ⟨hlo, hhi⟩ := cumulative_bounds hq hq' hL
  exact ⟨sub_nonneg.mpr hhi, by linarith [tail_le_tilt hr hq hq' hqr (n-L) L]⟩

end
end PerimeterFinite


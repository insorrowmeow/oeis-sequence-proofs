import PerimeterFinite

/-! A finite-set realization of the perimeter supernorm sum. Each partition is
represented by its unique weakly decreasing list of positive parts. -/

namespace PerimeterFinite

open Finset
noncomputable section

/-- Lists of exactly l parts, each at most m. Distinct heads are disjoint. -/
def parts (m : ℕ) : ℕ → Finset (List ℕ)
  | 0 => {[]}
  | l+1 => (range m).biUnion (fun j => (parts (j+1) l).image (List.cons (j+1)))

theorem mem_parts (x : List ℕ) (m l : ℕ) :
    x ∈ parts m l ↔ x.length = l ∧ x.Pairwise (· ≥ ·) ∧ ∀ a ∈ x, 0 < a ∧ a ≤ m := by
  induction l generalizing m x with
  | zero =>
    cases x <;> simp [parts]
  | succ l ih =>
    cases x with
    | nil => simp [parts]
    | cons a x =>
      simp only [parts, mem_biUnion, mem_range, mem_image, List.cons.injEq, exists_prop,
        List.length_cons, Nat.succ.injEq, List.pairwise_cons, List.mem_cons]
      constructor
      · rintro ⟨j, hj, y, hy, e, rfl⟩
        subst a
        obtain ⟨hl, hsort, ha⟩ := (ih y (j+1)).mp hy
        refine ⟨hl, ⟨fun b hb => (ha b hb).2, hsort⟩, ?_⟩
        intro b hb
        rcases hb with rfl | hb
        · omega
        · exact ⟨(ha b hb).1, by have := (ha b hb).2; omega⟩
      · rintro ⟨hl, ⟨hmax, hsort⟩, hb⟩
        obtain ⟨ha, ham⟩ := hb a (Or.inl rfl)
        obtain ⟨j, rfl⟩ := Nat.exists_eq_succ_of_ne_zero (Nat.ne_of_gt ha)
        exact ⟨j, by omega, x, (ih x (j+1)).mpr ⟨hl, hsort,
          fun b hz => ⟨(hb b (Or.inr hz)).1, hmax b hz⟩⟩, rfl, rfl⟩

def weight (q : ℕ → ℝ) (x : List ℕ) := (x.map fun a => q (a-1)).prod

private theorem head_sums (q : ℕ → ℝ) (A : Finset ℕ) (B : ℕ → Finset (List ℕ))
    (g : ℕ → ℕ) (hinj : Set.InjOn g (↑A)) :
    ∑ x ∈ A.biUnion (fun j => (B j).image (List.cons (g j))), weight q x =
      ∑ j ∈ A, q (g j-1) * ∑ x ∈ B j, weight q x := by
  rw [sum_biUnion]
  · apply sum_congr rfl
    intro j _
    rw [sum_image]
    · simp [weight, Finset.mul_sum]
    · intro a ha b hb h
      exact (List.cons.inj h).2
  · intro i hi j hj hne
    apply disjoint_left.mpr
    intro x hx hy
    obtain ⟨a, _, rfl⟩ := mem_image.mp hx
    obtain ⟨b, _, h⟩ := mem_image.mp hy
    exact hne (hinj hi hj (List.cons.inj h).1.symm)

theorem coeff_zero (q : ℕ → ℝ) (m : ℕ) : coeff q m 0 = 1 := by
  induction m with
  | zero => simp [coeff]
  | succ m ih => simp [coeff, ih]

theorem coeff_step (q : ℕ → ℝ) (m l : ℕ) :
    coeff q (m+1) (l+1) = coeff q m (l+1) + q m * coeff q (m+1) l := by
  simp only [coeff]
  rw [sum_range_succ', Finset.mul_sum, add_comm]
  simp only [pow_zero, Nat.sub_zero, one_mul]
  congr 1
  apply sum_congr rfl
  intro j hj
  simp only [pow_succ', Nat.add_sub_add_right, mul_assoc]

theorem coeff_eq_parts (q : ℕ → ℝ) (m l : ℕ) :
    coeff q m l = ∑ x ∈ parts m l, weight q x := by
  induction l generalizing m with
  | zero => simp [parts, weight, coeff_zero]
  | succ l ih =>
    simp only [parts]
    rw [head_sums q _ _ _ (fun _ _ _ _ e => Nat.add_right_cancel e)]
    simp only [Nat.add_sub_cancel, ← ih]
    induction m with
    | zero => simp [coeff]
    | succ m hm => rw [sum_range_succ, ← hm, coeff_step]

/-- Each partition of perimeter n is represented once; l is the length after
deleting a largest part, so the largest part is forced to equal n-l. -/
def perimeterParts (n : ℕ) : Finset (List ℕ) :=
  (range n).biUnion fun l => (parts (n-l) l).image (List.cons (n-l))

@[simp] theorem nil_not_mem_perimeterParts (n : ℕ) : [] ∉ perimeterParts n := by
  simp [perimeterParts]

theorem mem_perimeterParts (a : ℕ) (xs : List ℕ) (n : ℕ) :
    a::xs ∈ perimeterParts n ↔ a + xs.length = n ∧
      (a::xs).Pairwise (· ≥ ·) ∧ ∀ b ∈ a::xs, 0 < b := by
  simp only [perimeterParts, mem_biUnion, mem_range, mem_image, List.cons.injEq,
    exists_prop, List.pairwise_cons, List.mem_cons]
  constructor
  · rintro ⟨l, hl, x, hx, eq, rfl⟩
    obtain ⟨hs, hsort, hall⟩ := (mem_parts x (n-l) l).mp hx
    refine ⟨by omega, ⟨fun b hb => by have := (hall b hb).2; omega, hsort⟩, ?_⟩
    intro b hb
    rcases hb with rfl | hb
    · omega
    · exact (hall b hb).1
  · rintro ⟨H, ⟨hm, hs⟩, hp⟩
    have ha := hp a (Or.inl rfl)
    refine ⟨xs.length, by omega, xs, (mem_parts xs _ _).mpr ⟨rfl, hs, ?_⟩, by omega, rfl⟩
    intro b hb
    exact ⟨hp b (Or.inr hb), by have := hm b hb; omega⟩

/-- Supernorm for one-based p, the product of the prime indexed by each part. -/
def indexedNorm (p : ℕ → ℝ) (x : List ℕ) : ℝ := (x.map p).prod

theorem weight_eq_inv (p : ℕ → ℝ) (x : List ℕ) (hx : ∀ a ∈ x, 0<a) :
    weight (fun j => 1 / p (j+1)) x = 1 / indexedNorm p x := by
  induction x with
  | nil => simp [weight, indexedNorm]
  | cons a x ih =>
    have ha := hx a (List.mem_cons_self)
    change (1 / p (a-1+1)) * weight (fun j => 1 / p (j+1)) x = 1 / (p a * indexedNorm p x)
    rw [show a-1+1=a by omega, ih (fun b hb => hx b (List.mem_cons_of_mem a hb))]
    simp [one_div, mul_comm]

/-- The recursive shell is exactly the sum of reciprocal supernorms of
partitions of the specified perimeter. -/
theorem shell_eq_perimeter_sum (p : ℕ → ℝ) (n : ℕ) :
    shell p n = ∑ x ∈ perimeterParts n, 1 / indexedNorm p x := by
  let q := fun j => 1 / p (j+1)
  calc
    shell p n = ∑ x ∈ perimeterParts n, weight q x := by
      dsimp only [shell, perimeterParts]
      rw [head_sums q _ _ _ (by
        intro i hi j hj e
        change i ∈ range n at hi
        change j ∈ range n at hj
        have hi' := mem_range.mp hi
        have hj' := mem_range.mp hj
        change n-i = n-j at e
        omega)]
      apply sum_congr rfl
      intro l hl
      have hl' := mem_range.mp hl
      change coeff q (n-l) l / p (n-l) = (1 / p (n-l-1+1)) * _
      rw [show n-l-1+1 = n-l by omega, coeff_eq_parts]
      ring
    _ = _ := by
      apply sum_congr rfl
      intro x hx
      apply weight_eq_inv p x
      cases x with
      | nil => simp
      | cons a xs => exact ((mem_perimeterParts a xs n).mp hx).2.2

end
end PerimeterFinite




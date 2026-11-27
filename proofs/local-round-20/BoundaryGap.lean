import PerimeterCumulative

/-! Exact decomposition of the gap between maximum-part and perimeter
ensembles by deleting one copy of the maximum part. -/
namespace PerimeterFinite
open Finset
noncomputable section

private def window (q : ℕ → ℝ) (n m : ℕ) :=
  ∑ l ∈ range (n+1), coeff q (min m (n+1-l)) l

private theorem window_last (q : ℕ → ℝ) (n : ℕ) :
    window q n n = cumulative q n := by
  apply sum_congr rfl
  intro l _
  cases l with
  | zero => rw [coeff_zero, coeff_zero]
  | succ l => rw [min_eq_right (by omega)]

private theorem window_start (q : ℕ → ℝ) (n : ℕ) : window q n 0 = 1 := by
  simp [window, coeff]

private theorem window_step (q : ℕ → ℝ) {n m : ℕ} (hm : m<n) :
    window q n (m+1) - window q n m =
      q m * ∑ l ∈ range (n-m), coeff q (m+1) l := by
  simp only [window, ← Finset.sum_sub_distrib]
  rw [sum_range_succ']
  simp only [coeff_zero, sub_self, add_zero]
  let f := fun l => coeff q (min (m+1) (n+1-(l+1))) (l+1) -
    coeff q (min m (n+1-(l+1))) (l+1)
  change ∑ l ∈ range n, f l = _
  have hs := Finset.sum_range_add f (n-m) m
  rw [Nat.sub_add_cancel hm.le] at hs
  rw [hs]
  have hz : ∑ j ∈ range m, f (n-m+j) = 0 := by
    apply sum_eq_zero
    intro j hj
    dsimp [f]
    rw [min_eq_right (by omega), min_eq_right (by omega), sub_self]
  rw [hz, add_zero, Finset.mul_sum]
  apply sum_congr rfl
  intro l hl
  have hl' := mem_range.mp hl
  dsimp [f]
  rw [min_eq_left (by omega), min_eq_left (by omega), coeff_step]
  ring

/-- j is the zero-based index of a largest part, so its length allowance after
deletion is n-(j+1). -/
theorem gap_decomposition {q : ℕ → ℝ} (hq : ∀ j, 0 ≤ q j) (hq' : ∀ j, q j < 1)
    (n : ℕ) :
    euler q n - cumulative q n =
      ∑ j ∈ range n, q j * tail q (j+1) (n-(j+1)) := by
  have H (m : ℕ) (hm : m≤n) : euler q m - window q n m =
      ∑ j ∈ range m, q j * tail q (j+1) (n-(j+1)) := by
    induction m with
    | zero => simp [euler, window_start]
    | succ m ih =>
      have hmn : m<n := by omega
      have hdelta : euler q (m+1) * (1-q m) = euler q m := by
        rw [euler, prod_range_succ, mul_assoc, inv_mul_cancel₀ (by linarith [hq' m]), mul_one]
        rfl
      have hs := coeff_hasSum hq hq' (m+1)
      have hrow : (∑ l ∈ range (n-m), coeff q (m+1) l) +
          tail q (m+1) (n-(m+1)) = euler q (m+1) := by
        unfold tail
        rw [show n-(m+1)+1 = n-m by omega]
        exact (hs.summable.sum_add_tsum_nat_add (n-m)).trans hs.tsum_eq
      have hw := window_step q hmn
      rw [sum_range_succ, ← ih hmn.le]
      rw [← hrow] at hdelta
      nlinarith [hrow, hw, hdelta]
  rw [← window_last]
  exact H n le_rfl

/-- Same formula with the residual-length cutoff t as index. -/
theorem gap_by_length {q : ℕ → ℝ} (hq : ∀ j, 0 ≤ q j) (hq' : ∀ j, q j < 1)
    (n : ℕ) :
    euler q n - cumulative q n =
      ∑ t ∈ range n, q (n-1-t) * tail q (n-t) t := by
  rw [gap_decomposition hq hq' n]
  apply Finset.sum_bij (fun j _ => n-1-j)
  · intro j hj
    have := mem_range.mp hj
    exact mem_range.mpr (by omega)
  · intro i hi j hj e
    have := mem_range.mp hi
    have := mem_range.mp hj
    change n-1-i=n-1-j at e
    omega
  · intro t ht
    have := mem_range.mp ht
    exact ⟨n-1-t, mem_range.mpr (by omega), by omega⟩
  · intro j hj
    have := mem_range.mp hj
    rw [show n-1-(n-1-j) = j by omega, show n-(n-1-j) = j+1 by omega,
      show n-1-j = n-(j+1) by omega]

theorem tail_nonneg {q : ℕ → ℝ} (hq : ∀ j, 0 ≤ q j) (m t : ℕ) :
    0 ≤ tail q m t := tsum_nonneg fun _ => coeff_nonneg hq _ _

theorem tail_mono {q : ℕ → ℝ} (hq : ∀ j, 0 ≤ q j) (hq' : ∀ j, q j < 1)
    (t : ℕ) : Monotone (fun m => tail q m t) := by
  intro a b hab
  apply Summable.tsum_le_tsum (fun i => coeff_mono hq _ hab)
    ((summable_nat_add_iff (t+1)).mpr (coeff_hasSum hq hq' a).summable)
    ((summable_nat_add_iff (t+1)).mpr (coeff_hasSum hq hq' b).summable)

/-- Exponential remainder when summing the residual-length tails themselves. -/
theorem tail_series_bound {q : ℕ → ℝ} (hq : ∀ j, 0 ≤ q j) (hq' : ∀ j, q j < 1)
    (hqr : ∀ j, (3/2 : ℝ)*q j < 1) (m L : ℕ) :
    Summable (fun j => tail q m (j+L)) ∧
      ∑' j, tail q m (j+L) ≤ 3 * euler (fun j => (3/2:ℝ)*q j) m / (3/2:ℝ)^L := by
  let C := euler (fun j => (3/2:ℝ)*q j) m / (3/2:ℝ)^L
  have hgeom : HasSum (fun j : ℕ => (2/3:ℝ)^j) 3 := by
    convert hasSum_geometric_of_lt_one (by norm_num : 0 ≤ (2/3:ℝ)) (by norm_num) using 1
    norm_num
  have hdom (j : ℕ) : tail q m (j+L) ≤ C * (2/3:ℝ)^j := by
    apply (tail_le_tilt (by norm_num : (1:ℝ) ≤ 3/2) hq hq' hqr m (j+L)).trans_eq
    dsimp only [C]
    simp only [pow_add, div_eq_mul_inv, mul_inv_rev, ← inv_pow, show (3/2:ℝ)⁻¹ = 2/3 by norm_num]
    ring
  have hcomp := hgeom.summable.mul_left C
  have hsum := Summable.of_nonneg_of_le (fun j => tail_nonneg hq _ _) hdom hcomp
  refine ⟨hsum, ?_⟩
  have hl := Summable.tsum_le_tsum hdom hsum hcomp
  rw [tsum_mul_left, hgeom.tsum_eq] at hl
  apply hl.trans_eq
  dsimp only [C]
  ring

/-- Sharp sandwich. The tsum of tails is the unnormalized first length
moment. The long-range portion is controlled uniformly by the tilted product. -/
theorem sharp_gap_bounds {q : ℕ → ℝ} (hanti : Antitone q)
    (hq : ∀ j, 0 ≤ q j) (hq' : ∀ j, q j < 1)
    (hqr : ∀ j, (3/2:ℝ)*q j < 1) {n L : ℕ} (hL : L ≤ n) :
    let E := fun m => 3 * euler (fun j => (3/2:ℝ)*q j) m / (3/2:ℝ)^L
    let S := fun m => ∑' t, tail q m t
    q (n-1) * S (n-L) - E (n-L) ≤ euler q n - cumulative q n ∧
      euler q n - cumulative q n ≤ q (n-1-L) * S n + E n := by
  let E := fun m => 3 * euler (fun j => (3/2:ℝ)*q j) m / (3/2:ℝ)^L
  let S := fun m => ∑' t, tail q m t
  let f := fun t => q (n-1-t) * tail q (n-t) t
  let short := fun m => ∑ t ∈ range L, tail q m t
  let long := fun m => ∑' j, tail q m (j+L)
  have ser (m : ℕ) : Summable (tail q m) :=
    (summable_nat_add_iff L).mp (tail_series_bound hq hq' hqr m L).1
  have full (m : ℕ) : short m + long m = S m := (ser m).sum_add_tsum_nat_add L
  have nnlong (m : ℕ) : 0 ≤ long m := tsum_nonneg (fun _ => tail_nonneg hq _ _)
  have elong (m : ℕ) : long m ≤ E m := (tail_series_bound hq hq' hqr m L).2
  rw [gap_by_length hq hq' n]
  change q (n-1) * S (n-L) - E (n-L) ≤ ∑ t ∈ range n, f t ∧
    ∑ t ∈ range n, f t ≤ q (n-1-L) * S n + E n
  have cut : ∑ t ∈ range n, f t = ∑ t ∈ range L, f t + ∑ j ∈ range (n-L), f (L+j) := by
    simpa [Nat.add_sub_of_le hL] using sum_range_add f L (n-L)
  constructor
  · have hlo : q (n-1) * short (n-L) ≤ ∑ t ∈ range L, f t := by
      simp only [short, mul_sum]
      apply sum_le_sum
      intro t ht
      apply mul_le_mul (hanti (Nat.sub_le _ _)) _ (tail_nonneg hq _ _) (hq _)
      apply tail_mono hq hq'
      have := mem_range.mp ht
      omega
    have hrest : 0 ≤ ∑ j ∈ range (n-L), f (L+j) :=
      sum_nonneg fun _ _ => mul_nonneg (hq _) (tail_nonneg hq _ _)
    have hw := mul_le_of_le_one_left (nnlong (n-L)) (hq' (n-1)).le
    rw [cut, ← full, mul_add]
    linarith [elong (n-L)]
  · have hi : ∑ t ∈ range L, f t ≤ q (n-1-L) * short n := by
      simp only [short, mul_sum]
      apply sum_le_sum
      intro t ht
      have ht' := mem_range.mp ht
      exact mul_le_mul (hanti (by omega)) (tail_mono hq hq' _ (Nat.sub_le n t))
        (tail_nonneg hq _ _) (hq _)
    have hrest : ∑ j ∈ range (n-L), f (L+j) ≤ long n := by
      apply le_trans _ (Summable.sum_le_tsum (range (n-L)) (fun _ _ => tail_nonneg hq _ _)
        (tail_series_bound hq hq' hqr n L).1)
      apply sum_le_sum
      intro j _
      unfold f
      rw [add_comm L j]
      apply (mul_le_of_le_one_left (tail_nonneg hq _ _) (hq' _).le).trans
      exact tail_mono hq hq' _ (Nat.sub_le n _)
    rw [cut, ← full, mul_add]
    linarith [elong n, mul_nonneg (hq (n-1-L)) (nnlong n)]

end
end PerimeterFinite


import Generators
import Mathlib.Data.Sym.Card
import Mathlib.Algebra.GeomSum

/-! For a fixed largest part, a partition is determined by the multiset
remaining after removal of one copy of its largest part. For gap partitions
of fixed length the same multiset describes the slack at each of the gaps.
Here these multisets are counted directly and summed through the perimeter. -/

namespace CriticalPerimeter
noncomputable section
open PowerSeries Finset
private abbrev x : PowerSeries ℝ := X
private abbrev y : PowerSeries ℝ := (1 - x)⁻¹

/-- Number of multisets of extra parts (or slack units) of total cardinality
`n-base` on an alphabet of `slots` symbols. -/
def multisetCount (slots base n : ℕ) : ℕ :=
  if base ≤ n then Fintype.card (Sym (Fin slots) (n-base)) else 0

/-- Partitions indexed by length `j+1`. Each slack unit belongs to the
bottom part or to one of the differences between consecutive parts. -/
def gapCount (s a n : ℕ) : ℕ :=
  ∑ j ∈ range (n+1), multisetCount (j+1) (a+s*j) n

/-- Partitions indexed by largest part `u+2sj` or `v+2sj`. The alphabet
consists of all allowed part sizes up to and including that largest part. -/
def residueCount (s u v n : ℕ) : ℕ :=
  ∑ j ∈ range (n+1), (multisetCount (2*j+1) (u+2*s*j) n +
    multisetCount (2*j+2) (v+2*s*j) n)

private theorem y_times : y*(1-x)=1 :=
  PowerSeries.inv_mul_cancel _ (by simp [x])

private theorem coeff_pow_y (k n : ℕ) :
    coeff ℝ n (y^k) = (Nat.multichoose k n : ℝ) := by
  induction k generalizing n with
  | zero => cases n <;> simp
  | succ k ih =>
    have h : y^(k+1) * (1-x) = y^k := by rw [pow_succ, mul_assoc, y_times, mul_one]
    induction n with
    | zero =>
      simp
    | succ n hn =>
      have h1 := congrArg (coeff ℝ (n+1)) h
      rw [mul_sub, mul_one, map_sub, coeff_succ_mul_X, hn, ih] at h1
      rw [Nat.multichoose_succ_succ, Nat.cast_add]
      linarith

private theorem coeff_rank (slots base n : ℕ) :
    coeff ℝ n (x^base*y^slots) = (multisetCount slots base n : ℝ) := by
  rw [coeff_X_pow_mul']
  by_cases h : base ≤ n <;> simp [multisetCount, h, Sym.card_sym_fin_eq_multichoose, coeff_pow_y]

private theorem truncated_blocks {f start unit : PowerSeries ℝ} {b : ℕ}
    (hb : 0 < b) (h : f*(1-x^b*unit)=start) (n : ℕ) :
    coeff ℝ n f = ∑ j ∈ range (n+1), coeff ℝ n (start*(x^b*unit)^j) := by
  let t := x^b*unit
  have he : start*(∑ j ∈ range (n+1), t^j) = f-f*t^(n+1) := by
    rw [← h, mul_assoc, ← show t = x^b*unit from rfl, mul_neg_geom_sum, mul_sub, mul_one]
  have ht : coeff ℝ n (f*t^(n+1))=0 := by
    have heq : f*t^(n+1) = (f*unit^(n+1))*x^(b*(n+1)) := by
      dsimp [t]
      rw [mul_pow, ← pow_mul]
      ring
    rw [heq, coeff_mul_X_pow', if_neg]
    have := Nat.le_mul_of_pos_left (n+1) hb
    omega
  have hh := congrArg (coeff ℝ n) he
  rw [Finset.mul_sum, map_sum, map_sub, ht, sub_zero] at hh
  exact hh.symm

private theorem gap_blocks (s a : ℕ) (hs : 0<s) :
    gapSeries s a*(1-x^s*y) = x^a*y := by
  have hf : gapSeries s a*(1-x-x^s)=x^a := by
    unfold gapSeries
    rw [mul_assoc, PowerSeries.inv_mul_cancel, mul_one]
    simp [x, hs.ne']
  have ht : 1-x^s*y = (1-x-x^s)*y := by
    rw [sub_mul, mul_comm (1-x) y, y_times]
  rw [ht, ← mul_assoc, hf]

theorem coefficient_gap_count (s a n : ℕ) (hs : 0<s) :
    coeff ℝ n (gapSeries s a) = (gapCount s a n : ℝ) := by
  rw [truncated_blocks hs (gap_blocks s a hs), gapCount, Nat.cast_sum]
  refine sum_congr rfl fun j _ => ?_
  rw [← coeff_rank, mul_pow, ← pow_mul, pow_add, pow_succ]
  ring_nf

private theorem residue_blocks (s u v : ℕ) (hs : 0<s) :
    residueSeries s u v*(1-x^(2*s)*y^2) = x^u*y + x^v*y^2 := by
  have hf : residueSeries s u v*denominator s x = x^u*(1-x)+x^v := by
    unfold residueSeries
    rw [mul_assoc, PowerSeries.inv_mul_cancel, mul_one]
    simp [denominator, x, hs.ne']
  have hy2 : (1-x)^2*y^2=1 := by rw [← mul_pow, mul_comm, y_times, one_pow]
  have ht : 1-x^(2*s)*y^2 = denominator s x*y^2 := by
    unfold denominator
    rw [sub_mul, ← pow_mul, Nat.mul_comm s 2, hy2]
  rw [ht, ← mul_assoc, hf, add_mul]
  have he : (1-x)*y^2=y := by rw [pow_two, ← mul_assoc, mul_comm (1-x), y_times, one_mul]
  rw [mul_assoc, he]

theorem coefficient_residue_count (s u v n : ℕ) (hs : 0<s) :
    coeff ℝ n (residueSeries s u v) = (residueCount s u v n : ℝ) := by
  rw [truncated_blocks (by omega : 0<2*s) (residue_blocks s u v hs), residueCount, Nat.cast_sum]
  refine sum_congr rfl fun j _ => ?_
  rw [Nat.cast_add, ← coeff_rank, ← coeff_rank, add_mul, map_add, mul_pow, ← pow_mul, ← pow_mul]
  simp only [pow_add, pow_two, pow_one]
  congr 2 <;> ring

#print axioms coefficient_gap_count
#print axioms coefficient_residue_count
end
end CriticalPerimeter

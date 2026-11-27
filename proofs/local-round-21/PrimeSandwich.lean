import TwoPartBounds
import OneBased

namespace PrimeSandwich
open Finset Filter
open scoped Topology
noncomputable section

abbrev q := OneBased.primeQ
def D (n : ℕ) : ℝ := SizePairs.overflow (fun i : Fin n => q (SizePairs.part i))
theorem q_nonneg (j : ℕ) : 0 ≤ q j := OneBased.primeQ_nonneg j

theorem gap_eq (n : ℕ) :
    SizeEnsemble.H SizeEnsemble.qPrime n - SizeEnsemble.literalSize n =
      SizeEnsemble.H SizeEnsemble.qPrime n * D n := by
  rw [VectorPartitions.literal_gap_eq_probability, D, SizePairs.overflow, SizeGeom.prob]
  congr 1
  apply sum_congr rfl
  intro v _
  by_cases h : n < SizeGeom.size (@SizePairs.part n) v
  · simp only [if_pos h, show n < SizeGeom.size VectorPartitions.label v from h]
    rfl
  · simp [h, show ¬n < SizeGeom.size VectorPartitions.label v from h]

theorem fixed_cut {n b m t : ℕ} (hcut : n=m+t) (hb : 0<b) (ht : 0<t)
    (hm : 0<m) (hbn : b≤n) :
    (1-SizeLimit.mass q b n)*SizeTriangle.pairSum q b n ≤ D n ∧
    D n ≤ SizeTriangle.pairSum q b m + (b:ℝ)/t + (t:ℝ)/m + 1/(b:ℝ) + (SizeLimit.mass q b n)^3 := by
  let w (i : Fin n) := q (SizePairs.part i)
  have h0 (i : Fin n) : 0 ≤ w i := q_nonneg _
  have h1 (i : Fin n) : w i < 1 := by
    change 1/SizeEnsemble.primeAt (i.val+1) < 1
    have hh := SizeEnsemble.prime_gt_one i.val
    exact (div_lt_one (by linarith)).mpr hh
  have hmass : (∑ i ∈ SizePairs.big n b, w i) = SizeLimit.mass q b n :=
    OneBased.big_mass q n b
  have hmn : m≤n := by omega
  constructor
  · have h := SizePairs.finite_lower w h0 (fun i => (h1 i).le) b
    dsimp only [w] at h
    rw [SizePairs.cross_sum q (s:=n) le_rfl] at h
    exact hmass ▸ h
  · have h := SizePairs.finite_upper w h0 h1 b hcut ht
    have hpair : (∑ T ∈ SizePairs.cross n b m, ∏ i ∈ T, w i) = SizeTriangle.pairSum q b m :=
      SizePairs.cross_sum q hmn
    rw [hpair, hmass] at h
    have hsmall := OneBased.small_mean q OneBased.primeQ_bound hbn
    have hnear := OneBased.high_mass q OneBased.primeQ_bound hm hmn
    rw [show n-m=t by omega] at hnear
    have hsq := OneBased.big_squares q q_nonneg OneBased.primeQ_bound hb hbn
    exact h.trans (add_le_add_right (add_le_add (add_le_add (add_le_add_left
      (div_le_div_of_nonneg_right hsmall (Nat.cast_nonneg t)) _) hnear) hsq) _)

theorem sandwich : ∀ᶠ n : ℕ in atTop,
    (1-SizeLimit.mass q (SizeLimit.b n) n)*SizeTriangle.pairSum q (SizeLimit.b n) n ≤ D n ∧
    D n ≤ SizeTriangle.pairSum q (SizeLimit.b n) (SizeLimit.m n) +
      (SizeLimit.b n:ℝ)/(SizeLimit.t n:ℝ) + (SizeLimit.t n:ℝ)/(SizeLimit.m n:ℝ) +
      1/(SizeLimit.b n:ℝ) + (SizeLimit.mass q (SizeLimit.b n) n)^3 := by
  filter_upwards [SizeLimit.t_lt, SizeLimit.b_top.eventually_gt_atTop 0,
    SizeLimit.m_top.eventually_gt_atTop 0, SizeLimit.b_le,
    (SizeLimit.scale_top 3).eventually_gt_atTop 0] with n ht hb hm hbn hs
  have hcut : n = SizeLimit.m n + SizeLimit.t n := (Nat.sub_add_cancel ht.le).symm
  have hpos : 0 < SizeLimit.t n := Nat.ceil_pos.mpr hs
  exact fixed_cut hcut hb hpos hm hbn

#print axioms sandwich
end
end PrimeSandwich

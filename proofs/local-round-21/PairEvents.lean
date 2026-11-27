import EventBounds
import Triangle

/-! Distinct crossing pairs in the capped geometric multiplicity model. -/
namespace SizePairs
open Finset SizeGeom
noncomputable section

def part {n : ℕ} (i : Fin n) : ℕ := i.val + 1
def big (n b : ℕ) : Finset (Fin n) := univ.filter fun i => b < part i
def cross (n b s : ℕ) : Finset (Finset (Fin n)) :=
  ((big n b).powersetCard 2).filter fun T => s < ∑ i ∈ T, part i ∧ ∀ i ∈ T, part i ≤ s
def smallSize {n K : ℕ} (b : ℕ) (v : Fin n → Fin (K+1)) : ℕ :=
  ∑ i ∈ univ \ big n b, part i * (v i:ℕ)

theorem cross_mem {n b s : ℕ} {T : Finset (Fin n)} : T ∈ cross n b s ↔
    T ⊆ big n b ∧ T.card = 2 ∧ s < ∑ i ∈ T, part i ∧ ∀ i ∈ T, part i ≤ s := by
  simp [cross, and_assoc]

private theorem split_size {n K : ℕ} (b : ℕ) (v : Fin n → Fin (K+1)) :
    size part v = smallSize b v + ∑ i ∈ occupied (big n b) v, part i * (v i:ℕ) := by
  have h := sum_sdiff (f := fun i => part i * (v i:ℕ)) (subset_univ (big n b))
  rw [size,← h,smallSize]
  congr 1
  rw [occupied,sum_filter]
  apply sum_congr rfl
  intro i _
  by_cases hh : 0 < (v i:ℕ)
  · simp [hh]
  · simp [hh, show (v i:ℕ) = 0 by omega]

/-- Outside the small-mass, large-maximum, repeated and triple events,
exceeding the size bound forces a pair crossing the reduced threshold. -/
theorem classify {n b s t K : ℕ} {v : Fin n → Fin (K+1)} (hcut : n=s+t)
    (hv : n < size part v) (hsmall : smallSize b v ≤ t)
    (hcap : ∀ i ∈ occupied (big n b) v, part i ≤ s)
    (hone : ∀ i ∈ big n b, (v i:ℕ) ≤ 1)
    (hcard : (occupied (big n b) v).card ≤ 2) :
    occupied (big n b) v ∈ cross n b s := by
  let T := occupied (big n b) v
  have hactive (i : Fin n) (hi : i ∈ T) := mem_filter.mp hi
  have hsz : s < ∑ i ∈ T, part i := by
    have split := split_size b v
    have he : (∑ i ∈ T, part i * (v i:ℕ)) = ∑ i ∈ T, part i := by
      apply sum_congr rfl
      intro i hi
      have hhi := hactive i hi
      have := hone i hhi.1
      simp [show (v i:ℕ)=1 by omega]
    change size part v = smallSize b v + ∑ i ∈ T, part i * (v i:ℕ) at split
    rw [he] at split
    omega
  have hsz' : (∑ i ∈ T, part i) ≤ T.card*s := by
    simpa using (sum_le_sum (s := T) (g := fun _ => s) hcap)
  apply cross_mem.mpr
  refine ⟨fun i hi => (hactive i hi).1, ?_, hsz, hcap⟩
  change T.card ≤ 2 at hcard
  change T.card = 2
  by_contra hc
  have h1 : T.card ≤ 1 := by omega
  have h2 := Nat.mul_le_mul_right s h1
  simp only [one_mul] at h2
  omega

/-- A specified pair already crossing n forces total size above n even
if additional small parts or extra multiplicities are present. -/
theorem cross_implies_large {n b K : ℕ} {v : Fin n → Fin (K+1)}
    (h : occupied (big n b) v ∈ cross n b n) : n < size part v := by
  have hh := (cross_mem.mp h).2.2.1
  apply lt_of_lt_of_le hh
  rw [split_size b v]
  apply le_trans _ (Nat.le_add_left _ _)
  apply sum_le_sum
  intro i hi
  exact Nat.le_mul_of_pos_right _ (mem_filter.mp hi).2

private def good (b s i j : ℕ) : Prop :=
  b < i ∧ i < j ∧ s < i+j ∧ i ≤ s ∧ j ≤ s
private instance (b s i j : ℕ) : Decidable (good b s i j) := by unfold good; infer_instance
private def indices (n b s : ℕ) : Finset (Fin n × Fin n) :=
  (univ ×ˢ univ).filter fun ij => good b s (part ij.1) (part ij.2)
private def two {n : ℕ} (ij : Fin n × Fin n) : Finset (Fin n) := {ij.1,ij.2}

private theorem cross_image (n b s : ℕ) : cross n b s = (indices n b s).image two := by
  ext T
  constructor
  · intro ht
    obtain ⟨hb,h2,hs,hc⟩ := cross_mem.mp ht
    obtain ⟨i,j,hij, rfl⟩ := card_eq_two.mp h2
    have hi : i ∈ ({i,j} : Finset (Fin n)) := by simp
    have hj : j ∈ ({i,j} : Finset (Fin n)) := by simp
    have bi := (mem_filter.mp (hb hi)).2
    have bj := (mem_filter.mp (hb hj)).2
    rw [sum_pair hij] at hs
    by_cases lt : part i < part j
    · apply mem_image.mpr
      refine ⟨(i,j), ?_, rfl⟩
      simpa [indices] using (show good b s (part i) (part j) from ⟨bi,lt,hs,hc i hi,hc j hj⟩)
    · have lj : part j < part i := by
        unfold part at *
        have hne : i.val ≠ j.val := fun h => hij (Fin.ext h)
        omega
      apply mem_image.mpr
      refine ⟨(j,i),?_,by simp [two,pair_comm]⟩
      simpa [indices] using (show good b s (part j) (part i) from ⟨bj,lj, by omega, hc j hj,hc i hi⟩)
  · intro ht
    obtain ⟨⟨i,j⟩,hij,rfl⟩ := mem_image.mp ht
    have hg : good b s (part i) (part j) := (mem_filter.mp hij).2
    obtain ⟨bi,lt,h,ci,cj⟩ := hg
    have ne : i ≠ j := fun e => by subst j; omega
    apply cross_mem.mpr
    simp only [two,card_pair ne,sum_pair ne,mem_insert,mem_singleton]
    refine ⟨?_,True.intro,h,?_⟩
    · intro k hk
      simp only [mem_insert,mem_singleton] at hk
      rcases hk with rfl | rfl <;> simp [big] <;> omega
    · intro k hk
      rcases hk with rfl | rfl <;> assumption

private theorem two_inj {n b s : ℕ} (u : Fin n × Fin n) (hu : u ∈ indices n b s)
    (v : Fin n × Fin n) (hv : v ∈ indices n b s) (he : two u = two v) : u=v := by
  obtain ⟨i,j⟩ := u
  obtain ⟨k,l⟩ := v
  have ha : part i < part j := ((mem_filter.mp hu).2 : good b s (part i) (part j)).2.1
  have hb : part k < part l := ((mem_filter.mp hv).2 : good b s (part k) (part l)).2.1
  change ({i,j} : Finset (Fin n)) = {k,l} at he
  have hi : i ∈ ({k,l} : Finset (Fin n)) := by rw [← he]; simp
  have hj : j ∈ ({k,l} : Finset (Fin n)) := by rw [← he]; simp
  simp only [mem_insert,mem_singleton] at hi hj
  rcases hi with rfl | rfl <;> rcases hj with rfl | rfl <;> first | rfl | omega

private theorem sum_parts {n : ℕ} (f : ℕ → ℝ) (hz : f 0 = 0) :
    (∑ i : Fin n, f (part i)) = ∑ i ∈ range (n+1), f i := by
  rw [sum_range_succ',hz,add_zero]
  exact Fin.sum_univ_eq_sum_range (fun i => f (i+1)) n

private theorem sum_clip {n s : ℕ} (hs : s ≤ n) (f : ℕ → ℝ) :
    (∑ i ∈ range (n+1), if i ≤ s then f i else 0) = ∑ i ∈ range (s+1), f i := by
  rw [← sum_filter]
  congr 1
  ext i
  simp
  omega

/-- Reindex the crossing two-subsets by their increasing positive part
labels. Each unordered pair contributes once. -/
theorem cross_sum (w : ℕ → ℝ) {n b s : ℕ} (hs : s ≤ n) :
    (∑ T ∈ cross n b s, ∏ i ∈ T, w (part i)) = SizeTriangle.pairSum w b s := by
  let f (i j : ℕ) : ℝ := if b < i ∧ i < j ∧ s < i+j then w i*w j else 0
  let g (i j : ℕ) : ℝ := if i ≤ s then (if j ≤ s then f i j else 0) else 0
  have gc (i j : ℕ) : (if good b s i j then w i*w j else 0) = g i j := by
    dsimp [g,f,good]; split_ifs <;> simp_all
  have zero1 (j : ℕ) : g 0 j = 0 := by simp [g,f]
  have zero2 (i : ℕ) : g i 0 = 0 := by simp [g,f]
  rw [cross_image,sum_image two_inj]
  calc
    _ = ∑ ij ∈ indices n b s, w (part ij.1)*w (part ij.2) := by
      apply sum_congr rfl
      intro ij hij
      apply prod_pair
      intro he
      have h := ((mem_filter.mp hij).2 : good b s (part ij.1) (part ij.2)).2.1
      rw [he] at h
      omega
    _ = ∑ i : Fin n, ∑ j : Fin n, g (part i) (part j) := by
      rw [indices,sum_filter,sum_product]
      exact sum_congr rfl fun i _ => sum_congr rfl fun j _ => gc _ _
    _ = ∑ i ∈ range (n+1), ∑ j ∈ range (n+1), g i j := by
      simp_rw [fun i : Fin n => sum_parts (n:=n) (g (part i)) (zero2 _)]
      exact sum_parts (n:=n) (fun i => ∑ j ∈ range (n+1), g i j) (by simp [zero1])
    _ = _ := by
      simp only [g, sum_ite_irrel, sum_const_zero, fun (i : ℕ) => sum_clip hs (f i)]
      exact sum_clip hs (fun i => ∑ j ∈ range (s+1), f i j)

#print axioms classify
#print axioms cross_sum
end
end SizePairs


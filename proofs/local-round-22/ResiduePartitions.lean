import Counting
import Mathlib.Data.Fintype.Sigma

/-! Actual partitions into two prescribed positive residue classes. A fixed
largest part is distinguished once. The remaining parts are an unordered
multiset of positive integers from the same two classes, bounded by it. -/

namespace CriticalPerimeter
noncomputable section
open Finset PowerSeries
attribute [local instance] Classical.propDecidable

/-- A positive representative in the interval [1,m], with m denoting zero. -/
def allowedPart (m u v p : ℕ) : Prop :=
  0<p ∧ ((p-1)%m+1=u ∨ (p-1)%m+1=v)

private def partAt (m u v i : ℕ) : ℕ :=
  (if i%2=0 then u else v) + m*(i/2)

private theorem part_even (m u v j : ℕ) :
    partAt m u v (2*j) = u + m*j := by simp [partAt]

private theorem part_odd (m u v j : ℕ) :
    partAt m u v (2*j+1) = v + m*j := by
  have h₁ : (2*j+1)%2=1 := by omega
  have h₂ : (2*j+1)/2=j := by omega
  simp [partAt, h₁, h₂]

private theorem index_cases (i : ℕ) : i=2*(i/2) ∨ i=2*(i/2)+1 := by omega

private theorem part_mono {m u v : ℕ} (hu : 0<u) (huv : u<v) (hv : v≤m) :
    StrictMono (partAt m u v) := by
  apply strictMono_nat_of_lt_succ
  intro i
  rcases index_cases i with hi|hi
  · rw [show partAt m u v i= _ from congrArg (partAt m u v) hi, part_even,
      show partAt m u v (i+1)=_ from congrArg (partAt m u v) (congrArg (·+1) hi), part_odd]
    omega
  · have hj : i+1=2*(i/2+1) := by omega
    rw [show partAt m u v i=_ from congrArg (partAt m u v) hi, part_odd,
      show partAt m u v (i+1)=_ from congrArg (partAt m u v) hj, part_even, Nat.mul_add]
    omega

private theorem shift_residue {m b : ℕ} (hb : 0<b) (hbm : b≤m) (j : ℕ) :
    (b+m*j-1)%m+1=b := by
  have he : b+m*j-1=(b-1)+m*j := by omega
  rw [he, Nat.add_mul_mod_self_left, Nat.mod_eq_of_lt (by omega)]
  omega

private theorem allowed_iff_index {m u v p : ℕ} (hu : 0<u) (huv : u<v) (hv : v≤m) :
    allowedPart m u v p ↔ ∃ i, partAt m u v i=p := by
  constructor
  · rintro ⟨hp, hr⟩
    have h := Nat.mod_add_div (p-1) m
    rcases hr with he|he
    · exact ⟨2*((p-1)/m), by rw [part_even, ← he]; omega⟩
    · exact ⟨2*((p-1)/m)+1, by rw [part_odd, ← he]; omega⟩
  · rintro ⟨i, rfl⟩
    rcases index_cases i with hi|hi
    · rw [show partAt m u v i=_ from congrArg (partAt m u v) hi, part_even]
      exact ⟨by omega, Or.inl (shift_residue hu (by omega) _)⟩
    · rw [show partAt m u v i=_ from congrArg (partAt m u v) hi, part_odd]
      exact ⟨by omega, Or.inr (shift_residue (by omega) hv _)⟩

/-- The alphabet of numerical part sizes through w. -/
def AllowedThrough (m u v w : ℕ) := {p : Fin (w+1) // allowedPart m u v p.val}

private def alphabetEquiv {m u v : ℕ} (hu : 0<u) (huv : u<v) (hv : v≤m) (i : ℕ) :
    Fin (i+1) ≃ AllowedThrough m u v (partAt m u v i) := by
  let f := partAt m u v
  have hm : StrictMono f := part_mono hu huv hv
  let g : Fin (i+1) → AllowedThrough m u v (f i) := fun t =>
    ⟨⟨f t, Nat.lt_succ_of_le (hm.monotone (Nat.le_of_lt_succ t.isLt))⟩,
      (allowed_iff_index hu huv hv).mpr ⟨t, rfl⟩⟩
  apply Equiv.ofBijective g
  constructor
  · intro a b e
    apply Fin.ext
    exact hm.injective (congrArg (fun z : AllowedThrough m u v (f i) => z.val.val) e)
  · intro p
    obtain ⟨j,hj⟩ := (allowed_iff_index hu huv hv).mp p.property
    have hji : j ≤ i := hm.le_iff_le.mp (hj.trans_le (Nat.le_of_lt_succ p.val.isLt))
    refine ⟨⟨j, Nat.lt_succ_of_le hji⟩, Subtype.ext (Fin.ext ?_)⟩
    exact hj

/-- All partitions of perimeter n with a specified largest part w. The
obligatory largest part has been removed from the multiset of actual parts. -/
def TailAt (m u v w n : ℕ) := if w≤n then Sym (AllowedThrough m u v w) (n-w) else Empty

/-- All partitions of perimeter n with parts in the prescribed residue
classes. The index is the quotient block of the largest part. -/
def ResiduePartitions (s u v n : ℕ) := (j : Fin (n+1)) ×
  (TailAt (2*s) u v (u+2*s*j.val) n ⊕ TailAt (2*s) u v (v+2*s*j.val) n)

private instance (m u v w : ℕ) : Finite (AllowedThrough m u v w) := by
  unfold AllowedThrough; infer_instance

private instance (m u v w n : ℕ) : Finite (TailAt m u v w n) := by
  letI := Fintype.ofFinite (AllowedThrough m u v w)
  classical
  unfold TailAt; split <;> infer_instance

private theorem tail_card {m u v : ℕ} (hu : 0<u) (huv : u<v) (hv : v≤m) (i n : ℕ) :
    Nat.card (TailAt m u v (partAt m u v i) n) =
      multisetCount (i+1) (partAt m u v i) n := by
  unfold TailAt multisetCount
  split
  · rw [← Nat.card_eq_fintype_card]
    exact Nat.card_congr (Sym.equivCongr (alphabetEquiv hu huv hv i).symm)
  · simp

theorem card_residue_partitions {s u v : ℕ} (hu : 0<u) (huv : u<v) (hv : v≤2*s) (n : ℕ) :
    Nat.card (ResiduePartitions s u v n) = residueCount s u v n := by
  unfold ResiduePartitions residueCount
  rw [Nat.card_sigma, ← Fin.sum_univ_eq_sum_range]
  refine sum_congr rfl fun j _ => ?_
  have h₁ := tail_card hu huv hv (2*j.val) n
  have h₂ := tail_card hu huv hv (2*j.val+1) n
  rw [part_even] at h₁
  rw [part_odd] at h₂
  rw [Nat.card_sum, h₁, h₂]

theorem coefficient_actual_residue_partitions {s u v : ℕ}
    (hu : 0<u) (huv : u<v) (hv : v≤2*s) (n : ℕ) :
    coeff ℝ n (residueSeries s u v) = (Nat.card (ResiduePartitions s u v n) : ℝ) := by
  rw [card_residue_partitions hu huv hv, coefficient_residue_count _ _ _ _ (by omega)]

/-- A definition independent of the ordering of the two residue classes:
choose the actual numerical largest part, and an unordered tail of parts
no larger than it. Its largest part is recorded exactly once. -/
def PartitionsByLargest (m u v n : ℕ) :=
  (w : {p : ℕ // allowedPart m u v p}) × TailAt m u v w.val n

private theorem tail_feasible {m u v w n : ℕ} (tail : TailAt m u v w n) : w≤n := by
  by_contra h
  unfold TailAt at tail
  rw [if_neg h] at tail
  exact tail.elim

private def recordLargest {s u v n : ℕ} (hu : 0<u) (huv : u<v) (hv : v≤2*s) :
    ResiduePartitions s u v n → PartitionsByLargest (2*s) u v n
  | ⟨j, Sum.inl t⟩ => ⟨⟨u+2*s*j.val, (allowed_iff_index hu huv hv).mpr
      ⟨2*j.val, part_even _ _ _ _⟩⟩, t⟩
  | ⟨j, Sum.inr t⟩ => ⟨⟨v+2*s*j.val, (allowed_iff_index hu huv hv).mpr
      ⟨2*j.val+1, part_odd _ _ _ _⟩⟩, t⟩

private theorem same_block {s u v : ℕ} (hu : 0<u) (huv : u<v) (hv : v≤2*s)
    {j k : ℕ} : (u+2*s*j=u+2*s*k → j=k) ∧ (v+2*s*j=v+2*s*k → j=k) ∧
    u+2*s*j ≠ v+2*s*k := by
  have hm := (part_mono hu huv hv).injective
  constructor
  · intro e
    rw [← part_even (2*s) u v j, ← part_even (2*s) u v k] at e
    have := hm e
    omega
  constructor
  · intro e
    rw [← part_odd (2*s) u v j, ← part_odd (2*s) u v k] at e
    have := hm e
    omega
  · intro e
    rw [← part_even (2*s) u v j, ← part_odd (2*s) u v k] at e
    have := hm e
    omega

private def byLargestEquiv {s u v n : ℕ} (hu : 0<u) (huv : u<v) (hv : v≤2*s) :
    ResiduePartitions s u v n ≃ PartitionsByLargest (2*s) u v n := by
  apply Equiv.ofBijective (recordLargest hu huv hv)
  constructor
  · rintro ⟨j,b⟩ ⟨k,c⟩ e
    have hw := congrArg (fun z : PartitionsByLargest (2*s) u v n => z.1.val) e
    cases b with
    | inl t =>
      cases c with
      | inl q =>
        obtain rfl : j=k := Fin.ext ((same_block hu huv hv).1 hw)
        obtain rfl : t=q := eq_of_heq (Sigma.mk.inj_iff.mp e).2
        rfl
      | inr q => exact False.elim ((same_block hu huv hv).2.2 hw)
    | inr t =>
      cases c with
      | inl q => exact False.elim ((same_block hu huv hv).2.2 hw.symm)
      | inr q =>
        obtain rfl : j=k := Fin.ext ((same_block hu huv hv).2.1 hw)
        obtain rfl : t=q := eq_of_heq (Sigma.mk.inj_iff.mp e).2
        rfl
  · rintro ⟨⟨w,hw⟩,t⟩
    have hwn : w≤n := tail_feasible t
    obtain ⟨i,hi⟩ := (allowed_iff_index hu huv hv).mp hw
    have hil : i≤w := hi ▸ (part_mono hu huv hv).id_le i
    let j : Fin (n+1) := ⟨i/2, by omega⟩
    rcases index_cases i with h|h
    · have hpart : u+2*s*j.val=w := (part_even (2*s) u v j).symm.trans
        ((congrArg (partAt (2*s) u v) h.symm).trans hi)
      let hT := congrArg (fun z => TailAt (2*s) u v z n) hpart.symm
      exact ⟨⟨j, Sum.inl (cast hT t)⟩, Sigma.ext (Subtype.ext hpart) (cast_heq hT t)⟩
    · have hpart : v+2*s*j.val=w := (part_odd (2*s) u v j).symm.trans
        ((congrArg (partAt (2*s) u v) h.symm).trans hi)
      let hT := congrArg (fun z => TailAt (2*s) u v z n) hpart.symm
      exact ⟨⟨j, Sum.inr (cast hT t)⟩, Sigma.ext (Subtype.ext hpart) (cast_heq hT t)⟩

theorem coefficient_partitions_by_largest {s u v : ℕ}
    (hu : 0<u) (huv : u<v) (hv : v≤2*s) (n : ℕ) :
    coeff ℝ n (residueSeries s u v) = (Nat.card (PartitionsByLargest (2*s) u v n) : ℝ) := by
  rw [coefficient_actual_residue_partitions hu huv hv,
    Nat.card_congr (byLargestEquiv hu huv hv)]

#print axioms coefficient_actual_residue_partitions
#print axioms coefficient_partitions_by_largest
end
end CriticalPerimeter

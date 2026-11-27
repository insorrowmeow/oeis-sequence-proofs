import GeometricModel
import SizeLimit
import Mathlib.Data.List.Sort
import Mathlib.Algebra.BigOperators.Fin

open Finset
namespace VectorPartitions
noncomputable section

/-- Expand a vector in descending order of its positive part labels. -/
def decode : (m : ℕ) → (Fin m → ℕ) → List ℕ
  | 0,_ => []
  | m+1,v => List.replicate (v (Fin.last m)) (m+1) ++ decode m (fun j => v j.castSucc)

theorem bounds (m : ℕ) (v : Fin m → ℕ) (a : ℕ) (h : a ∈ decode m v) : 0<a ∧ a≤m := by
  induction m generalizing a with
  | zero => simp [decode] at h
  | succ m ih =>
    rw [decode,List.mem_append] at h
    rcases h with h|h
    · have eq : a=m+1 := (List.mem_replicate.mp h).2
      omega
    · have := ih _ _ h
      omega

theorem ordered (m : ℕ) (v : Fin m → ℕ) : (decode m v).Pairwise (· ≥ ·) := by
  induction m with
  | zero => simp [decode]
  | succ m ih =>
    rw [decode,List.pairwise_append]
    refine ⟨?_,ih _,?_⟩
    · apply List.pairwise_replicate.mpr
      simp
    · intro a ha b hb
      have eq := (List.mem_replicate.mp ha).2
      have := (bounds _ _ b hb).2
      omega

theorem decode_sum (m : ℕ) (v : Fin m → ℕ) :
    (decode m v).sum = ∑ j : Fin m, ((j:ℕ)+1)*v j := by
  induction m with
  | zero => simp [decode]
  | succ m ih =>
    rw [decode,List.sum_append,List.sum_replicate_nat,ih,Fin.sum_univ_castSucc]
    simp [Nat.mul_comm,add_comm]

theorem decode_weight (q : ℕ → ℝ) (m : ℕ) (v : Fin m → ℕ) :
    SizeEnsemble.weight q (decode m v) = ∏ j : Fin m, q j ^ v j := by
  induction m with
  | zero => simp [decode,SizeEnsemble.weight]
  | succ m ih =>
    rw [Fin.prod_univ_castSucc,decode]
    simp only [SizeEnsemble.weight,List.map_append,List.prod_append,List.map_replicate,
      Nat.add_sub_cancel,List.prod_replicate]
    rw [← SizeEnsemble.weight,ih,mul_comm]
    rfl

theorem decode_count (m : ℕ) (v : Fin m → ℕ) (i : Fin m) :
    (decode m v).count ((i:ℕ)+1) = v i := by
  induction m with
  | zero => exact Fin.elim0 i
  | succ m ih =>
    refine Fin.lastCases ?_ (fun j => ?_) i
    · rw [decode,List.count_append]
      simp only [Fin.val_last,List.count_replicate_self]
      have h : m+1 ∉ decode m (fun j => v j.castSucc) := fun h => by
        have := (bounds _ _ _ h).2
        omega
      simp [List.count_eq_zero_of_not_mem h]
    · rw [decode,List.count_append,List.count_replicate]
      have h : (m+1 == (j:ℕ)+1) = false := by simp; omega
      simp only [Fin.coe_castSucc,h, Bool.false_eq_true, ↓reduceIte, zero_add]
      exact ih (fun j => v j.castSucc) j



theorem decode_injective {m : ℕ} : Function.Injective (decode m) := by
  intro u v he
  funext i
  rw [← decode_count _ u i,he,decode_count]

theorem length_le_sum (xs : List ℕ) (hpos : ∀ a ∈ xs, 0<a) : xs.length ≤ xs.sum := by
  induction xs with
  | nil => simp
  | cons a xs ih =>
    have h := ih (fun b hb => hpos b (List.mem_cons_of_mem _ hb))
    have ha := hpos a List.mem_cons_self
    simp only [List.length_cons,List.sum_cons]
    omega

theorem decode_counts (xs : List ℕ) {m : ℕ} (hs : xs.Pairwise (· ≥ ·))
    (hb : ∀ a ∈ xs, 0<a ∧ a≤m) :
    decode m (fun i => xs.count ((i:ℕ)+1)) = xs := by
  apply List.eq_of_perm_of_sorted _ (ordered ..) hs
  apply List.perm_iff_count.mpr
  intro a
  by_cases ha : 0<a ∧ a≤m
  · let i : Fin m := ⟨a-1,by omega⟩
    have e : (i:ℕ)+1=a := by dsimp [i]; omega
    simpa only [e] using decode_count m (fun i => xs.count ((i:ℕ)+1)) i
  · have h₁ : a ∉ decode m (fun i => xs.count ((i:ℕ)+1)) := fun h => ha (bounds _ _ _ h)
    have h₂ : a ∉ xs := fun h => ha (hb a h)
    simp [List.count_eq_zero_of_not_mem h₁,List.count_eq_zero_of_not_mem h₂]

def label {n : ℕ} (i : Fin n) : ℕ := (i:ℕ)+1

def encode {n : ℕ} (x : List ℕ) (hx : x ∈ SizeEnsemble.parts n n) (i : Fin n) : Fin ((n+1)+1) :=
  ⟨x.count (label i), by
    have h := (SizeEnsemble.mem_parts x n n).mp hx
    have hh := length_le_sum x (fun a ha => (h.2.2 a ha).1)
    have hc := List.count_le_length (a:=label i) (l:=x)
    omega⟩

/-- The cumulative bound makes every multiplicity at most n, so the last
capped bucket n+1 never occurs in these vectors. -/
theorem bounded_sum_eq (q : ℕ → ℝ) (n : ℕ) :
    (∑ v : Fin n → Fin ((n+1)+1), if SizeGeom.size label v ≤ n then ∏ i : Fin n, q i ^ (v i : ℕ) else 0)
      = SizeEnsemble.C q n n := by
  classical
  rw [← sum_filter]
  unfold SizeEnsemble.C
  refine sum_bij' (fun v _ => decode n (fun j => (v j : ℕ))) encode ?_ ?_ ?_ ?_ ?_
  · intro v hv
    apply (SizeEnsemble.mem_parts _ _ _).mpr
    exact ⟨(decode_sum ..).trans_le (mem_filter.mp hv).2,ordered ..,fun a ha => bounds _ _ a ha⟩
  · intro x hx
    have h := (SizeEnsemble.mem_parts x n n).mp hx
    apply mem_filter.mpr
    refine ⟨mem_univ _,?_⟩
    change (∑ i : Fin n, ((i:ℕ)+1)*x.count ((i:ℕ)+1)) ≤ n
    rw [← decode_sum n (fun i => x.count ((i:ℕ)+1)),decode_counts x h.2.1 h.2.2]
    exact h.1
  · intro v hv
    funext i
    apply Fin.ext
    exact decode_count n (fun j => (v j : ℕ)) i 
  · intro x hx
    have h := (SizeEnsemble.mem_parts x n n).mp hx
    exact decode_counts x h.2.1 h.2.2
  · intro v _
    exact (decode_weight q n (fun i => (v i : ℕ))).symm

/-- Unnormalized missing mass equals the Euler product times the probability
of the overflow event in the finite product of capped geometric laws. -/
theorem gap_eq_probability (q : ℕ → ℝ) (hq : ∀ j, q j < 1) (n : ℕ) :
    SizeEnsemble.gap q n n = SizeEnsemble.H q n *
    ∑ v : Fin n → Fin ((n+1)+1), if n < SizeGeom.size label v
      then SizeGeom.mass (fun i : Fin n => q i) (n+1) v else 0 := by
  have h := SizeGeom.gap_probability (fun i : Fin n => q i) (fun i => hq _) label
    (fun i => Nat.zero_lt_succ _) n
  rw [bounded_sum_eq] at h
  have norm : SizeGeom.normalizer (fun i : Fin n => q i) = SizeEnsemble.H q n :=
    Fin.prod_univ_eq_prod_range (fun i => (1-q i)⁻¹) n
  rwa [norm] at h

theorem literal_gap_eq_probability (n : ℕ) :
    SizeEnsemble.H SizeEnsemble.qPrime n - SizeEnsemble.literalSize n =
    SizeEnsemble.H SizeEnsemble.qPrime n *
    ∑ v : Fin n → Fin ((n+1)+1), if n < SizeGeom.size label v
      then SizeGeom.mass (fun i : Fin n => SizeEnsemble.qPrime i) (n+1) v else 0 := by
  rw [← SizeEnsemble.C_eq_literal]
  apply gap_eq_probability
  intro i
  apply (div_lt_one (lt_trans zero_lt_one (SizeEnsemble.prime_gt_one i))).2
  exact SizeEnsemble.prime_gt_one i

#print axioms literal_gap_eq_probability
end
end VectorPartitions

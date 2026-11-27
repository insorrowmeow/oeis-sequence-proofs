import Counting
import Slack
import Mathlib.Algebra.BigOperators.Fin

namespace CriticalGap
open Finset
noncomputable section

/-- A partition written in ascending order, with exactly j+1 parts, adjacent
    gap at least d, least part at least a, and perimeter n. -/
def Row (d a n j : ℕ) := {p : Fin (j+1) → ℕ //
  a ≤ p 0 ∧ (∀ i : Fin j, p i.castSucc + d ≤ p i.succ) ∧ p (Fin.last j)+j=n}

private def assemble (d a : ℕ) {j : ℕ} (w : Fin (j+1) → ℕ) : Fin (j+1) → ℕ :=
  Fin.induction (a+w 0) (fun i prev => prev+d+w i.succ)

private def gaps (d a : ℕ) {j : ℕ} (p : Fin (j+1) → ℕ) : Fin (j+1) → ℕ :=
  Fin.cons (p 0-a) (fun i => p i.succ - (p i.castSucc + d))

private lemma make_zero {d a j : ℕ} (w : Fin (j+1) → ℕ) :
    assemble d a w 0 = a+w 0 := rfl
private lemma make_next {d a j : ℕ} (w : Fin (j+1) → ℕ) (i : Fin j) :
    assemble d a w i.succ = assemble d a w i.castSucc + d + w i.succ := by
  simp [assemble]
private lemma gap_zero {d a j : ℕ} (p : Fin (j+1) → ℕ) : gaps d a p 0 = p 0-a := rfl
private lemma gap_next {d a j : ℕ} (p : Fin (j+1) → ℕ) (i : Fin j) :
    gaps d a p i.succ = p i.succ - (p i.castSucc + d) := by simp [gaps]

private lemma extract_make {d a j : ℕ} (w : Fin (j+1) → ℕ) :
    gaps d a (assemble d a w) = w := by
  funext i
  refine Fin.cases ?_ (fun k => ?_) i
  · simp [gap_zero, make_zero]
  · rw [gap_next, make_next, Nat.add_sub_cancel_left]

private lemma make_extract {d a j : ℕ} (p : Fin (j+1) → ℕ)
    (h0 : a ≤ p 0) (hg : ∀ i : Fin j, p i.castSucc+d ≤ p i.succ) :
    assemble d a (gaps d a p) = p := by
  funext i
  refine Fin.induction ?_ (fun k ih => ?_) i
  · simp [make_zero, gap_zero, h0]
  · rw [make_next, ih, gap_next, Nat.add_sub_of_le (hg k)]

private lemma last_part {d a j : ℕ} (w : Fin (j+1) → ℕ) :
    assemble d a w (Fin.last j) = a + j*d + ∑ i, w i := by
  let p := assemble d a w
  have hs : (∑ i : Fin j, p i.succ) = ∑ i : Fin j, (p i.castSucc+d+w i.succ) :=
    sum_congr rfl (fun i _ => make_next w i)
  have ht : p 0 + (∑ i : Fin j, p i.succ) = (∑ i : Fin j, p i.castSucc) + p (Fin.last j) := by
    rw [← Fin.sum_univ_succ p, ← Fin.sum_univ_castSucc p]
  simp only [sum_add_distrib, sum_const, card_univ, Fintype.card_fin, smul_eq_mul] at hs
  rw [Fin.sum_univ_succ w]
  change p (Fin.last j) = _
  have hz : p 0 = a+w 0 := make_zero w
  omega

private lemma size_identity (d a n j : ℕ) (p : Row d a n j) :
    a+(d+1)*j+(∑ i, gaps d a p.val i)=n := by
  have h := last_part (d:=d) (a:=a) (gaps d a p.val)
  rw [make_extract p.val p.property.1 p.property.2.1] at h
  have hn := p.property.2.2
  rw [Nat.add_mul, one_mul, Nat.mul_comm d j]
  omega

/-- Bijection with the slack distribution, at fixed perimeter and length. -/
def gapEquiv (d a n j : ℕ) (hb : a+(d+1)*j ≤ n) :
    Row d a n j ≃ {w : Fin (j+1) → ℕ // (∑ i, w i)=n-(a+(d+1)*j)} where
  toFun p := ⟨gaps d a p.val, by have := size_identity d a n j p; omega⟩
  invFun w := ⟨assemble d a w.val, by
    refine ⟨by simp [make_zero], fun i => by rw [make_next]; omega, ?_⟩
    rw [last_part, w.property]
    rw [Nat.add_mul, one_mul, Nat.mul_comm d j] at hb ⊢
    omega⟩
  left_inv p := Subtype.ext (make_extract _ p.property.1 p.property.2.1)
  right_inv w := Subtype.ext (extract_make _)

/-- A literal partition with its number of parts recorded. Every possible j
    occurs in this index set since its largest part plus j equals n. -/
def Partitions (d a n : ℕ) := (j : Fin (n+1)) × Row d a n j.val

theorem length_bound {d a n j : ℕ} (p : Row d a n j) : j ≤ n := by
  have := p.property.2.2
  omega

private theorem empty_row {d a n j : ℕ} (h : ¬ a+(d+1)*j ≤ n) :
    IsEmpty (Row d a n j) := ⟨fun p => by have := size_identity d a n j p; omega⟩

instance (d a n j : ℕ) : Finite (Row d a n j) := by
  classical
  by_cases hb : a+(d+1)*j ≤ n
  · exact Finite.of_equiv _ ((gapEquiv d a n j hb).trans (slackMultisetEquiv _ _)).symm
  · haveI := empty_row hb
    infer_instance

def partitionCount (d a n : ℕ) : ℕ := Nat.card (Partitions d a n)

private theorem row_card (d a n j : ℕ) : Nat.card (Row d a n j) =
    CriticalPerimeter.multisetCount (j+1) (a+(d+1)*j) n := by
  unfold CriticalPerimeter.multisetCount
  split_ifs with hb
  · exact (Nat.card_congr ((gapEquiv d a n j hb).trans (slackMultisetEquiv _ _))).trans
      Nat.card_eq_fintype_card
  · haveI := empty_row hb
    simp

theorem gap_card (s a n : ℕ) (hs : 1<s) :
    partitionCount (s-1) a n = CriticalPerimeter.gapCount s a n := by
  change Nat.card ((j : Fin (n+1)) × Row (s-1) a n j.val) = _
  rw [Nat.card_sigma]
  simp only [row_card, Nat.sub_add_cancel (by omega : 1≤s)]
  exact Fin.sum_univ_eq_sum_range (fun j => CriticalPerimeter.multisetCount (j+1) (a+s*j) n) (n+1)

#print axioms gap_card
end
end CriticalGap

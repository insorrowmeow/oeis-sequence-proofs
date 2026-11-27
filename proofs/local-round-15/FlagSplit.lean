import Mathlib.Algebra.BigOperators.Group.Finset.Basic
import Mathlib.Data.Finset.Card

/-! Splitting a strict partition at the length of the shortest row.
The parts form a finite set of positive integers. The zero-based flag at i
bounds the (i+1)-st largest part exactly when at most i parts exceed it. -/

namespace ShiftedFerrers

open Finset
open scoped BigOperators

def Fits (b : ℕ) (flag : ℕ → ℕ) (s : Finset ℕ) : Prop :=
  (∀ x ∈ s, 0 < x) ∧ s.card ≤ b ∧
    ∀ i < b, (s.filter (fun x => flag i < x)).card ≤ i

private theorem split_disjoint {m : ℕ} {s t : Finset ℕ}
    (hs : ∀ x ∈ s, m < x) (ht : ∀ x ∈ t, x ≤ m) : Disjoint s t := by
  rw [Finset.disjoint_left]
  intro x hx hy
  exact (not_lt_of_ge (ht x hy)) (hs x hx)

/-- All row constraints on the union are carried by its high parts.
The low parts use exactly the remaining row capacity. -/
theorem fits_union_iff {b m : ℕ} {flag : ℕ → ℕ} {s t : Finset ℕ}
    (hm : ∀ i < b, m ≤ flag i) (hs : ∀ x ∈ s, m < x)
    (ht : ∀ x ∈ t, x ≤ m) :
    Fits b flag (s ∪ t) ↔
      Fits b flag s ∧ (∀ x ∈ t, 0 < x) ∧ t.card ≤ b - s.card := by
  have hc := Finset.card_union_of_disjoint (split_disjoint hs ht)
  have hf (i : ℕ) (hi : i < b) :
      (s ∪ t).filter (fun x => flag i < x) = s.filter (fun x => flag i < x) := by
    ext x
    simp only [mem_filter, mem_union]
    constructor
    · rintro ⟨hx | hx, hgt⟩
      · exact ⟨hx, hgt⟩
      · exact False.elim ((not_lt_of_ge ((ht x hx).trans (hm i hi))) hgt)
    · rintro ⟨hx, hgt⟩
      exact ⟨Or.inl hx, hgt⟩
  constructor
  · rintro ⟨hpos, hcard, hflag⟩
    exact ⟨⟨fun x hx => hpos x (mem_union_left _ hx), by omega,
      fun i hi => (hf i hi) ▸ hflag i hi⟩,
      fun x hx => hpos x (mem_union_right _ hx), by omega⟩
  · rintro ⟨⟨hps, hcs, hfs⟩, hpt, hct⟩
    refine ⟨?_, by omega, ?_⟩
    · intro x hx
      exact (mem_union.mp hx).elim (hps x) (hpt x)
    · intro i hi
      rw [hf i hi]
      exact hfs i hi

def weight (s : Finset ℕ) : ℕ := ∑ x ∈ s, x

/-- Weight-preserving bijection at an individual coefficient. Its inverse
is literal union, so each admissible partition is counted exactly once. -/
def splitAtRank (b m n : ℕ) (flag : ℕ → ℕ) (hm : ∀ i < b, m ≤ flag i) :
    {s : Finset ℕ // Fits b flag s ∧ weight s = n} ≃
    {p : Finset ℕ × Finset ℕ //
      (∀ x ∈ p.1, m < x) ∧ (∀ x ∈ p.2, x ≤ m) ∧
      Fits b flag p.1 ∧ (∀ x ∈ p.2, 0 < x) ∧
      p.2.card ≤ b - p.1.card ∧ weight p.1 + weight p.2 = n} where
  toFun a := by
    let s := a.val.filter (fun x => m < x)
    let t := a.val.filter (fun x => x ≤ m)
    have hs : ∀ x ∈ s, m < x := fun _ hx => (mem_filter.mp hx).2
    have ht : ∀ x ∈ t, x ≤ m := fun _ hx => (mem_filter.mp hx).2
    have hu : s ∪ t = a.val := by
      ext x
      simp only [s, t, mem_union, mem_filter]
      by_cases h : m < x <;> simp [h, Nat.le_of_not_gt, Nat.not_le_of_gt]
    have admiss := (fits_union_iff hm hs ht).mp (hu ▸ a.property.1)
    refine ⟨(s,t), hs, ht, admiss.1, admiss.2.1, admiss.2.2, ?_⟩
    have hw := a.property.2
    rw [← hu, weight, sum_union (split_disjoint hs ht)] at hw
    exact hw
  invFun p := by
    obtain ⟨⟨s,t⟩, hs, ht, hfit, hpos, hc, hw⟩ := p
    refine ⟨s ∪ t, (fits_union_iff hm hs ht).mpr ⟨hfit,hpos,hc⟩, ?_⟩
    simpa only [weight, sum_union (split_disjoint hs ht)] using hw
  left_inv a := by
    apply Subtype.ext
    ext x
    change (x ∈ a.val.filter (fun y => m < y) ∪ a.val.filter (fun y => y ≤ m)) ↔ _
    simp only [mem_union, mem_filter]
    by_cases h : m < x <;> simp [h, Nat.le_of_not_gt, Nat.not_le_of_gt]
  right_inv p := by
    obtain ⟨⟨s,t⟩, hs, ht, hfit, hpos, hc, hw⟩ := p
    apply Subtype.ext
    change ((s ∪ t).filter (fun y => m < y), (s ∪ t).filter (fun y => y ≤ m)) = _
    apply Prod.ext
    · ext x
      simp only [mem_filter, mem_union]
      constructor
      · rintro ⟨hx | hx, h⟩
        · exact hx
        · exact False.elim ((not_lt_of_ge (ht x hx)) h)
      · exact fun hx => ⟨Or.inl hx, hs x hx⟩
    · ext x
      simp only [mem_filter, mem_union]
      constructor
      · rintro ⟨hx | hx, h⟩
        · exact False.elim ((not_lt_of_ge h) (hs x hx))
        · exact hx
      · exact fun hx => ⟨Or.inr hx, ht x hx⟩

end ShiftedFerrers

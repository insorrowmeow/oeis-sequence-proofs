import Mathlib.Algebra.BigOperators.Ring.Finset
import Mathlib.Data.Finset.Card
import Mathlib.Tactic.Linarith

namespace DyckValleys
open Finset

variable {N : ℕ}

def admissible (a d : Finset (Fin N)) :=
  a.card = d.card ∧ ∀ s : Finset (Fin N),
    (∀ x ∈ s, ∀ y : Fin N, y ≤ x → y ∈ s) →
    (a ∩ s).card ≤ (d ∩ s).card

private theorem split (a s : Finset (Fin N)) :
    (aᶜ ∩ s).card + (a ∩ s).card = s.card := by
  rw [← card_union_of_disjoint]
  · congr 1; ext i; simp; tauto
  · rw [disjoint_left]; simp; tauto

theorem transpose {a d : Finset (Fin N)} (h : admissible a d) :
    admissible dᶜ aᶜ := by
  refine ⟨by simp [card_compl, h.1], ?_⟩
  intro s hs
  have := h.2 s hs
  have ha := split a s
  have hd := split d s
  omega

private theorem total (s : Finset (Fin N)) :
    (∑ i ∈ sᶜ, (i : ℤ)) + (∑ i ∈ s, (i : ℤ)) = ∑ i : Fin N, (i : ℤ) := by
  rw [← sum_union (disjoint_compl_left : Disjoint sᶜ s)]
  congr 1; ext i; simp; tauto

theorem weight {a d : Finset (Fin N)} (h : a.card = d.card) :
    (∑ i ∈ dᶜ, (i : ℤ)) - (∑ i ∈ aᶜ, (i : ℤ)) + (dᶜ.card : ℤ) =
    (∑ i ∈ a, (i : ℤ)) - (∑ i ∈ d, (i : ℤ)) + ((N-a.card : ℕ) : ℤ) := by
  have ha := total a
  have hd := total d
  simp only [card_compl, Fintype.card_fin, ← h]
  linarith

end DyckValleys

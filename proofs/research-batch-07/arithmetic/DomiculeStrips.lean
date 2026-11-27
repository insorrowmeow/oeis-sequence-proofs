import Mathlib.Algebra.BigOperators.Group.Finset.Basic
import Mathlib.Algebra.Order.BigOperators.Group.Finset
import Mathlib.Data.Nat.Choose.Basic
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.Ring

namespace DomiculeStrips

open Finset

/-- An injectively paired finite board cannot decrease any strip index if it never
    increases one. Apply this to odd column endpoints matched to even endpoints. -/
theorem strip_invariance {α : Type*} [Fintype α] (σ : Equiv.Perm α) (strip : α → ℕ)
    (moves : ∀ i, strip (σ i) ≤ strip i) : ∀ i, strip (σ i) = strip i := by
  intro i
  by_contra hi
  have strict : (∑ j, strip (σ j)) < ∑ j, strip j :=
    sum_lt_sum (fun j _ => moves j) ⟨i, mem_univ i, lt_of_le_of_ne (moves i) hi⟩
  rw [Equiv.sum_comp σ strip] at strict
  exact lt_irrefl _ strict

/-- In a bandwidth-one permutation of rows, every move to the next row forces
    that next row to move back. The proof counts crossings of their common cut. -/
theorem adjacent_swap {h : ℕ} (σ : Equiv.Perm (Fin h))
    (near : ∀ j, (σ j).val ≤ j.val+1 ∧ j.val ≤ (σ j).val+1)
    (i j : Fin h) (next : j.val=i.val+1) :
    σ i=j ↔ σ j=i := by
  let left (k : Fin h) : ℤ := if k.val≤i.val then 1 else 0
  let change := fun k => left (σ k)-left k
  have total : ∑ k, change k = 0 := by
    simp only [change, sum_sub_distrib, Equiv.sum_comp, sub_self]
  have rest (k : Fin h) (hk : k≠i) (hk' : k≠j) : change k = 0 := by
    have H := near k
    have A : k.val≠i.val := fun he => hk (Fin.ext he)
    have B : k.val≠j.val := fun he => hk' (Fin.ext he)
    dsimp [change,left]
    by_cases le : k.val ≤ i.val
    · simp [le, show (σ k).val ≤ i.val by omega]
    · simp [le, show ¬(σ k).val ≤ i.val by omega]
  have ij : i≠j := by intro he; have := congrArg Fin.val he; omega
  have part : ∑ k, change k = change i + change j := by
    rw [← sum_filter_add_sum_filter_not (s := univ) (p := fun k => k=i ∨ k=j)]
    rw [show (univ.filter fun k => k=i ∨ k=j) = {i,j} by ext; simp]
    rw [sum_pair ij]
    have rem : ∑ k ∈ univ.filter (fun k => ¬(k=i ∨ k=j)), change k = 0 := by
      apply sum_eq_zero
      intro k hk
      exact rest k (fun x => (mem_filter.mp hk).2 (.inl x)) (fun x => (mem_filter.mp hk).2 (.inr x))
    rw [rem, add_zero]
  rw [part] at total
  have Hi := near i
  have Hj := near j
  have Ji : ¬j.val≤i.val := by omega
  simp only [change,left,le_rfl,if_true,if_neg Ji] at total
  constructor
  · intro e
    rw [e, if_neg Ji] at total
    by_cases hj : (σ j).val ≤ i.val
    · apply Fin.ext; omega
    · simp [hj] at total
  · intro e
    rw [e, if_pos le_rfl] at total
    by_cases hi : (σ i).val ≤ i.val
    · simp [hi] at total
    · apply Fin.ext; omega

/-- Words with s single rows and d adjacent swaps encode choices of s positions
    for single rows among s+d symbols. -/
def stripWords (s d : ℕ) : ℕ := (s+d).choose s

theorem one_strip_no_ordinary (n : ℕ) : stripWords 0 n = 1 := by simp [stripWords]

theorem one_strip_two_ordinary (n : ℕ) (hn : 0<n) :
    2 * stripWords 2 (n-1) = n*(n+1) := by
  rw [stripWords, show 2+(n-1)=n+1 by omega]
  simpa [Nat.mul_comm, Nat.choose_one_right] using (Nat.succ_mul_choose_eq n 1).symm

def rectangularTwo (m n : ℕ) := m*stripWords 2 (n-1) + n*stripWords 2 (m-1)

theorem rectangle_formula (m n : ℕ) (hm : 0<m) (hn : 0<n) :
    2*rectangularTwo m n = m*n*(m+n+2) := by
  calc
    _ = m*(2*stripWords 2 (n-1)) + n*(2*stripWords 2 (m-1)) := by unfold rectangularTwo; ring
    _ = _ := by rw [one_strip_two_ordinary _ hm, one_strip_two_ordinary _ hn]; ring

theorem square_formula (n : ℕ) (hn : 0<n) : rectangularTwo n n = n^2*(n+1) := by
  have H := rectangle_formula n n hn hn
  nlinarith

#print axioms strip_invariance
#print axioms adjacent_swap
#print axioms square_formula

end DomiculeStrips

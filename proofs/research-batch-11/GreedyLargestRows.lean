import Mathlib.Data.List.Basic
import Mathlib.Tactic.Ring

namespace GreedyLargestRows

theorem no_late_descent (k x c : Nat) (hne : x ≠ k) (u : List Nat)
    (hu : k ∉ u) :
    ¬ ([k,x].Sublist (u ++ List.replicate c k)) := by
  induction u with
  | nil =>
    intro h
    have hx := h.subset (show x ∈ [k,x] by simp)
    simp [hne] at hx
  | cons a u ih =>
    simp only [List.mem_cons, not_or] at hu
    rw [List.cons_append, List.cons_sublist_cons']
    simpa [hu.1] using ih hu.2

theorem prefix_obstruction (b k x c : Nat) (hne : x ≠ k)
    (u : List Nat) (hu : k ∉ u) :
    ¬ ((List.replicate (b+1) k ++ [x]).Sublist
       (List.replicate b k ++ u ++ List.replicate c k)) := by
  induction b with
  | zero => simpa using no_late_descent k x c hne u hu
  | succ b ih =>
    simpa only [List.replicate_succ, List.cons_append, List.cons_sublist_cons] using ih

theorem witness_sizes (t n : Nat) (h : t+1 ≤ n) (hn : n ≤ 2*t-2) (ht : 4 ≤ t) :
    let b := 2*t-n
    let m := n-t+1
    let c := n-t-1
    0 < b ∧ b+c = t-1 ∧ m ≤ t-1 ∧ b+m+c = n := by dsimp; omega

theorem epoch_successor (j : Nat) :
    2*(1+3*2^j)-1 = 1+3*2^(j+1) := by rw [pow_succ]; omega

end GreedyLargestRows

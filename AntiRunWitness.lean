import Std

namespace AntiRunWitness

/-- Group successive one-bit positions. A gap of one starts a fresh anti-run. -/
def groupsAfter (previous size : Nat) : List Nat → List Nat
  | [] => [size]
  | next :: remaining =>
    if next = previous + 1 then size :: groupsAfter next 1 remaining
    else groupsAfter next (size + 1) remaining

def antiRuns (n : Nat) : List Nat :=
  match (List.range (n + 1)).filter (fun p => n.testBit p) with
  | [] => []
  | p :: remaining => groupsAfter p 1 remaining

/-- Exactly the rows observed at integers 0 through n-1. -/
def earlier (n : Nat) : List (List Nat) :=
  ((List.range n).map antiRuns).eraseDups

def IsRow (j : Nat) (row : List Nat) : Prop :=
  ∃ n, antiRuns n = row ∧ row ∉ earlier n ∧ (earlier n).length = j

def fib : Nat → Nat
  | 0 => 0
  | 1 => 1
  | n + 2 => fib (n+1) + fib n

theorem fibStep (k : Nat) : fib k ≤ fib (k+1) := by
  cases k with
  | zero => decide
  | succ k => exact Nat.le_add_right _ _

theorem fibMono {a b : Nat} (h : a ≤ b) : fib a ≤ fib b := by
  induction h with
  | refl => exact Nat.le_refl _
  | step _ ih => exact Nat.le_trans ih (fibStep _)

theorem fibGap (k : Nat) : fib k ≤ 8 ∨ 13 ≤ fib k := by
  by_cases h : k ≤ 6
  · exact Or.inl (Nat.le_trans (fibMono h) (by decide : fib 6 ≤ 8))
  · have lower : 7 ≤ k := by omega
    exact Or.inr (Nat.le_trans (by decide : 13 ≤ fib 7) (fibMono lower))

/-- Row 7 contradicts the proposed A001911 - 2 formula, under both
    zero-based indexing and one-based numbering of positions. -/
theorem counterexample :
    IsRow 7 [1,1,1,1] ∧
    (∀ k, fib (k+3) - 2 - 2 ≠ 7) ∧
    (∀ k, fib (k+3) - 2 - 2 ≠ 8) := by
  constructor
  · exact ⟨15, by decide, by decide, by decide⟩
  · constructor <;> intro k <;> have gap := fibGap (k+3) <;> omega

#print axioms counterexample

end AntiRunWitness

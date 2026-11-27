import Mathlib.Algebra.BigOperators.Group.List.Basic
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.Ring

namespace MeeussenForestCoefficients

/-- A node is stored with its forest of children and the forest of later siblings. -/
inductive Forest where
  | empty
  | tree (children later : Forest)

def size : Forest → ℕ
  | .empty => 0
  | .tree c r => 1 + size c + size r

def pathLength : Forest → ℕ
  | .empty => 0
  | .tree c r => pathLength c + size c + pathLength r

/-- The partition coordinates in reverse order, including zero parts. -/
def closesBeforeOpens : Forest → List ℕ
  | .empty => []
  | .tree c r => 0 :: (closesBeforeOpens c ++
      (closesBeforeOpens r).map (fun x => 1 + size c + x))

theorem coords_length (s : Forest) : (closesBeforeOpens s).length = size s := by
  induction s with
  | empty => rfl
  | tree c r ihc ihr => simp [closesBeforeOpens, size, ihc, ihr]; omega

private theorem shift_sum (a : ℕ) (l : List ℕ) :
    (l.map (fun x => a+x)).sum = a*l.length+l.sum := by
  induction l with
  | nil => simp
  | cons x xs ih => simp [ih, Nat.mul_add]; omega

/-- Twice the area plus twice the depth sum is twice the triangle number. -/
theorem area_depth (s : Forest) :
    2 * ((closesBeforeOpens s).sum + pathLength s) + size s = size s ^ 2 := by
  induction s with
  | empty => rfl
  | tree c r ihc ihr =>
    simp only [size, pathLength, closesBeforeOpens, List.sum_cons, zero_add,
      List.sum_append, shift_sum, coords_length]
    nlinarith

end MeeussenForestCoefficients

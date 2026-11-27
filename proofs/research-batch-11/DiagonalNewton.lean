import Mathlib.Tactic.Ring
import Mathlib.Data.Rat.Defs

namespace DiagonalNewton

-- Nested evaluation in the Newton basis based at q^i,q^(i+1),...
def evaluate (q x : ℚ) (i : Nat) : List ℚ → ℚ
  | [] => 0
  | c :: cs => c + (x-q^i) * evaluate q x (i+1) cs

-- The new interior coefficient is the preceding one plus q^i times the old one.
def advance (q : ℚ) (i : Nat) (previous : ℚ) : List ℚ → List ℚ
  | [] => [previous]
  | c :: cs => (previous + q^i*c) :: advance q (i+1) c cs

theorem multiply (q x : ℚ) (cs : List ℚ) (i : Nat) (previous : ℚ) :
    evaluate q x i (advance q i previous cs) = previous + x * evaluate q x i cs := by
  induction cs generalizing i previous with
  | nil => simp [advance, evaluate]
  | cons c cs ih =>
    simp only [advance, evaluate, ih]
    ring

def gaussianRow (q : ℚ) : Nat → List ℚ
  | 0 => [1]
  | n+1 => advance q 0 0 (gaussianRow q n)

theorem newton_monomial (q x : ℚ) (n : Nat) :
    evaluate q x 0 (gaussianRow q n) = x^n := by
  induction n with
  | zero => simp [evaluate, gaussianRow]
  | succ n ih => simp only [gaussianRow, multiply, ih, zero_add, pow_succ]; ring

end DiagonalNewton

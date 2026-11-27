import Mathlib.Tactic.Ring

namespace YokeRows

abbrev Row := Nat → Nat

-- Coefficients of (1+y)F, F', and ((1+y)/(1-y))F respectively.
def plusX (u : Row) : Row
  | 0 => u 0
  | q+1 => u (q+1) + u q

def deriv (u : Row) (q : Nat) := (q+1) * u (q+1)

def mulH (u : Row) : Row
  | 0 => u 0
  | q+1 => mulH u q + u (q+1) + u q

def next (u : Row) : Row
  | 0 => u 0 + u 1
  | q+1 => next u q + (q+2) * (u (q+1) + u (q+2))

theorem row_step (u : Row) :
    plusX (next u) = mulH (deriv (plusX u)) := by
  funext q
  induction q with
  | zero => simp [plusX, next, mulH, deriv, Nat.add_comm]
  | succ q ih =>
    simp only [mulH, ← ih]
    cases q <;> simp [deriv, plusX, next] <;> ring

def rows : Nat → Row
  | 0 => fun _ => 1
  | n+1 => next (rows n)

def derivatives : Nat → Row
  | 0 => plusX (fun _ => 1)
  | n+1 => mulH (deriv (derivatives n))

theorem transformed (n : Nat) : plusX (rows n) = derivatives n := by
  induction n with
  | zero => rfl
  | succ n ih => exact (row_step (rows n)).trans (congrArg (fun u => mulH (deriv u)) ih)

theorem first_column (n : Nat) : rows n 0 = derivatives n 0 :=
  congrFun (transformed n) 0

end YokeRows

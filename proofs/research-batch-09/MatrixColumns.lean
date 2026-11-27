import Mathlib.Tactic.Ring
import Mathlib.Data.Rat.Cast.Defs

namespace MatrixColumns

inductive Cap where | zero | one | two
deriving DecidableEq
open Cap

def use (f : Cap → Nat) : Cap → Nat
  | zero => 0
  | one => f zero
  | two => f one

-- Append a row with support {}, {1}, {2}, {3}, {1,2}, {1,3}, or {2,3}.
def count : Nat → Cap → Cap → Cap → Nat
  | 0, _, _, _ => 1
  | n+1, a,b,c =>
    let f := count n
    f a b c + use (fun i => f i b c) a + use (fun j => f a j c) b +
      use (fun k => f a b k) c + use (fun i => use (fun j => f i j c) b) a +
      use (fun i => use (fun k => f i b k) c) a +
      use (fun j => use (fun k => f a j k) c) b

def q (x : ℚ) : Cap → ℚ
  | zero => 1
  | one => 1+x
  | two => 1+x*(x+1)/2

def oneForced (x : ℚ) : Cap → ℚ
  | zero => 0
  | one => 1
  | two => x

def twoForced : Cap → ℚ
  | two => 1
  | _ => 0

def formula (x : ℚ) (a b c : Cap) : ℚ :=
  q x a*q x b*q x c - x*oneForced x a*oneForced x b*oneForced x c +
    x*(x-1)/2*twoForced a*twoForced b*twoForced c

theorem count_formula (n : Nat) (a b c : Cap) :
    (count n a b c : ℚ) = formula n a b c := by
  induction n generalizing a b c with
  | zero => cases a <;> cases b <;> cases c <;> simp [count, formula, q]
  | succ n ih =>
    cases a <;> cases b <;> cases c <;>
      simp only [count, use, Nat.cast_add, Nat.cast_zero, Nat.cast_succ, ih,
        formula, q, oneForced, twoForced] <;> ring

theorem two_columns (n : Nat) :
    (count n two two zero : ℚ) = (1+(n:ℚ)*(n+1)/2)^2 := by
  rw [count_formula]; unfold formula; simp [q, oneForced, twoForced]; ring

theorem three_columns (n : Nat) :
    (count n two two two : ℚ) =
      1+(n:ℚ)+11*n^2/4+13*n^3/8+n^4/8+3*n^5/8+n^6/8 := by
  rw [count_formula]; unfold formula; simp [q, oneForced, twoForced]; ring

end MatrixColumns

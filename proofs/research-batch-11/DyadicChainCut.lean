import Mathlib.Algebra.BigOperators.Group.Finset.Basic
import Mathlib.Tactic.Ring

open scoped BigOperators

namespace DyadicChainCut

-- Positive chains of length d, first entry at most n and each next at most half.
def chains (n : Nat) : Nat → Nat
  | 0 => 1
  | d+1 => ∑ i ∈ Finset.range n, chains ((i+1)/2) d

-- Stop at the first entry below its threshold, or subtract the threshold and continue.
def split (a b : Nat) : Nat → Nat
  | 0 => 1
  | d+1 => chains a (d+1) + ∑ i ∈ Finset.range b, split (a/2) ((i+1)/2) d

theorem eval_split (d u b : Nat) :
  chains (2^d*u+b) (d+1) = split (2^d*u) b (d+1) := by
  induction d generalizing u b with
  | zero =>
    simp only [split, chains, Finset.sum_range_add, pow_zero, one_mul]
  | succ d ih =>
    rw [chains, Finset.sum_range_add, split]
    congr 1
    apply Finset.sum_congr rfl
    intro i hi
    have hp : 2^(d+1)*u = 2*(2^d*u) := by ring
    rw [hp, show (2*(2^d*u)+i+1)/2 = 2^d*u+(i+1)/2 by omega,
      show 2*(2^d*u)/2 = 2^d*u by omega]
    exact ih u ((i+1)/2)

end DyadicChainCut

import Mathlib.Algebra.BigOperators.Intervals
import Mathlib.Algebra.BigOperators.Ring.Finset
import Mathlib.Tactic.Ring

namespace WeightedBlocks
open Finset

def tail (p q : ℕ) (v : ℕ → ℕ) : ℕ → ℕ
  | 0 => v 0
  | m+1 => p * tail p q v m + q * v (m+1)

variable {p q : ℕ} {b : ℕ → ℕ}

structure Rules (p q : ℕ) (b : ℕ → ℕ) : Prop where
  odd (k) : b (2*k+1) = b k
  even (m k) : b (2^(m+1)*(2*k+1)) =
    p*b (2^m*(2*k+1)) + q*b (2^(m+1)*k)

theorem oddTail (h : Rules p q b) (m k : ℕ) :
    b (2^m*(2*k+1)) = tail p q (fun j => b (2^j*k)) m := by
  induction m with
  | zero => simpa [tail] using h.odd k
  | succ m ih => rw [h.even, ih, tail]

private theorem pairs (f : ℕ → ℕ) (N : ℕ) :
    ∑ k ∈ range (2*N), f k = ∑ k ∈ range N, (f (2*k)+f (2*k+1)) := by
  induction N with
  | zero => simp
  | succ N ih =>
    rw [Nat.mul_succ, sum_range_succ, sum_range_succ, ih, sum_range_succ]
    omega

private theorem tailSum (v : ℕ → ℕ → ℕ) (N m : ℕ) :
    ∑ k ∈ range N, tail p q (v k) m =
      tail p q (fun j => ∑ k ∈ range N, v k j) m := by
  induction m with
  | zero => rfl
  | succ m ih =>
    simp only [tail, sum_add_distrib, ← mul_sum, ih]

def block (b : ℕ → ℕ) (n m : ℕ) := ∑ k ∈ range (2^n), b (2^m*k)

theorem blockStep (h : Rules p q b) (n m : ℕ) :
    block b (n+1) m = block b n (m+1) + tail p q (block b n) m := by
  unfold block
  rw [pow_succ', pairs]
  simp only [oddTail h, sum_add_distrib, tailSum, pow_succ, Nat.mul_assoc]

def alt : ℕ → ℕ
  | 0 => 0
  | n+1 => 4*alt n+1

theorem altStep (h : Rules p q b) (n m : ℕ) :
    b (2^m*alt (n+1)) = tail p q (fun j => b (2^(j+1)*alt n)) m := by
  rw [alt, show 4*alt n+1 = 2*(2*alt n)+1 by ring, oddTail h]
  simp [pow_succ, Nat.mul_assoc]

end WeightedBlocks

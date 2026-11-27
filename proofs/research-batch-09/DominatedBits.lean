import Mathlib.Algebra.BigOperators.Intervals

namespace DominatedBits
open Finset

/-- Bounds are the positions of the set bits in increasing order.
Choose the least position x, delete it, then rebase the remaining positions. -/
def count (bounds : List ℕ) : ℕ :=
  match bounds with
  | [] => 1
  | b :: bs => ∑ x ∈ range (b+1), count (bs.map (fun t => t-(x+1)))
termination_by bounds.length
decreasing_by simp

theorem odd (bs : List ℕ) : count (0 :: bs.map Nat.succ) = count bs := by
  rw [count]
  simp [List.map_map, Function.comp_def]

theorem even (b : ℕ) (bs : List ℕ) :
    count ((b+1) :: bs.map Nat.succ) = count (b :: bs) + count bs := by
  conv_lhs => rw [count, sum_range_succ']
  conv_rhs => rw [count]
  simp [List.map_map, Function.comp_def, Nat.succ_sub_succ_eq_sub]

def raiseBy (j : ℕ) (bs : List ℕ) := bs.map (· + j)

/-- Group the possible lowest selected positions as in the recurrence in MO 486776. -/
theorem dyadic (m : ℕ) (bs : List ℕ) :
    count (m :: raiseBy (m+1) bs) = ∑ j ∈ range (m+1), count (raiseBy j bs) := by
  induction m with
  | zero => simpa [raiseBy] using odd bs
  | succ m ih =>
    rw [sum_range_succ, ← ih]
    simpa [raiseBy, List.map_map, Function.comp_def, Nat.add_assoc] using
      even m (raiseBy (m+1) bs)

def packed : List ℕ → ℕ
  | [] => 0
  | m::ms => 2^m * (2*packed ms+1)

def positions : List ℕ → List ℕ
  | [] => []
  | m::ms => m :: raiseBy (m+1) (positions ms)

/-- For any list of gaps before successive one-bits, the sequence specified by
the original recurrence counts all choices dominated by those bit positions. -/
theorem identifies (b : ℕ → ℕ) (base : b 0 = 1)
    (step : ∀ m k, b (2^m * (2*k+1)) = ∑ j ∈ range (m+1), b (2^j*k))
    (gaps : List ℕ) (s : ℕ) :
    b (2^s * packed gaps) = count (raiseBy s (positions gaps)) := by
  induction gaps generalizing s with
  | nil => simpa [packed, positions, raiseBy, count] using base
  | cons m ms ih =>
    simp only [packed, ← Nat.mul_assoc, ← pow_add, step, ih]
    rw [← dyadic]
    simp [positions, raiseBy, List.map_map, Function.comp_def, Nat.add_comm,
      Nat.add_left_comm, Nat.add_assoc]

end DominatedBits

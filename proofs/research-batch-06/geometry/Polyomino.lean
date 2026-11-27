import Mathlib.Tactic.Ring
import Mathlib.Tactic.Linarith
import Mathlib.Algebra.BigOperators.Group.Finset.Basic

namespace MatharA308359

/-- Number of interval-column continuations, by their remaining number of columns,
    excess area, and the height of the immediately preceding column. At a new
    column of height q+1 the two intervals can meet in h+q offsets. -/
def suffix : ℕ → ℕ → ℕ → ℕ
  | 0, e, _ => if e=0 then 1 else 0
  | t+1, e, h => ∑ q ∈ Finset.range (e+1), (h+q)*suffix t (e-q) (q+1)

private theorem zero_step (t h : ℕ) :
    suffix (t+1) 0 h = h*suffix t 0 1 := by
  simp [suffix,Finset.sum_range_succ]

private theorem one_step (t h : ℕ) :
    suffix (t+1) 1 h = h*suffix t 1 1 + (h+1)*suffix t 0 2 := by
  simp [suffix,Finset.sum_range_succ]

private theorem two_step (t h : ℕ) :
    suffix (t+1) 2 h = h*suffix t 2 1 + (h+1)*suffix t 1 2 + (h+2)*suffix t 0 3 := by
  simp [suffix,Finset.sum_range_succ]

private theorem zero_excess (k h : ℕ) : suffix (k+1) 0 h = h := by
  induction k generalizing h with
  | zero => simp [zero_step,suffix]
  | succ k ih => rw [zero_step,ih]; simp

private theorem one_excess (k h : ℕ) : suffix (k+2) 1 h = 4*h*(k+1)+2 := by
  induction k generalizing h with
  | zero =>
    rw [one_step,one_step,zero_excess]
    simp [suffix]
    ring
  | succ k ih =>
    rw [one_step,ih,zero_excess]
    ring

private theorem two_excess (k : ℕ) :
    suffix (k+2) 2 1 = 8*k^2+21*k+18 := by
  induction k with
  | zero => decide
  | succ k ih =>
    rw [two_step,ih,one_excess,zero_excess]
    ring

/-- The first column has a fixed bottom and can use zero, one or two extra
    cells. Its remaining w-1 columns are counted by the continuation recurrence. -/
def profiles (w : ℕ) : ℕ :=
  suffix (w-1) 2 1 + suffix (w-1) 1 2 + suffix (w-1) 0 3

/-- Weighted enumeration of every interval-column profile for n>=5. -/
theorem count_profiles (n : ℕ) (hn : 5 ≤ n) :
    (profiles (n-2) : ℤ)=8*(n:ℤ)^2-51*(n:ℤ)+86 := by
  obtain ⟨k,rfl⟩ : ∃ k : ℕ, n=k+5 := ⟨n-5,by omega⟩
  unfold profiles
  have size : k+5-2-1=k+2 := by omega
  rw [size,two_excess,one_excess,zero_excess]
  push_cast
  ring

/-- The pair-sum identity with endpoint and interior weights, with the
    adjacent correction and the triple-column term. -/
theorem combine_counts (w twoDouble : ℤ)
    (count : 2*twoDouble=(4*w-4)^2-(16*w-24)-2*(4*w-8)) :
    9*(w-2)+6+twoDouble=8*(w+2)^2-51*(w+2)+86 := by
  nlinarith only [count]

#print axioms combine_counts
#print axioms count_profiles

end MatharA308359

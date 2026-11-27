import Mathlib.Algebra.BigOperators.Group.Finset.Basic
import Mathlib.Tactic.Ring

namespace RowAlgorithms

/-- One update on the unprocessed suffix. The second component is its running
    sum, exactly the accumulator after updating position l. -/
def scan {R : Type*} [Semiring R] (weight f : ℕ → R) : ℕ → R × R
  | 0 => (f 0,f 0)
  | i+1 =>
    let previous := scan weight f i
    let next := weight (i+1)*f (i+1) + previous.2
    (next,previous.2+next)

theorem accumulator {R : Type*} [CommSemiring R] (weight f : ℕ → R) (i : ℕ) :
    (scan weight f i).2 = ∑ j ∈ Finset.range (i+1), (scan weight f j).1 := by
  induction i with
  | zero => simp [scan]
  | succ i ih => rw [Finset.sum_range_succ,← ih]; rfl

theorem scanned_coeff {R : Type*} [CommSemiring R] (weight f : ℕ → R)
    (h0 : weight 0=1) (i : ℕ) :
    (scan weight f i).1=weight i*f i+∑ j ∈ Finset.range i, (scan weight f j).1 := by
  cases i with
  | zero => simp [scan,h0]
  | succ i => rw [← accumulator]; rfl

def origin {R : Type*} [Semiring R] (i : ℕ) : R := if i=0 then 1 else 0

def rows {R : Type*} [Semiring R] (w : ℕ → R) : ℕ → ℕ → R
  | 0 => origin
  | n+1 => fun j => (scan w (rows w n) (j+1)).1

def schr (y : ℤ) (n : ℕ) := 2*rows (fun l => y^l) n 0

theorem fourth_polynomial (y : ℤ) :
    schr y 4=2+12*y+16*y^2+20*y^3+16*y^4+8*y^5+16*y^6 := by
  simp [schr,rows,scan,origin]
  ring

/-- The defining GF is equivalent to A=1+x*A(xy)*(A+1).
    Its row recurrence constructs the full OEIS polynomials independently. -/
def gfRows (y : ℤ) : ℕ → ℤ
  | 0 => 1
  | n+1 =>
    ∑ j ∈ Finset.range (n+1),
      if h : j ≤ n then y^j * gfRows y j * (gfRows y (n-j) + (if n-j=0 then 1 else 0))
      else 0
termination_by n => n
decreasing_by all_goals omega

theorem fourth_from_gf (y : ℤ) :
    gfRows y 4=2+12*y+16*y^2+20*y^3+16*y^4+8*y^5+16*y^6 := by
  simp [gfRows,Finset.sum_range_succ]
  ring

theorem truncated_counterexample :
    schr 1 4 ≠ 2+12+16+20+16 := by rw [fourth_polynomial]; decide

theorem mobile_prefix :
    (List.range 7).map (fun n => rows (fun l => (l+1:ℕ)) n 0) =
      [1,1,5,41,469,6889,123605] := by decide

end RowAlgorithms

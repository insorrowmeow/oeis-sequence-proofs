import Std

/- OEIS A103769, using the double binomial sum printed in the entry.
   The statement tested is the recurrence as printed on 2026-11-26. -/
namespace Mathar

def binom : Nat → Nat → Nat
  | _, 0 => 1
  | 0, _ + 1 => 0
  | n + 1, k + 1 => binom n k + binom n (k + 1)

def a (n : Nat) : Nat :=
  ((List.range (n + 1)).map fun j =>
    ((List.range (j + 1)).map fun k =>
      binom n j * binom j k * binom (j + k) ((j + k) / 2)).sum).sum

def discrepancy (n : Nat) : Int :=
  let t : Int := n
  t * (2*t+1) * a n +
    2 * (-61*t^2+57*t-20) * a (n-1) +
    3 * (205*t^2-523*t+346) * a (n-2) -
    72 * (t-2) * (16*t-33) * a (n-3) +
    567 * (t-2) * (t-3) * a (n-4)

theorem values : (List.range 5).map a = [1,4,21,123,757] := by decide
theorem witness : discrepancy 4 = -81756 := by decide
theorem printed_recurrence_is_false : ¬ (∀ n : Nat, 4 ≤ n → discrepancy n = 0) := by
  intro h
  have h4 := h 4 (by decide)
  rw [witness] at h4
  contradiction

#print axioms printed_recurrence_is_false
end Mathar

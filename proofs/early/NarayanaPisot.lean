import Mathlib.Tactic.Ring
import Mathlib.Tactic.Linarith

namespace NarayanaPisot

/-- Nearest integer to y²/x for x>0, choosing the lower integer on ties. -/
def roundStep (x y : Int) : Int := (2*y^2+x-1)/(2*x)

private theorem rounding_iff {x y z : Int} (hx : 0 < x) :
    roundStep x y = z ↔ -x < 2*(y^2-x*z) ∧ 2*(y^2-x*z) ≤ x := by
  unfold roundStep
  rw [Int.ediv_eq_iff_of_pos (by omega)]
  constructor <;> rintro ⟨h1,h2⟩ <;> constructor <;> nlinarith

private theorem round_grows {x y : Int} (hx : 0 < x) (hxy : x < y) :
    y < roundStep x y := by
  have h := Int.le_ediv_of_mul_le (a := y+1) (b := 2*y^2+x-1) (c := 2*x)
    (by omega) (by nlinarith [mul_nonneg (show 0 ≤ y-x-1 by omega) (show 0 ≤ y by omega)])
  unfold roundStep
  omega

/-- Candidate linear sequence. -/
private def linear (x y z : Int) : Nat → Int
  | 0 => x
  | 1 => y
  | 2 => z
  | n+3 => linear x y z (n+2) + linear x y z n

section Certificate

variable {x y z : Int}
local notation "b" => linear x y z

private theorem positive (hx : 0 < x) (hxy : x < y) (hyz : y < z) (n : Nat) : 0 < b n := by
  induction n using Nat.strong_induction_on with
  | h n ih =>
    match n with
    | 0 => exact hx
    | 1 => exact lt_trans hx hxy
    | 2 => exact lt_trans (lt_trans hx hxy) hyz
    | n+3 => exact add_pos (ih (n+2) (by omega)) (ih n (by omega))

private theorem growing (hx : 0 < x) (hxy : x < y) (hyz : y < z) (n : Nat) : b n < b (n+1) := by
  match n with
  | 0 => exact hxy
  | 1 => exact hyz
  | n+2 => change b (n+2) < b (n+2) + b n; linarith [positive hx hxy hyz n]

private def discrepancy (u v w : Int) (n : Nat) : Int :=
  linear u v w (n+1)^2 - linear u v w n * linear u v w (n+2)
local notation "D" => discrepancy x y z

private theorem error_step (n : Nat) : D (n+3) = D n - D (n+1) := by
  change (b (n+2) + b n + b (n+1))^2 - (b (n+2) + b n) *
    (b (n+2) + b n + b (n+1) + b (n+2)) =
    (b (n+1)^2 - b n * b (n+2)) - (b (n+2)^2 - b (n+1) * (b (n+2) + b n))
  ring

private theorem bounds (hx : 0 < x) (hxy : x < y) (hyz : y < z)
    (initial : ∀ i, i < 3 → roundStep (b i) (b (i+1)) = b (i+2))
    (n : Nat) : -b n < 2*D n ∧ 2*D n ≤ b n := by
  induction n using Nat.strong_induction_on with
  | h n ih =>
    match n with
    | 0 | 1 | 2 => exact (rounding_iff (positive hx hxy hyz _)).mp (initial _ (by decide))
    | n+3 =>
      obtain ⟨lo,hi⟩ := ih n (by omega)
      obtain ⟨lo',hi'⟩ := ih (n+1) (by omega)
      have g : b (n+1) < b (n+2) := growing hx hxy hyz (n+1)
      rw [error_step]
      change -(b (n+2) + b n) < 2*(D n-D (n+1)) ∧ 2*(D n-D (n+1)) ≤ b (n+2) + b n
      constructor <;> omega

end Certificate

/-- Pisot P(x,y) with its original nonlinear rule and ties rounded down. -/
def pisot (x y : Int) : Nat → Int
  | 0 => x
  | 1 => y
  | n+2 => roundStep (pisot x y n) (pisot x y (n+1))

/-- For every increasing positive starting pair, the first two possible
instances of the Narayana recurrence decide whether it holds forever. -/
theorem two_step_test {x y : Int} (hx : 0 < x) (hxy : x < y) :
    (∀ n, pisot x y (n+3) = pisot x y (n+2) + pisot x y n) ↔
      pisot x y 3 = pisot x y 2 + x ∧ pisot x y 4 = pisot x y 3 + y := by
  constructor
  · exact fun h => ⟨h 0, h 1⟩
  · rintro ⟨h3,h4⟩
    let z := roundStep x y
    let b := linear x y z
    have hyz : y < z := round_grows hx hxy
    have starts : ∀ i, i < 3 → roundStep (b i) (b (i+1)) = b (i+2) := by
      intro i hi
      match i with
      | 0 => rfl
      | 1 => exact h3
      | 2 =>
        change roundStep (pisot x y 2) (pisot x y 2 + x) = pisot x y 2 + x + y
        rw [← h3]
        exact h4
      | i+3 => omega
    have same (n : Nat) : pisot x y n = b n := by
      induction n using Nat.strong_induction_on with
      | h n ih =>
        match n with
        | 0 | 1 => rfl
        | n+2 =>
          change roundStep (pisot x y n) (pisot x y (n+1)) = b (n+2)
          rw [ih n (by omega), ih (n+1) (by omega)]
          exact (rounding_iff (positive hx hxy hyz n)).mpr (bounds hx hxy hyz starts n)
    intro n
    simp only [same]
    rfl

theorem dale_recurrence (n : Nat) : pisot 4 6 (n+3) = pisot 4 6 (n+2) + pisot 4 6 n :=
  (two_step_test (by decide : (0 : Int) < 4) (by decide : (4 : Int) < 6)).mpr (by decide) n

#print axioms two_step_test
#print axioms dale_recurrence

section ContinuedFraction

variable {R : Type*} [CommRing R]

private def factor (x : R) (k : Nat) : R := 2 * (k : R) + 1 + x^2
private def den (x : R) (k : Nat) : R := 1 - x * factor x k
private def num (x : R) (k : Nat) : R := den x k + 2*x

/-- Pair of numerator and denominator for a truncation of depth `m`, with tail 1. -/
def convergent (x : R) (k m : Nat) : R × R :=
  match m with
  | 0 => (1, 1)
  | m+1 =>
    let tail := convergent x (k+1) m
    ((1 + x * factor x (k+1)) * tail.1 - x * factor x k * tail.2, tail.1)

private def factors (x : R) (k m : Nat) : R :=
  match m with
  | 0 => 1
  | m+1 => factor x k * factors x (k+1) m

private theorem transport (x p q : R) (k : Nat) :
    ((1 + x * factor x (k+1))*p - x*factor x k*q)*den x k - p*num x k =
      x*factor x k*(p*den x (k+1) - q*num x (k+1)) := by
  simp only [factor, den, num, Nat.cast_add, Nat.cast_one]
  ring

/-- Exact truncation error after clearing denominators. In a formal variable
`x`, agreement through degree `m` follows because both denominators are units. -/
theorem gladkovskii_certificate (x : R) (k m : Nat) :
    (convergent x k m).1 * den x k - (convergent x k m).2 * num x k =
      -2 * x^(m+1) * factors x k m := by
  induction m generalizing k with
  | zero => simp [convergent, den, num, factors]
  | succ m ih =>
    change ((1 + x * factor x (k+1)) * (convergent x (k+1) m).1 -
      x * factor x k * (convergent x (k+1) m).2) * den x k -
      (convergent x (k+1) m).1 * num x k = _
    rw [transport, ih (k+1), factors, pow_succ x (m+1)]
    ring

#print axioms gladkovskii_certificate

end ContinuedFraction

end NarayanaPisot

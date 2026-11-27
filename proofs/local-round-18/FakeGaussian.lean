import Mathlib.Algebra.Polynomial.Coeff
import Mathlib.Algebra.Polynomial.Degree.Domain
import Mathlib.Algebra.Polynomial.Eval.Defs
import Mathlib.RingTheory.Localization.FractionRing
import Mathlib.Tactic.Ring

/-! Counterexample to Conjecture 4 of Gatzweiler and Krattenthaler,
Ramanujan Journal 69 (2026), article 13. Indices of the weights start at 1. -/

namespace FakeGaussian
open Polynomial

noncomputable section

abbrev Pol := Polynomial ℤ
abbrev Frac := FractionRing Pol

/-- The product of (1-X^(m+i))^(a i) for 1 ≤ i ≤ n. -/
def factors (m n : ℕ) (a : ℕ → ℕ) : Pol :=
  ((List.range n).map fun j => (1 - X^(m+(j+1)))^(a (j+1))).prod

/-- The entire expression as an actual element of the rational-function field. -/
def quotient (m n : ℕ) (a : ℕ → ℕ) : Frac :=
  algebraMap Pol Frac (factors m n a) / algebraMap Pol Frac (factors 0 n a)

def conjectureFour : Prop :=
  ∀ (m n : ℕ), 0 < m → 0 < n → n ≤ m → ∀ (a : ℕ → ℕ) (p : Pol),
    quotient m n a = algebraMap Pol Frac p → ∀ j, 0 ≤ p.coeff j

def weights (i : ℕ) : ℕ := if i ∈ [6, 7, 14, 18, 20] then 1 else 0

private def expanded (m : ℕ) (a : ℕ → ℕ) (indices : List ℕ) :=
  indices.flatMap fun j => List.replicate (a (j+1)) (m+(j+1))

private def binomials (ks : List ℕ) : Pol :=
  (ks.map fun k => (1 - X^k : Pol)).prod

private theorem expand_factors (m : ℕ) (a : ℕ → ℕ) (js : List ℕ) :
    binomials (expanded m a js) =
      (js.map fun j => (1 - X^(m+(j+1)) : Pol)^(a (j+1))).prod := by
  induction js with
  | nil => rfl
  | cons j js ih =>
    simpa [binomials, expanded, List.map_append, List.prod_append] using
      congrArg (fun p : Pol => (1-X^(m+(j+1)))^(a (j+1))*p) ih

private theorem actual_denominator :
    factors 0 20 weights = binomials [6,7,14,18,20] := by
  rw [factors, ← expand_factors]
  exact congrArg binomials (by decide : expanded 0 weights (List.range 20) = _)

private theorem actual_numerator :
    factors 22 20 weights = binomials [28,29,36,40,42] := by
  rw [factors, ← expand_factors]
  exact congrArg binomials (by decide : expanded 22 weights (List.range 20) = _)

/- Lists represent polynomials over the integers in ascending degree order.
   The identities below prove correctness of the finite coefficient arithmetic. -/
private def toPoly : List ℤ → Pol
  | [] => 0
  | a :: p => C a + X * toPoly p

private def subtract : List ℤ → List ℤ → List ℤ
  | [], ys => ys.map (-·)
  | x::xs, [] => x::xs
  | x::xs, y::ys => (x-y)::subtract xs ys

private theorem neg_poly (xs : List ℤ) : toPoly (xs.map (-·)) = -toPoly xs := by
  induction xs with
  | nil => simp [toPoly]
  | cons x xs ih => simp [toPoly, ih]; ring

private theorem subtract_poly (xs ys : List ℤ) :
    toPoly (subtract xs ys) = toPoly xs - toPoly ys := by
  induction xs generalizing ys with
  | nil => simp [subtract, toPoly, neg_poly]
  | cons x xs ih =>
    cases ys with
    | nil => simp [subtract,toPoly]
    | cons y ys => simp [subtract,toPoly,ih]; ring

private theorem shifted_poly (k : ℕ) (xs : List ℤ) :
    toPoly (List.replicate k 0 ++ xs) = X^k * toPoly xs := by
  induction k with
  | zero => simp
  | succ k ih => simp [List.replicate_succ,toPoly,ih,pow_succ]; ring

private def multiply : List ℕ → List ℤ → List ℤ
  | [], xs => xs
  | k::ks, xs =>
    let ys := multiply ks xs
    subtract ys (List.replicate k 0 ++ ys)

private theorem multiply_poly (ks : List ℕ) (xs : List ℤ) :
    toPoly (multiply ks xs) = binomials ks * toPoly xs := by
  induction ks with
  | nil => simp [multiply, binomials]
  | cons k ks ih =>
    simp only [multiply,subtract_poly,shifted_poly,ih]
    simp [binomials]; ring

private theorem coeff_poly (xs : List ℤ) (k : ℕ) :
    (toPoly xs).coeff k = xs[k]?.getD 0 := by
  induction xs generalizing k with
  | nil => simp [toPoly]
  | cons x xs ih =>
    cases k with
    | zero => simp [toPoly]
    | succ k =>
      simp only [toPoly,coeff_add,coeff_C_succ,coeff_X_mul,zero_add,ih]
      rfl

private def certificate : List ℤ :=
  [1,0,0,0,0,0,1,1,0,0,0,0,1,1,2,0,0,0,2,1,3,2,0,0,2,2,3,3,2,-1,
   2,2,5,3,4,1,1,2,6,5,4,3,2,0,6,6,6,2,4,0,4,6,8,4,3,2,3,4,8,6,
   4,0,4,2,6,6,6,0,2,3,4,5,6,2,1,1,4,3,5,2,2,-1,2,3,3,2,2,0,0,
   2,3,1,2,0,0,0,2,1,1,0,0,0,0,1,1,0,0,0,0,0,1]

def witness : Pol := toPoly certificate

set_option maxRecDepth 10000 in
theorem product_identity :
    factors 0 20 weights * witness = factors 22 20 weights := by
  have h : multiply [6,7,14,18,20] certificate = multiply [28,29,36,40,42] [1] := by decide
  simpa [actual_denominator,actual_numerator,witness,multiply_poly,toPoly] using
    congrArg toPoly h

theorem denominator_ne_zero : factors 0 20 weights ≠ 0 := by
  intro h
  have hz := congrArg (fun p : Pol => p.eval 0) h
  simp [actual_denominator,binomials] at hz

theorem rational_function_identity : quotient 22 20 weights = algebraMap Pol Frac witness := by
  have nz : algebraMap Pol Frac (factors 0 20 weights) ≠ 0 :=
    (map_ne_zero_iff _ (IsFractionRing.injective Pol Frac)).mpr denominator_ne_zero
  unfold quotient
  apply (div_eq_iff nz).mpr
  rw [← map_mul, mul_comm, product_identity]

theorem coefficient_29 : witness.coeff 29 = -1 := by
  rw [witness, coeff_poly]
  decide

theorem not_conjecture_four : ¬ conjectureFour := by
  intro h
  have hc := h 22 20 (by decide) (by decide) (by decide) weights witness
    rational_function_identity 29
  rw [coefficient_29] at hc
  exact (by decide : ¬ (0 : ℤ) ≤ -1) hc

#print axioms product_identity
#print axioms rational_function_identity
#print axioms coefficient_29
#print axioms not_conjecture_four

end
end FakeGaussian

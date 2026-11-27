import Mathlib.Data.Nat.Factorization.Basic
import Mathlib.Tactic.NormNum
import Mathlib.Tactic.Ring

namespace PrimorialCarryCollision

def Z : ℕ := 123017^1504
def j : ℕ := 656100*Z
def k : ℕ := 2624372*Z
def loss : ℕ := 656093*Z

/-- Evaluate the usual arithmetic derivative on an explicitly factored input. -/
def productOf : List (ℕ × ℕ) → ℕ
  | [] => 1
  | (p,e)::t => p^e * productOf t

def derivativeOf : List (ℕ × ℕ) → ℕ
  | [] => 0
  | (p,e)::t => (e*p^(e-1))*productOf t + p^e*derivativeOf t

def jf : List (ℕ × ℕ) := [(2,2),(3,8),(5,2),(123017,1504)]
def kf : List (ℕ × ℕ) := [(2,2),(137,1),(4789,1),(123017,1504)]

theorem factored_witness :
    (∀ z ∈ jf ++ kf, z.1.Prime) ∧ productOf jf = j ∧ productOf kf = k ∧
    28 < j ∧ j < k ∧ derivativeOf jf = derivativeOf kf := by native_decide

theorem derivative_eval (D : ℕ → ℕ) (h1 : D 1 = 0)
    (hmul : ∀ a b, D (a*b) = D a*b + a*D b)
    (hp : ∀ p, Nat.Prime p → D p=1)
    (f : List (ℕ × ℕ)) (hf : ∀ z ∈ f, z.1.Prime) :
    D (productOf f) = derivativeOf f := by
  have hpows (p : ℕ) (h : p.Prime) (e : ℕ) : D (p^e) = e*p^(e-1) := by
    cases e with
    | zero => simp [h1]
    | succ n =>
      simp only [Nat.add_one_sub_one]
      induction n with
      | zero => simp [hp p h]
      | succ n ih =>
        rw [pow_succ p (n+1), hmul, ih, hp p h, pow_succ p n]
        ring
  induction f with
  | nil => exact h1
  | cons s xs ih =>
    rcases s with ⟨p,e⟩
    simp only [productOf, derivativeOf, hmul]
    rw [hpows p (hf (p,e) (by simp)) e, ih (fun z hz => hf z (by simp [hz]))]

theorem equal_arithmetic_derivatives (D : ℕ → ℕ) (h1 : D 1=0)
    (hmul : ∀ a b, D (a*b) = D a*b + a*D b)
    (hp : ∀ p, p.Prime → D p=1) : D j = D k := by
  obtain ⟨hf,hj,hk,_,_,he⟩ := factored_witness
  rw [← hj, ← hk, derivative_eval D h1 hmul hp jf (fun z hz => hf z (by simp [hz])),
    derivative_eval D h1 hmul hp kf (fun z hz => hf z (by simp [hz])), he]

/-- Positive primes in a carry-free value have all exponents below the radix. -/
def Normal (n : ℕ) := ∀ p : ℕ, p.Prime → n.factorization p < p

private theorem single_exp_normal {b : ℕ} (hb : b.Prime) (hd : b ≠ 123017) :
    Normal (b*Z) := by
  have hlarge : Nat.Prime 123017 := by native_decide
  intro p hp
  rw [Nat.factorization_mul hb.ne_zero (by unfold Z; positivity),
    hb.factorization, show Z.factorization = Finsupp.single 123017 1504 from hlarge.factorization_pow,
    Finsupp.add_apply]
  by_cases h : b = p
  · subst p
    simp [Finsupp.single_apply, Ne.symm hd, hb.one_lt]
  · by_cases g : 123017 = p
    · subst p
      simp [Finsupp.single_apply, hd]
    · simp [Finsupp.single_apply, h, g, hp.pos]

theorem normal_j : Normal (7*Z) := single_exp_normal (by decide) (by decide)

theorem normal_k : Normal (1968279*Z) := by
  have h3 : Nat.Prime 3 := by decide
  have h137 : Nat.Prime 137 := by decide
  have h4789 : Nat.Prime 4789 := by native_decide
  have hlarge : Nat.Prime 123017 := by native_decide
  intro p hp
  rw [show 1968279 = (3*137)*4789 by decide]
  have hp₀ := hp.pos
  simp only [Nat.factorization_mul (by decide : (3:ℕ) ≠ 0) (by decide : (137:ℕ) ≠ 0),
    Nat.factorization_mul (by decide : 3*(137:ℕ) ≠ 0) (by decide : (4789:ℕ) ≠ 0),
    Nat.factorization_mul (by decide : 3*137*(4789:ℕ) ≠ 0) (by unfold Z; positivity : Z ≠ 0),
    h3.factorization, h137.factorization, h4789.factorization,
    show Z.factorization = Finsupp.single 123017 1504 from hlarge.factorization_pow,
    Finsupp.add_apply, Finsupp.single_apply]
  by_cases h₁ : 3=p <;> by_cases h₂ : 137=p <;> by_cases h₃ : 4789=p <;>
    by_cases h₄ : 123017=p <;> simp [h₁,h₂,h₃,h₄] <;> omega

/-- Carry replaces p copies of p by one copy of the next prime. -/
def Carries (p q n m : ℕ) : Prop :=
  p.Prime ∧ q.Prime ∧ p < q ∧ (∀ r : Fin q, p < r.val → ¬ r.val.Prime) ∧
    n % (p^p) = 0 ∧ m = n / (p^p) * q

theorem witnessed_carries :
    Carries 2 3 j (492075*Z) ∧
    Carries 3 5 (492075*Z) (91125*Z) ∧
    Carries 3 5 (91125*Z) (16875*Z) ∧
    Carries 3 5 (16875*Z) (3125*Z) ∧
    Carries 5 7 (3125*Z) (7*Z) ∧
    Carries 2 3 k (1968279*Z) ∧ j-7*Z = loss ∧ k-1968279*Z = loss := by
  unfold Carries
  native_decide

def numerator (a b c d : ℕ) := 3^a * 5^b * 7^c * 11^d
def denominator (a b c d : ℕ) := 4^a * 27^b * 3125^c * 823543^d

theorem exponent_cutoffs :
    656100 * 3^40 < 7 * 4^40 ∧ 656100 * 5^7 < 7 * 27^7 ∧
    656100 * 7^2 < 7 * 3125^2 ∧ 656100 * 11^2 < 7 * 823543^2 ∧
    2 * 656100 < 7 * 11^10 := by native_decide

/-- No ratio between the two witnessed ratios can give an integer preimage
with this loss: express the test without fractions or reduced-fraction assumptions. -/
theorem no_intermediate_ratio :
    ∀ a : Fin 40, ∀ b : Fin 7, ∀ c : Fin 2, ∀ d : Fin 2,
      let x := numerator a.val b.val c.val d.val
      let y := denominator a.val b.val c.val d.val
      7*y < 656100*x → 4*x < 3*y → ¬ (y-x) ∣ (loss*y) := by native_decide

end PrimorialCarryCollision

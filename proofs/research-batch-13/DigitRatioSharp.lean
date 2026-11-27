import Mathlib.Data.Nat.Digits

namespace DigitRatioSharp

/-- Re-evaluating the decimal digits in base 100 inserts one zero between them. -/
def insertZeros (n : ℕ) : ℕ := Nat.ofDigits 100 (Nat.digits 10 n)

/-- The original sequence A343550 only admits numbers of at least two digits. -/
def eligible (n : ℕ) : Prop := 10 ≤ n ∧ n ∣ insertZeros n

def primitive (n : ℕ) : Prop := eligible n ∧ ¬ ∃ m, eligible m ∧ n = 10 * m

def witness (i : Fin 9) : ℕ := 10 * (i.val + 1)

theorem witness_injective : Function.Injective witness := by
  intro i j h
  apply Fin.ext
  simpa [witness] using h

theorem nine_primitive_witnesses (i : Fin 9) :
    primitive (witness i) ∧ insertZeros (witness i) = 10 * witness i := by
  have value : ∀ t : Fin 9, insertZeros (witness t) = 10 * witness t := by
    intro t
    have h := Nat.digits_add 10 (by decide) 0 (t.val+1) (by decide) (Or.inr (by omega))
    rw [zero_add, Nat.digits_of_lt 10 (t.val+1) (by omega) (by omega)] at h
    simp only [insertZeros, witness, h, Nat.ofDigits_cons, Nat.ofDigits_nil]
    omega
  have hi := i.isLt
  refine ⟨⟨⟨by unfold witness; omega, ⟨10, by rw [value, Nat.mul_comm]⟩⟩, ?_⟩, value i⟩
  rintro ⟨m, hm, h⟩
  have := hm.1
  unfold witness at h
  omega

end DigitRatioSharp

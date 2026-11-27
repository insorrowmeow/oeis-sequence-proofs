import Mathlib.NumberTheory.ArithmeticFunction
import Mathlib.Algebra.BigOperators.Associated

namespace DivisorColumnOscillation

/-- A prime divisor of the divisor count forces a large prime power in any odd integer. -/
theorem prime_divisor_count_lower_bound {m p : ℕ} (hm : 0 < m)
    (hodd : ¬ 2 ∣ m) (hp : p.Prime) (hd : p ∣ m.divisors.card) :
    3 ^ (p - 1) ≤ m := by
  rw [Nat.card_divisors hm.ne'] at hd
  obtain ⟨q, hq, hfactor⟩ := (hp.prime.dvd_finset_prod_iff _).mp hd
  have hprime := Nat.prime_of_mem_primeFactors hq
  have hnot : q ≠ 2 := by
    rintro rfl
    exact hodd (Nat.dvd_of_mem_primeFactors hq)
  have hbase : 3 ≤ q := by have := hprime.two_le; omega
  have hle : p ≤ m.factorization q + 1 := Nat.le_of_dvd (Nat.succ_pos _) hfactor
  have hpow : q ^ m.factorization q ∣ m :=
    (hprime.pow_dvd_iff_le_factorization hm.ne').mpr le_rfl
  calc
    3 ^ (p - 1) ≤ q ^ (p - 1) := Nat.pow_le_pow_left hbase _
    _ ≤ q ^ m.factorization q := Nat.pow_le_pow_right hprime.pos (by omega)
    _ ≤ m := Nat.le_of_dvd hm hpow

end DivisorColumnOscillation

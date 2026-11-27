import Mathlib.FieldTheory.Finite.Basic
import Mathlib.Tactic.NormNum.Prime

namespace PowerSumPartners

private abbrev M := 5592405
private abbrev A := 7629217
private def divisor (i : Fin 6) : ℕ := [3, 7, 5, 17, 13, 241][i.val]!

private theorem residueCover : ∀ i : Fin 24, ∃ j : Fin 6,
    1 < divisor j ∧ divisor j ∣ M ∧
    Nat.ModEq (divisor j) (2^i.val) A ∧ ¬ Nat.ModEq M (2^i.val) (A + divisor j) := by
  decide

private theorem period (n : ℕ) : Nat.ModEq M (2^n) (2^(n%24)) := by
  have h := (show Nat.ModEq M (2^24) 1 by decide).pow (n/24)
  rw [← Nat.mod_add_div n 24, pow_add, pow_mul]
  simpa using h.mul_left (2^(n%24))

theorem noPrimePartner (p q n : ℕ) (hp : Nat.ModEq M p A) (hq : q.Prime) :
    p+q ≠ 2^n := by
  intro he
  obtain ⟨j, hj, hd, hpow, hexc⟩ := residueCover ⟨n % 24, by omega⟩
  have htot : Nat.ModEq (divisor j) (p+q) A := by
    rw [he]
    exact ((period n).of_dvd hd).trans hpow
  have h0 : Nat.ModEq (divisor j) q 0 :=
    (hp.of_dvd hd).add_left_cancel (by simpa using htot)
  have hqj : divisor j = q :=
    ((Nat.dvd_prime hq).mp (Nat.modEq_zero_iff_dvd.mp h0)).resolve_left (by omega)
  apply hexc
  calc 2^(n%24) ≡ 2^n [MOD M] := (period n).symm
    _ = p+q := he.symm
    _ ≡ A + divisor j [MOD M] := by rw [hqj]; exact hp.add_right q

theorem witnessPrime : Nat.Prime A := by norm_num [A]

theorem explicitCounterexample (q n : ℕ) (hq : q.Prime) : A+q ≠ 2^n :=
  noPrimePartner A q n (by rfl) hq

/-- Every odd c ≥ 5 has arbitrarily large odd composite partners. -/
theorem arbitrarilyLargeCompositePartner (c B : ℕ) (hc : 5 ≤ c) (ho : Odd c) :
    ∃ n d : ℕ, c+d = 2^n ∧ B < d ∧ c < d ∧ Odd d ∧ ¬d.Prime := by
  let a := c-2
  have ha : 1 < a := by dsimp [a]; omega
  have hao : Odd a := by obtain ⟨k,hk⟩ := ho; exact ⟨k-1, by dsimp [a]; omega⟩
  let t := B + 2*c + 1
  let n := 1 + a.totient*t
  have ht : 1 ≤ a.totient := Nat.totient_pos.mpr (by omega)
  have hn : B+2*c < n := by
    have h := Nat.mul_le_mul_right t ht
    dsimp [n, t] at *
    omega
  have hlarge := n.lt_two_pow_self
  let d := 2^n-c
  have hsum : c+d = 2^n := by dsimp [d]; omega
  have hpow : Nat.ModEq a (2^n) 2 := by
    have h := (Nat.ModEq.pow_totient hao.coprime_two_left).pow t
    simpa [n, pow_add, pow_mul] using h.mul_left 2
  have hca : Nat.ModEq a c 2 := Nat.modEq_sub (by omega : 2 ≤ c)
  have hd : a ∣ d := Nat.modEq_zero_iff_dvd.mp (hca.add_left_cancel
    (show Nat.ModEq a (c+d) (2+0) from hsum ▸ hpow))
  have hcodd := Nat.odd_iff.mp ho
  have heven : 2^n % 2 = 0 := by
    cases hh : n with
    | zero => omega
    | succ k => simp [pow_succ]
  have hlt : c < d := by omega
  refine ⟨n, d, hsum, by omega, hlt, Nat.odd_iff.mpr (by omega), ?_⟩
  intro hprime
  rcases (Nat.dvd_prime hprime).mp hd with h|h <;> dsimp [a] at * <;> omega

end PowerSumPartners

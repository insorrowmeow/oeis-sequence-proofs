import automata.Kernel
import Mathlib.FieldTheory.Finite.Basic

namespace Rule150Digits

private instance cyclicChar (m : ℕ) : CharP (Cyclic m) 2 :=
  ⟨fun n => by rw [AddMonoidAlgebra.natCast_def,Finsupp.single_eq_zero,
      ZMod.natCast_zmod_eq_zero_iff_dvd]⟩

/-- After a dyadic number of steps a single seed has shifts at plus and minus
    that exponent; collisions add in characteristic two. -/
theorem rule_frobenius (m d : ℕ) : (rule m)^(2^d) =
    point m (-(2:ZMod m)^d) + 1 + point m ((2:ZMod m)^d) := by
  unfold rule
  rw [add_pow_char_pow, add_pow_char_pow, one_pow]
  simp [point, AddMonoidAlgebra.single_pow, nsmul_eq_mul]

private theorem frobenius_fix {m d : ℕ} (h : (2:ZMod m)^d = 1) :
    (rule m)^(2^d) = rule m := by rw [rule_frobenius,h]; rfl

private theorem fold_rule {n m : ℕ} (h : m ∣ n) :
    AddMonoidAlgebra.mapDomainRingHom (ZMod 2) (ZMod.castHom h (ZMod m)) (rule n) = rule m := by
  let f := ZMod.castHom h (ZMod m)
  have hpt (u : ZMod n) :
      AddMonoidAlgebra.mapDomainRingHom (ZMod 2) f (point n u) = point m (f u) := by
    exact Finsupp.mapDomain_single
  change AddMonoidAlgebra.mapDomainRingHom (ZMod 2) f _ = _
  simp [rule, map_add, hpt]

private theorem repeat_period {A : Type*} [CommMonoid A] (x : A) (p : ℕ)
    (h : x*x^p = x) (k : ℕ) : x*x^(p*k) = x := by
  induction k with
  | zero => simp
  | succ k ih => rw [Nat.mul_succ,pow_add,← mul_assoc,ih,h]

/-- Any eventual period dividing the ring width forces its odd part to be a
    Mersenne number. The initial cell is the identity in the cyclic group algebra. -/
theorem mersenne_of_eventual_repeat {m s J : ℕ} (hm : 1 < m) (hodd : m%2=1)
    (h : (rule (2^s*m))^(J+2^s*m) = (rule (2^s*m))^J) :
    m = 2^(m.log2+1)-1 := by
  let n := 2^s*m
  have hdvd : m ∣ n := dvd_mul_left _ _
  have hr := congrArg (AddMonoidAlgebra.mapDomainRingHom (ZMod 2)
    (ZMod.castHom hdvd (ZMod m))) h
  change (AddMonoidAlgebra.mapDomainRingHom (ZMod 2) (ZMod.castHom hdvd (ZMod m))) _ = _ at hr
  simp only [map_pow] at hr
  rw [fold_rule hdvd] at hr
  let d := m.totient*(J+s+1)
  have hφ : 0 < m.totient := Nat.totient_pos.mpr (by omega)
  have hcop : Nat.Coprime 2 m :=
    Nat.prime_two.coprime_iff_not_dvd.mpr (by omega)
  have hbase : (2:ZMod m)^m.totient=1 := by
    have H := (ZMod.natCast_eq_natCast_iff _ _ _).mpr (Nat.ModEq.pow_totient hcop)
    simpa using H
  have hfix : (rule m)^(2^d)=rule m := by
    apply frobenius_fix
    simp [d,pow_mul,hbase]
  have hlarge : J+s+1 ≤ d := Nat.le_mul_of_pos_left _ hφ
  have hJ : J ≤ 2^d := le_trans (by omega : J ≤ d) (Nat.le_of_lt Nat.lt_two_pow_self)
  have hmain : rule m * (rule m)^n = rule m := by
    have H := congrArg (fun x : Cyclic m => x * (rule m)^(2^d-J)) hr
    change (rule m)^(J+n) * (rule m)^(2^d-J) = _ at H
    rw [← pow_add,show J+n+(2^d-J) = 2^d+n by omega,pow_add,hfix] at H
    change _ = (rule m)^J * (rule m)^(2^d-J) at H
    rwa [← pow_add,show J+(2^d-J)=2^d by omega,hfix] at H
  have H := repeat_period (rule m) n hmain (2^(d-s))
  have hexp : n*2^(d-s) = 2^d*m := by
    dsimp [n]
    rw [Nat.mul_right_comm,← pow_add,show s+(d-s)=d by omega]
  rw [hexp,pow_mul,hfix] at H
  apply mersenne_of_rule_relation hm hodd
  have h2 : (2 : Cyclic m) = 0 := by simpa using CharP.cast_eq_zero (Cyclic m) 2
  rw [mul_add,mul_one,H,← two_mul,h2,zero_mul]

end Rule150Digits

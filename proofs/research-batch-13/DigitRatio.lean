import Mathlib.Data.Nat.Digits
import Mathlib.Data.Nat.Factorization.Basic
import Mathlib.Data.Fintype.Prod
import Mathlib.Data.Fintype.Card
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.NormNum

namespace DigitRatio

/-- Evaluate the usual decimal digit list in base 100. -/
def spread (n : ℕ) : ℕ := Nat.ofDigits 100 (Nat.digits 10 n)

@[simp] theorem spread_zero : spread 0 = 0 := by simp [spread]

theorem spread_split (n : ℕ) : spread n = n%10 + 100*spread (n/10) := by
  by_cases hn : n = 0
  · simp [hn]
  · unfold spread
    rw [Nat.digits_eq_cons_digits_div (by decide : 1 < 10) hn]
    rfl

def drop (n : ℕ) : ℕ → ℕ
  | 0 => n
  | i+1 => drop n i / 10

def digit (n i : ℕ) := drop n i % 10

private theorem drop_shift (n i : ℕ) : drop (n/10) i = drop n (i+1) := by
  induction i with
  | zero => rfl
  | succ i ih => simp only [drop, ih]

private theorem digit_ext (n m : ℕ) (h : ∀ i, digit n i = digit m i) : n = m := by
  by_cases hzero : n = 0 ∧ m = 0
  · omega
  have hd : n%10 = m%10 := h 0
  have h' : ∀ i, digit (n/10) i = digit (m/10) i := by
    intro i
    simpa only [digit,drop_shift] using h (i+1)
  have := digit_ext (n/10) (m/10) h'
  omega
termination_by n+m
decreasing_by omega

private theorem strip_equation (q n m : ℕ) (hn : spread n=q*n) (hm : spread m=q*m)
    (i : ℕ) (below : ∀ j < i, digit n j = digit m j) :
    (10:ℤ)^i*((spread (drop m i) : ℤ)-(spread (drop n i) : ℤ)) =
      (q:ℤ)*((drop m i:ℤ)-(drop n i:ℤ)) := by
  induction i with
  | zero => simp [drop, hn, hm, mul_sub]
  | succ i ih =>
    have prev := ih (fun j hj => below j (by omega))
    let u := drop n i
    let v := drop m i
    have rem : u%10 = v%10 := below i (by omega)
    have dec (x : ℕ) : (x:ℤ) = (x%10:ℕ) + 10*(x/10:ℕ) := by omega
    have sc (x : ℕ) : (spread x:ℤ) = (x%10:ℕ) + 100*(spread (x/10):ℤ) := by
      exact_mod_cast spread_split x
    change (10:ℤ)^i*((spread v:ℤ)-(spread u:ℤ)) = (q:ℤ)*((v:ℤ)-(u:ℤ)) at prev
    rw [sc v,sc u,dec v,dec u,rem] at prev
    change (10:ℤ)^(i+1)*((spread (v/10):ℤ)-(spread (u/10):ℤ)) =
      (q:ℤ)*((v/10:ℕ)-(u/10:ℕ):ℤ)
    rw [pow_succ]
    linarith

private theorem detect_prime {q u v i p : ℕ} (hq : 0 < q) (huv : u ≤ v)
    (hval : (10:ℤ)^i*((spread v:ℤ)-(spread u:ℤ)) = (q:ℤ)*((v:ℤ)-(u:ℤ)))
    (hprime : p=2 ∨ p=5) (hd : (v%10)%p ≠ (u%10)%p) :
    q.factorization p = i := by
  have huv' : u < v := lt_of_le_of_ne huv (fun h => hd (h ▸ rfl))
  have hleft : 0 < (10:ℤ)^i := by positivity
  have hright : (0:ℤ) < (q:ℤ)*((v:ℤ)-(u:ℤ)) := by
    apply mul_pos <;> omega
  have hs : spread u < spread v := by
    rw [← hval] at hright
    exact_mod_cast sub_pos.mp (pos_of_mul_pos_right hright hleft.le)
  have hnat : 10^i*(spread v-spread u) = q*(v-u) := by
    exact_mod_cast (show (10:ℤ)^i*((spread v-spread u:ℕ):ℤ) =
                            (q:ℤ)*((v-u:ℕ):ℤ) by simpa [Nat.cast_sub hs.le,Nat.cast_sub huv] using hval)
  have hden : ¬p ∣ v-u := by rcases hprime with rfl|rfl <;> omega
  have hnum : ¬p ∣ spread v - spread u := by
    have hv := spread_split v
    have hu := spread_split u
    rcases hprime with rfl|rfl <;> omega
  have he := congrArg (fun z : ℕ => z.factorization p) hnat
  have h10 : (10:ℕ).factorization p = 1 := by
    rw [show (10:ℕ)=2*5 by decide, Nat.factorization_mul (by decide) (by decide),
       Nat.prime_two.factorization, (by decide : Nat.Prime 5).factorization, Finsupp.add_apply]
    rcases hprime with rfl|rfl <;> norm_num [Finsupp.single_apply]
  simp only [Nat.factorization_mul (pow_ne_zero _ (by decide : 10 ≠ 0))
        (by omega : spread v-spread u ≠ 0),
      Nat.factorization_mul hq.ne' (by omega : v-u ≠ 0), Finsupp.add_apply,
      Nat.factorization_pow, Finsupp.smul_apply, smul_eq_mul, h10,
      Nat.factorization_eq_zero_of_not_dvd hnum, Nat.factorization_eq_zero_of_not_dvd hden,
      mul_one, add_zero] at he
  exact he.symm

def code (q n : ℕ) : Fin 2 × Fin 5 :=
  (⟨digit n (q.factorization 2) % 2, by omega⟩,
   ⟨digit n (q.factorization 5) % 5, by omega⟩)

private theorem drop_mono {n m : ℕ} (hnm : n ≤ m) (i : ℕ) : drop n i ≤ drop m i := by
  induction i with
  | zero => exact hnm
  | succ i ih => exact Nat.div_le_div_right ih

private theorem code_ordered (q n m : ℕ) (hq : 0<q) (hnm : n ≤ m)
    (hn : spread n=q*n) (hm : spread m=q*m) (hc : code q n=code q m) : n=m := by
  by_contra hne
  have hex : ∃ i, digit n i ≠ digit m i := by
    by_contra! neg
    exact hne (digit_ext n m neg)
  let i := Nat.find hex
  have hi : digit n i ≠ digit m i := Nat.find_spec hex
  have he := strip_equation q n m hn hm i (fun j hj => by simpa using Nat.find_min hex hj)
  have h₂ := congrArg (fun t : Fin 2 × Fin 5 => t.1.val) hc
  have h₅ := congrArg (fun t : Fin 2 × Fin 5 => t.2.val) hc
  change digit n (q.factorization 2) % 2 = digit m (q.factorization 2) % 2 at h₂
  change digit n (q.factorization 5) % 5 = digit m (q.factorization 5) % 5 at h₅
  have du : digit n i < 10 := Nat.mod_lt _ (by decide)
  have dv : digit m i < 10 := Nat.mod_lt _ (by decide)
  by_cases e : digit m i % 2 ≠ digit n i % 2
  · have h := detect_prime hq (drop_mono hnm i) he (Or.inl rfl) e
    rw [h] at h₂
    exact e h₂.symm
  · have e5 : digit m i % 5 ≠ digit n i % 5 := by omega
    have h := detect_prime hq (drop_mono hnm i) he (Or.inr rfl) e5
    rw [h] at h₅
    exact e5 h₅.symm

/-- Every finite set of distinct positive decimal producers has at most nine members. -/
theorem at_most_nine (q : ℕ) (hq : 0<q) (S : Finset ℕ)
    (hS : ∀ n ∈ S, 0<n ∧ spread n=q*n) : S.card ≤ 9 := by
  let T := insert 0 S
  have hT {n : ℕ} (hn : n ∈ T) : spread n=q*n := by
    rcases Finset.mem_insert.mp hn with rfl | h
    · simp
    · exact (hS n h).2
  have hinj : (T : Set ℕ).InjOn (code q) := by
    intro n hn m hm h
    rcases le_total n m with hnm|hmn
    · exact code_ordered q n m hq hnm (hT hn) (hT hm) h
    · exact (code_ordered q m n hq hmn (hT hm) (hT hn) h.symm).symm
  have hcard := Finset.card_le_card_of_injOn (t := Finset.univ) (code q)
    (fun _ _ => Finset.mem_univ _) hinj
  have hz : 0 ∉ S := fun h => (Nat.lt_irrefl 0) (hS 0 h).1
  simp [T, Finset.card_insert_of_not_mem hz] at hcard
  omega

/-- A single finite set contains exactly the positive producers for this multiplier. -/
theorem all_producers (q : ℕ) (hq : 0 < q) :
    ∃ S : Finset ℕ, (∀ n, n ∈ S ↔ 0 < n ∧ spread n = q * n) ∧ S.card ≤ 9 := by
  classical
  let P := {n : ℕ // 0 < n ∧ spread n = q * n}
  have hinj : Function.Injective (fun n : P => code q n.val) := by
    intro n m h
    apply Subtype.ext
    rcases le_total n.val m.val with hnm | hmn
    · exact code_ordered q _ _ hq hnm n.property.2 m.property.2 h
    · exact (code_ordered q _ _ hq hmn m.property.2 n.property.2 h.symm).symm
  letI : Finite P := Finite.of_injective _ hinj
  letI : Fintype P := Fintype.ofFinite P
  let S : Finset ℕ := Finset.univ.image (fun n : P => n.val)
  have hS (n : ℕ) : n ∈ S ↔ 0 < n ∧ spread n = q * n := by
    constructor
    · intro h
      obtain ⟨a, _, ha⟩ := Finset.mem_image.mp h
      exact ha ▸ a.property
    · intro h
      exact Finset.mem_image.mpr ⟨⟨n, h⟩, Finset.mem_univ _, rfl⟩
  exact ⟨S, hS, at_most_nine q hq S (fun n hn => (hS n).mp hn)⟩

end DigitRatio

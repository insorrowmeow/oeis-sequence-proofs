import Mathlib.Data.ZMod.Basic
import Mathlib.Data.Fintype.Card
import Mathlib.Tactic.Ring
import Mathlib.Data.Nat.Factorization.Basic

namespace Murthy

variable {m : ℕ} [NeZero m]

/-- Possible sums of optional addends. -/
def sums (w : ℕ → ZMod m) : ℕ → Finset (ZMod m)
  | 0 => {0}
  | j + 1 => sums w j ∪ (sums w j).image (· + w j)

omit [NeZero m] in
private theorem zero_mem (w : ℕ → ZMod m) (k : ℕ) : 0 ∈ sums w k := by
  induction k with
  | zero => simp [sums]
  | succ k ih => exact Finset.mem_union_left _ ih

/-- A proper nonempty set grows when optionally translated by a unit. -/
private theorem grow (s : Finset (ZMod m)) (hs : s.Nonempty)
    (hproper : s ≠ Finset.univ) (u : (ZMod m)ˣ) :
    s.card < (s ∪ s.image (· + (u : ZMod m))).card := by
  apply Finset.card_lt_card
  refine ⟨Finset.subset_union_left, ?_⟩
  intro h
  have closed (x : ZMod m) (hx : x ∈ s) : x + u ∈ s :=
    h (Finset.mem_union_right _ (Finset.mem_image.mpr ⟨x, hx, rfl⟩))
  obtain ⟨a, ha⟩ := hs
  have orbit (k : ℕ) : a + (k : ZMod m) * u ∈ s := by
    induction k with
    | zero => simpa using ha
    | succ k ih => simpa [Nat.cast_succ, add_mul, add_assoc] using closed _ ih
  apply hproper
  apply Finset.eq_univ_of_forall
  intro x
  let z : ZMod m := (x-a) * ↑(u⁻¹)
  have mem := orbit z.val
  rw [ZMod.natCast_zmod_val] at mem
  simpa [z, mul_assoc] using mem

private theorem size_bound (w : ℕ → ZMod m) (hw : ∀ i, IsUnit (w i))
    (k : ℕ) : min (k+1) m ≤ (sums w k).card := by
  induction k with
  | zero => simp [sums]
  | succ k ih =>
    by_cases h : sums w k = Finset.univ
    · have full : sums w (k+1) = Finset.univ := Finset.eq_univ_of_forall fun x => Finset.mem_union_left _ (by rw [h]; exact Finset.mem_univ x)
      rw [full, Finset.card_univ, ZMod.card]
      exact min_le_right _ _
    · obtain ⟨u, hu⟩ := hw k
      have g := grow (sums w k) ⟨0, zero_mem w k⟩ h u
      rw [hu] at g
      change _ < (sums w (k+1)).card at g
      omega

/-- Any m-1 optional unit addends reach every residue in Z/mZ. -/
theorem all_residues (w : ℕ → ZMod m) (hw : ∀ i, IsUnit (w i))
    (k : ℕ) (hk : m ≤ k+1) : sums w k = Finset.univ := by
  apply Finset.eq_univ_of_card
  have h := size_bound w hw k
  rw [min_eq_right hk] at h
  have h' := (sums w k).card_le_univ
  rw [ZMod.card] at h' ⊢
  omega

/-- Application to arbitrary decimal positions starting at exponent e. -/
theorem decimal_residues (e k : ℕ) (hm : Nat.Coprime 10 m) (hk : m ≤ k+1) :
    sums (fun j => ((10 : ZMod m) ^ (e+j))) k = Finset.univ := by
  apply all_residues _ _ _ hk
  intro i
  have unit : IsUnit (10 : ZMod m) := (ZMod.isUnit_iff_coprime 10 m).mpr hm
  exact unit.pow _

/-- Offsets that can be added without carries, by optional increments in
the k columns from e through e+k-1. -/
inductive Offset (e : ℕ) : ℕ → ℕ → Prop where
  | zero : Offset e 0 0
  | skip {k x} : Offset e k x → Offset e (k+1) x
  | take {k x} : Offset e k x → Offset e (k+1) (x+10^(e+k))

omit [NeZero m] in
private theorem natural_lift (e k : ℕ) (r : ZMod m)
    (h : r ∈ sums (fun j => ((10 : ZMod m) ^ (e+j))) k) :
    ∃ x : ℕ, Offset e k x ∧ (x : ZMod m) = r := by
  induction k generalizing r with
  | zero =>
    simp [sums] at h
    exact ⟨0, .zero, by simp [h]⟩
  | succ k ih =>
    rcases Finset.mem_union.mp h with h | h
    · obtain ⟨x, hx, he⟩ := ih r h
      exact ⟨x, .skip hx, he⟩
    · obtain ⟨v,hv,rfl⟩ := Finset.mem_image.mp h
      obtain ⟨x,hx,he⟩ := ih v hv
      exact ⟨_, .take hx, by simp [he]⟩

private theorem lower (B e : ℕ) : ∃ x, Offset 0 e x ∧ 2^e ∣ B+x := by
  induction e with
  | zero => exact ⟨0, .zero, by simp⟩
  | succ e ih =>
    obtain ⟨x,hx,q,hq⟩ := ih
    rcases Nat.even_or_odd q with ⟨t,ht⟩ | ⟨t,ht⟩
    · refine ⟨x, .skip hx, t, ?_⟩
      rw [hq,ht,pow_succ]
      ring
    · obtain ⟨a, ha⟩ := (show Odd (5:ℕ) from ⟨2,rfl⟩).pow (n := e)
      refine ⟨_, .take hx, t+a+1, ?_⟩
      rw [zero_add, ← Nat.add_assoc, hq, ht]
      have h10 : (10:ℕ)^e = 2^e * 5^e := by rw [← mul_pow]; rfl
      rw [h10, ha, pow_succ]
      ring

private theorem offset_dvd {e k x : ℕ} (h : Offset e k x) : 2^e ∣ x := by
  induction h with
  | zero => exact dvd_zero _
  | skip _ ih => exact ih
  | @take k x _ ih =>
    apply dvd_add ih
    rw [pow_add]
    apply dvd_mul_of_dvd_left _ _
    exact pow_dvd_pow_of_dvd (by decide : 2 ∣ 10) e

private theorem join {e k x y : ℕ} (hx : Offset 0 e x) (hy : Offset e k y) :
    Offset 0 (e+k) (x+y) := by
  induction hy with
  | zero => simpa using hx
  | skip h ih => exact .skip ih
  | @take k y h ih => simpa [Nat.add_assoc] using (Offset.take ih)

/-- If the constrained digit pairs are consecutive, every base value B
can be repaired with one optional increment in each of its n-1 low columns. -/
theorem decimal_repair (n B : ℕ) (hn : n ≠ 0) (h5 : ¬ 5 ∣ n) :
    ∃ x, Offset 0 (n-1) x ∧ n ∣ B+x := by
  obtain ⟨e,m,hm,h⟩ := Nat.exists_eq_two_pow_mul_odd hn
  have mpos : 0 < m := by by_contra! hz; simp [show m = 0 by omega] at h; omega
  letI : NeZero m := ⟨by omega⟩
  have cop2 : Nat.Coprime 2 m := Nat.coprime_two_left.mpr hm
  have cop5 : Nat.Coprime 5 m := (show Nat.Prime 5 from by decide).coprime_iff_not_dvd.mpr (fun d => h5 (h ▸ dvd_mul_of_dvd_right d _))
  have cop10 : Nat.Coprime 10 m := Nat.Coprime.mul cop2 cop5
  have ep (a : ℕ) : a+1 ≤ 2^a := by
    induction a with
    | zero => decide
    | succ a ih => rw [pow_succ]; omega
  have eg := ep e
  have room : e+m ≤ n := by
    have z := Nat.mul_le_mul_right m eg
    rw [Nat.add_mul, Nat.one_mul] at z
    have := Nat.le_mul_of_pos_right e mpos
    omega
  let k := n-1-e
  have hk : m ≤ k+1 := by dsimp [k]; omega
  obtain ⟨x,hx,hlow⟩ := lower B e
  have hall := decimal_residues (m:=m) e k cop10 hk
  have target : -((B+x : ℕ) : ZMod m) ∈ sums (fun j => (10 : ZMod m)^(e+j)) k := by
    rw [hall]; exact Finset.mem_univ _
  obtain ⟨y,hy,he⟩ := natural_lift e k _ target
  have high : m ∣ (B+x)+y := by
    apply (ZMod.natCast_zmod_eq_zero_iff_dvd _ _).mp
    rw [Nat.cast_add, he, add_neg_cancel]
  have low : 2^e ∣ (B+x)+y := dvd_add hlow (offset_dvd hy)
  refine ⟨x+y, ?_, ?_⟩
  · have hj := join hx hy
    have kl : e+k=n-1 := by dsimp [k]; omega
    rwa [kl] at hj
  · rw [h, ← Nat.add_assoc]
    exact (cop2.pow_left e).mul_dvd_of_dvd_of_dvd low high

/-- Prime digits or composite digits, selected according to the position counted
from the left. The leading 1 is supplied separately. -/
def permitted (i d : ℕ) : Prop :=
  if i.Prime then d ∈ [2,3,5,7] else d ∈ [4,6,8,9]

/-- Value of k low decimal columns of an n-digit word. -/
inductive Body (n : ℕ) : ℕ → ℕ → Prop where
  | nil : Body n 0 0
  | more {k v d} : Body n k v → permitted (n-k) d →
      Body n (k+1) (v + d*10^k)

/-- An admissible multiple with leading digit 1 and exactly n digits. -/
def Admissible (n : ℕ) : Prop :=
  ∃ y, Body n (n-1) y ∧ n ∣ 10^(n-1)+y

private def lowDigit (i : ℕ) := if i.Prime then 2 else 8

private def baseValue (n : ℕ) : ℕ → ℕ
  | 0 => 0
  | k+1 => baseValue n k + lowDigit (n-k)*10^k

private theorem base_offset (n k x : ℕ) (h : Offset 0 k x) :
    Body n k (baseValue n k + x) := by
  induction h with
  | zero => exact .nil
  | @skip k x _ ih =>
    have h0 : permitted (n-k) (lowDigit (n-k)) := by
      by_cases hp : (n-k).Prime <;> simp [permitted,lowDigit,hp]
    simpa [baseValue,Nat.add_right_comm] using Body.more ih h0
  | @take k x _ ih =>
    have h1 : permitted (n-k) (lowDigit (n-k)+1) := by
      by_cases hp : (n-k).Prime <;> simp [permitted,lowDigit,hp]
    have h := Body.more ih h1
    convert h using 1
    simp [baseValue, Nat.add_mul]
    omega

private theorem five_last {n k y : ℕ} (h : Body n k y) (hk : 0 < k) :
    ∃ d, permitted n d ∧ y % 5 = d % 5 := by
  induction h with
  | nil => omega
  | @more k v d h0 hd ih =>
    cases k with
    | zero =>
      cases h0
      exact ⟨d,by simpa using hd,by simp⟩
    | succ k =>
      obtain ⟨a,ha,he⟩ := ih (by omega)
      refine ⟨a,ha,?_⟩
      have hv : 5 ∣ d * 10^(k+1) := by
        rw [pow_succ,← Nat.mul_assoc]
        exact dvd_mul_of_dvd_right (by decide : 5 ∣ 10) _
      simpa [Nat.add_mod, Nat.mod_eq_zero_of_dvd hv] using he

/-- Murthy's exact nonzero criterion, simultaneously for A113572 and A113573. -/
theorem murthy_nonzero (n : ℕ) (hn : 0 < n) :
    Admissible n ↔ ¬ 5 ∣ n ∨ n = 5 := by
  constructor
  · intro h
    by_contra! hbad
    obtain ⟨h5,hne⟩ := hbad
    obtain ⟨y,hy,hdiv⟩ := h
    have hprime : ¬ n.Prime := fun hp =>
      hne ((Nat.prime_dvd_prime_iff_eq (by decide : Nat.Prime 5) hp).mp h5).symm
    have n5 := Nat.le_of_dvd hn h5
    obtain ⟨d,hd,he⟩ := five_last hy (by omega)
    have hp : 5 ∣ 10^(n-1) :=
      (by decide : 5 ∣ 10).trans (dvd_pow_self _ (by omega : n-1 ≠ 0))
    have hdy : 5 ∣ y := (Nat.dvd_add_iff_right hp).mpr (h5.trans hdiv)
    rw [Nat.mod_eq_zero_of_dvd hdy] at he
    simp [permitted,hprime] at hd
    rcases hd with rfl | rfl | rfl | rfl <;> omega
  · rintro (h5 | rfl)
    · obtain ⟨x,hx,hdiv⟩ := decimal_repair n (10^(n-1)+baseValue n (n-1)) (by omega) h5
      exact ⟨_,base_offset n _ _ hx, by simpa [Nat.add_assoc] using hdiv⟩
    · refine ⟨2245,?_,by decide⟩
      have h1 := Body.more (n:=5) Body.nil (d:=5) (by unfold permitted; decide : permitted (5-0) 5)
      have h2 := Body.more h1 (d:=4) (by unfold permitted; decide : permitted (5-1) 4)
      have h3 := Body.more h2 (d:=2) (by unfold permitted; decide : permitted (5-2) 2)
      exact Body.more h3 (d:=2) (by unfold permitted; decide : permitted (5-3) 2)

#print axioms murthy_nonzero
end Murthy


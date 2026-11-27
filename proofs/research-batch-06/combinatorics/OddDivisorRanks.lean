import Mathlib.Data.Nat.Factorization.Basic
import Mathlib.Order.Interval.Finset.Nat
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.Ring

namespace OddDivisorRanks

def b (k : ℕ) : ℕ → ℤ
  | 0 => k
  | r+1 => 2*b k r - 2^r

def Member (k : ℕ) : Prop := 0<k ∧ Even k ∧ (k:ℤ) ∣ b k (k.log2+1)

theorem closed_form (k h : ℕ) :
    b k (h+1) = 2^(h+1)*(k:ℤ) - (h+1 : ℤ)*2^h := by
  induction h with
  | zero => simp [b]
  | succ h ih =>
    rw [b,ih,pow_succ (2:ℤ) (h+1),pow_succ (2:ℤ) h]
    push_cast
    ring

theorem recurrence_criterion {q v h : ℕ} (hq : Odd q) (hv : v≤h) :
    (((2^v*q:ℕ):ℤ) ∣ b (2^v*q) (h+1)) ↔ q ∣ h+1 := by
  have hmul : ((2^v*q:ℕ):ℤ) ∣ 2^(h+1)*((2^v*q:ℕ):ℤ) := dvd_mul_left _ _
  rw [closed_form, dvd_sub_right hmul]
  norm_cast
  constructor
  · intro H
    have hq' : q ∣ (h+1)*2^h := dvd_trans (dvd_mul_left _ _) H
    exact (hq.coprime_two_right.pow_right h).dvd_of_dvd_mul_right hq'
  · intro H
    exact Nat.mul_comm (h+1) (2^h) ▸ Nat.mul_dvd_mul (pow_dvd_pow 2 hv) H

private theorem log_scaled {q : ℕ} (hq : 0<q) (v : ℕ) :
    (2^v*q).log2 = v+q.log2 := by
  have hp : 0<(2:ℕ)^v*q := Nat.mul_pos (Nat.two_pow_pos v) hq
  apply Nat.le_antisymm
  · have H : (2^v*q).log2 < v+q.log2+1 := by
      apply (Nat.log2_lt hp.ne').mpr
      rw [Nat.add_assoc,pow_add]
      exact Nat.mul_lt_mul_of_pos_left Nat.lt_log2_self (Nat.two_pow_pos _)
    omega
  · apply (Nat.le_log2 hp.ne').mpr
    simpa [pow_add] using Nat.mul_le_mul_left (2^v) (Nat.log2_self_le hq.ne')

private theorem odd_pos {q : ℕ} (hq : Odd q) : 0<q := by obtain ⟨a,ha⟩ := hq; omega

theorem member_iff {q v : ℕ} (hq : Odd q) (hv : 0<v) :
    Member (2^v*q) ↔ q ∣ v+q.log2+1 := by
  have hpos := Nat.mul_pos (Nat.two_pow_pos v) (odd_pos hq)
  have hev : Even (2^v*q) := by
    apply even_iff_two_dvd.mpr
    exact dvd_mul_of_dvd_left (dvd_pow_self 2 hv.ne') _
  unfold Member
  rw [log_scaled (odd_pos hq), recurrence_criterion hq (by omega)]
  simp [hpos,hev]

private theorem five_bound (r : ℕ) (hr : 5≤r) : r^2 < 2^r := by
  induction r,hr using Nat.le_induction with
  | base => decide
  | succ r hr ih =>
    rw [pow_succ 2 r]
    nlinarith [Nat.mul_self_le_mul_self hr]

/-- Containment in A082662, in the equivalent integer form without square roots. -/
theorem contained {q v : ℕ} (hq : Odd q) (hv : 0<v) (H : Member (2^v*q)) :
    q^2 < 2*(2^v*q) := by
  let k := 2^v*q
  let r := v+q.log2+1
  have hqpos := odd_pos hq
  have hd : q ∣ r := (member_iff hq hv).mp H
  have hle : q ≤ r := Nat.le_of_dvd (by dsimp [r]; omega) hd
  have hlow : 2^r ≤ 2*k := by
    change 2^(v+q.log2+1) ≤ 2*(2^v*q)
    rw [pow_succ',pow_add]
    exact Nat.mul_le_mul_left 2 (Nat.mul_le_mul_left _ (Nat.log2_self_le hqpos.ne'))
  by_cases hg : 5≤r
  · exact lt_of_lt_of_le (lt_of_le_of_lt (Nat.pow_le_pow_left hle 2) (five_bound _ hg)) hlow
  · obtain ⟨a,ha⟩ := hq
    have h : q=1 ∨ q=3 := by omega
    obtain h|h := h
    · rw [h]
      have := Nat.two_pow_pos v
      simp
      omega
    · have h2 : (2:ℕ) ≤ 2^v := Nat.pow_le_pow_right (by decide : 0<2) hv
      rw [h]
      norm_num
      omega

private theorem bit_length_bound (h : ℕ) (hh : 2≤h) : h+1 < 2^h := by
  induction h,hh using Nat.le_induction with
  | base => decide
  | succ h hh ih => rw [pow_succ]; omega

private theorem odd_divisor_small {q h : ℕ} (hq : Odd q) (hd : q∣h+1) (hpos : 0<h) :
    q < 2^h := by
  have hle := Nat.le_of_dvd (by omega : 0<h+1) hd
  obtain ⟨a,ha⟩ := hq
  by_cases h1 : h=1
  · subst h; norm_num at *; omega
  · have hh : 2≤h := by omega
    have hh' := bit_length_bound _ hh
    omega

/-- The normalised block of bit length h+1 contains exactly one even
    number with each prescribed odd divisor q of h+1 as its odd part. -/
theorem unique_in_block {q h : ℕ} (hq : Odd q) (hpos : 0<h) :
    q ∣ h+1 ↔ ∃! v : ℕ, 0<v ∧ (2^v*q).log2=h ∧ Member (2^v*q) := by
  have hlog := log_scaled (odd_pos hq)
  constructor
  · intro hd
    have hsmall := (Nat.log2_lt (odd_pos hq).ne').mpr (odd_divisor_small hq hd hpos)
    let v := h-q.log2
    have hv : 0<v := by dsimp [v]; omega
    have he : v+q.log2=h := by dsimp [v]; omega
    refine ⟨v,⟨hv,by rw [hlog,he],(member_iff hq hv).mpr (by rwa [he])⟩,?_⟩
    rintro w ⟨_,hw,_⟩
    rw [hlog] at hw
    omega
  · rintro ⟨v,⟨hv,hvlog,hm⟩,_⟩
    rw [hlog] at hvlog
    simpa [hvlog] using (member_iff hq hv).mp hm

private instance (k : ℕ) : Decidable (Member k) := by unfold Member; infer_instance

def oddDivisors (r : ℕ) := (Finset.Icc 1 r).filter fun q => Odd q ∧ q ∣ r

def block (h : ℕ) := (Finset.Ico (2^h) (2^(h+1))).filter Member

private theorem v_two {q : ℕ} (v : ℕ) (hq : Odd q) :
    (2^v*q).factorization 2=v := by
  have h0 := (odd_pos hq).ne'
  obtain ⟨b,hb⟩ := hq
  have hn : ¬2 ∣ q := by omega
  simp [Nat.factorization_mul (pow_ne_zero v (by decide : (2:ℕ) ≠ 0)) h0,
    Nat.factorization_eq_zero_of_not_dvd hn,Nat.Prime.factorization_pow Nat.prime_two]

private theorem in_block_iff {h k : ℕ} :
    k ∈ block h ↔ k.log2=h ∧ Member k := by
  simp only [block,Finset.mem_filter,Finset.mem_Ico]
  constructor
  · rintro ⟨⟨hl,hu⟩,hm⟩
    have hpos := hm.1
    exact ⟨by have := (Nat.le_log2 hpos.ne').mpr hl
              have := (Nat.log2_lt hpos.ne').mpr hu
              omega,hm⟩
  · rintro ⟨hl,hm⟩
    exact ⟨⟨hl ▸ Nat.log2_self_le hm.1.ne',hl ▸ Nat.lt_log2_self⟩,hm⟩

theorem block_card {h : ℕ} (hpos : 0<h) :
    (oddDivisors (h+1)).card=(block h).card := by
  let f := fun q : ℕ => 2^(h-q.log2)*q
  apply Finset.card_bij (fun q _ => f q)
  · intro q hq
    obtain ⟨_,ho,hd⟩ := Finset.mem_filter.mp hq
    obtain ⟨v,⟨_,hv,hm⟩,_⟩ := (unique_in_block ho hpos).mp hd
    have hl := log_scaled (odd_pos ho) v
    have hfv : h-q.log2=v := by omega
    exact in_block_iff.mpr (by simpa [f,hfv] using And.intro hv hm)
  · intro a ha b hb hab
    obtain ⟨_,ha',_⟩ := Finset.mem_filter.mp ha
    obtain ⟨_,hb',_⟩ := Finset.mem_filter.mp hb
    have he := congrArg (fun x : ℕ => x.factorization 2) hab
    change (2^(h-a.log2)*a).factorization 2 = (2^(h-b.log2)*b).factorization 2 at he
    rw [v_two _ ha',v_two _ hb'] at he
    dsimp [f] at hab
    rw [he] at hab
    exact Nat.eq_of_mul_eq_mul_left (Nat.two_pow_pos _) hab
  · intro k hk
    obtain ⟨hl,hm⟩ := in_block_iff.mp hk
    obtain ⟨v,q,hq,he⟩ := Nat.exists_eq_two_pow_mul_odd hm.1.ne'
    have hv : 0<v := by
      by_contra! hzero
      rw [show v=0 by omega,pow_zero,one_mul] at he
      have hev := hm.2.1
      rw [he] at hev
      exact (Nat.not_even_iff_odd.mpr hq) hev
    rw [he,log_scaled (odd_pos hq)] at hl
    rw [he] at hm
    have hd := (member_iff hq hv).mp hm
    rw [hl] at hd
    have hbound := Nat.le_of_dvd (by omega : 0<h+1) hd
    refine ⟨q,Finset.mem_filter.mpr ⟨Finset.mem_Icc.mpr ⟨odd_pos hq,hbound⟩,hq,hd⟩,?_⟩
    dsimp [f]
    rw [show h-q.log2=v by omega,← he]

def below (bound : ℕ) := (Finset.range bound).filter Member

theorem power_member {n : ℕ} (hn : 0<n) : Member (2^n) := by
  simpa using (member_iff (q:=1) (by decide) hn).mpr (one_dvd _)

/-- The endpoint is present and its one-based rank is exactly A060831(n). -/
theorem rank_of_power {n : ℕ} (hn : 0<n) :
    Member (2^n) ∧ (below (2^n)).card + 1 =
      ∑ i ∈ Finset.range n, (oddDivisors (i+1)).card := by
  refine ⟨power_member hn,?_⟩
  induction n,hn using Nat.le_induction with
  | base => decide
  | succ n hn ih =>
    have hinc : (2:ℕ)^n ≤ 2^(n+1) := Nat.pow_le_pow_right (by decide) (by omega)
    have hset : below (2^(n+1)) = below (2^n) ∪ block n := by
      ext k
      simp [below,block]
      by_cases hl : k < 2^n
      · simp [hl,lt_of_lt_of_le hl hinc]
      · simp [hl,Nat.le_of_not_lt hl]
    have hdis : Disjoint (below (2^n)) (block n) := by
      rw [Finset.disjoint_left]
      intro k ha hb
      simp only [below,block,Finset.mem_filter,Finset.mem_range,Finset.mem_Ico] at ha hb
      omega
    rw [hset,Finset.card_union_of_disjoint hdis,Finset.sum_range_succ,block_card hn]
    omega

/-- Every member belongs to A082662, using the canonical odd part of k. -/
theorem all_members_contained {k : ℕ} (hk : Member k) :
    (k / 2^(k.factorization 2))^2 < 2*k := by
  obtain ⟨v,q,ho,he⟩ := Nat.exists_eq_two_pow_mul_odd hk.1.ne'
  have hv : 0<v := by
    by_contra! hzero
    rw [show v=0 by omega,pow_zero,one_mul] at he
    have hev := hk.2.1
    rw [he] at hev
    exact (Nat.not_even_iff_odd.mpr ho) hev
  rw [he] at hk ⊢
  rw [v_two _ ho,Nat.mul_div_cancel_left _ (Nat.two_pow_pos _)]
  exact contained ho hv hk

end OddDivisorRanks

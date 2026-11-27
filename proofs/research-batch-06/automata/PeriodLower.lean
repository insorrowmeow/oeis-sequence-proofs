import automata.Khrabrov

namespace Rule150Digits

/-- Before the two expanding ends meet on the ring, the outermost bit is one
    and the interval between the two ends on the opposite side is zero. -/
theorem light_cone (n t : ℕ) (ht : 2*t<n) :
    ((rule n)^t) (t : ZMod n) = 1 ∧
      ∀ j, t<j → j+t<n → ((rule n)^t) (j : ZMod n) = 0 := by
  induction t with
  | zero =>
    simp only [pow_zero,Nat.cast_zero,Nat.zero_add,Nat.add_zero]
    change Finsupp.single (0:ZMod n) (1:ZMod 2) 0 = 1 ∧ _
    refine ⟨Finsupp.single_eq_same,?_⟩
    intro j hj hlt
    change Finsupp.single (0:ZMod n) (1:ZMod 2) (j:ZMod n)=0
    have hne : (j:ZMod n) ≠ 0 := by
      rw [Ne,ZMod.natCast_zmod_eq_zero_iff_dvd]
      exact Nat.not_dvd_of_pos_of_lt hj hlt
    simp [Finsupp.single_apply,hne.symm]
  | succ t ih =>
    obtain ⟨he,hgap⟩ := ih (by omega)
    rw [pow_succ']
    constructor
    · rw [automaton_coeff,he,hgap (t+1) (by omega) (by omega),
        hgap (t+2) (by omega) (by omega),add_zero,add_zero]
    · intro j hj hlt
      obtain _|q := j
      · omega
      rw [automaton_coeff,hgap q (by omega) (by omega),
        hgap (q+1) (by omega) (by omega),hgap (q+2) (by omega) (by omega),add_zero,add_zero]

/-- No short positive time shift can repeat the state at t if the light cone
    of the later row has not wrapped around. -/
theorem no_short_repeat {n t d : ℕ} (hd : 0<d) (h : 2*(t+d)<n) :
    (rule n)^(t+d) ≠ (rule n)^t := by
  intro he
  have hrow := congrArg (fun f : Cyclic n => f ((t+d : ℕ) : ZMod n)) he
  have hnew := (light_cone n (t+d) h).1
  have hold := (light_cone n t (by omega)).2 (t+d) (by omega) (by omega)
  change ((rule n)^(t+d)) _ = ((rule n)^t) _ at hrow
  rw [hnew,hold] at hrow
  exact one_ne_zero hrow

private def site (p m : ℕ) (u : ℤ) : ZMod (p*(2*m)) := (p:ZMod (p*(2*m)))*u

private noncomputable def mark (p m : ℕ) (u : ℤ) : Cyclic (p*(2*m)) :=
  point _ (site p m u)

private theorem mark_mul (p m : ℕ) (a b : ℤ) :
    mark p m a * mark p m b = mark p m (a+b) := by
  simp [mark,point,site,AddMonoidAlgebra.single_mul_single,mul_add]

private theorem mark_hit (p m : ℕ) : mark p m 1 (site p m 1) = 1 :=
  Finsupp.single_eq_same

private theorem mark_miss {p m : ℕ} (hp : 0 < p) (i : ℤ)
    (hne : i ≠ 1) (hl : -(2*(m:ℤ)) < i-1) (hu : i-1 < 2*(m:ℤ)) :
    mark p m i (site p m 1) = 0 := by
  apply Finsupp.single_eq_of_ne
  intro hh
  have he : ((((p:ℤ)*(i-1) : ℤ) : ZMod (p*(2*m)))) = 0 := by
    change (p : ZMod (p*(2*m))) * (i:ℤ) = (p : ZMod (p*(2*m))) * (1 : ℤ) at hh
    push_cast at hh ⊢
    linear_combination hh
  have he' := (ZMod.intCast_zmod_eq_zero_iff_dvd _ _).mp he
  push_cast at he'
  have hdiv := (Int.mul_dvd_mul_iff_left (by exact_mod_cast hp.ne')).mp he'
  by_cases h : 0 ≤ i-1
  · have := Int.eq_zero_of_dvd_of_nonneg_of_lt h hu hdiv
    omega
  · have := Int.eq_zero_of_dvd_of_nonneg_of_lt (by omega : 0 ≤ -(i-1)) (by omega)
        (dvd_neg.mpr hdiv)
    omega

private theorem mark_add_eval {n : ℕ} (f g : Cyclic n) (j : ZMod n) :
    (f+g) j=f j+g j := rfl

/-- At scaled site 1, two adjacent dyadic generations differ when the odd
    normalised width is at least seven. This is the half-width obstruction. -/
private theorem half_pattern {p m : ℕ} (hp : 0 < p) (hm : 7 ≤ m) :
    (mark p m (-1)+mark p m 0+mark p m 1) *
      (mark p m (-((m:ℤ)+1))+mark p m 0+mark p m ((m:ℤ)+1)) ≠
      mark p m (-2)+mark p m 0+mark p m 2 := by
  intro ha
  have hc := congrArg (fun f : Cyclic (p*(2*m)) => f (site p m 1)) ha
  dsimp only at hc
  simp only [mul_add,add_mul,mark_mul,mark_add_eval,add_zero,zero_add,mark_hit] at hc
  simp (disch := omega) [mark_miss hp,mark_hit] at hc

private theorem scaled_row (s k m : ℕ) :
    (rule (2^s*(2*m)))^(2^(s+k)) =
      mark (2^s) m (-(2:ℤ)^k)+mark (2^s) m 0+mark (2^s) m ((2:ℤ)^k) := by
  rw [rule_frobenius]
  have h0 : point (2^s*(2*m)) 0 = 1 := rfl
  simp [mark,site,pow_add,h0]

theorem no_half_repeat {s k m : ℕ} (hm : 7 ≤ m) (hk : 2^k = m+1) :
    let p := 2^s
    let n := p*(2*m)
    (rule n)^(2*p + p*m) ≠ (rule n)^(2*p) := by
  dsimp only
  have he : 2*2^s + 2^s*m = 2^s + 2^(s+k) := by rw [pow_add,hk]; ring
  have htwo : 2*2^s = 2^(s+1) := by rw [pow_succ,Nat.mul_comm]
  have hi : (2:ℤ)^k = (m:ℤ)+1 := by exact_mod_cast hk
  have h0 := scaled_row s 0 m
  simp only [Nat.add_zero,pow_zero] at h0
  rw [he,pow_add,h0,scaled_row s k m,htwo,scaled_row s 1 m,pow_one,hi]
  exact half_pattern (Nat.two_pow_pos _) hm

private theorem multiples {A : Type*} [Monoid A] {x : A} {t p : ℕ}
    (h : x^(t+p)=x^t) (a : ℕ) : x^(t+p*a)=x^t := by
  induction a with
  | zero => simp
  | succ a ih =>
    rw [Nat.mul_succ,← Nat.add_assoc,pow_add,ih,← pow_add,h]

private theorem periodic_at_start {A : Type*} [Monoid A] {x : A} {t n J e : ℕ}
    (hn : 0<n) (hs : x^(t+n)=x^t) (he : x^(J+e)=x^J) : x^(t+e)=x^t := by
  let L := t+n*J
  have hJ : J ≤ L := le_trans (Nat.le_mul_of_pos_left _ hn) (Nat.le_add_left _ _)
  have hstable : x^L=x^t := multiples hs J
  have H := congrArg (fun a : A => x^(L-J)*a) he
  change x^(L-J)*x^(J+e)=x^(L-J)*x^J at H
  rw [← pow_add,← pow_add,show L-J+(J+e)=L+e by omega,show L-J+J=L by omega,
    pow_add,hstable,← pow_add] at H
  exact H

private theorem least_divides {A : Type*} [Monoid A] {x : A} {t n d : ℕ}
    (hN : x^(t+n)=x^t) (hD : x^(t+d)=x^t) (hd : 0<d)
    (hmin : ∀ e, 0<e → x^(t+e)=x^t → d≤e) : d ∣ n := by
  by_contra! h
  have hrem : 0<n%d := Nat.pos_of_ne_zero (fun H => h (Nat.dvd_of_mod_eq_zero H))
  have hs := multiples hD (n/d)
  have he : t+(d*(n/d))+(n%d) = t+n := by have := Nat.mod_add_div n d; omega
  have H : x^(t+n%d)=x^t := calc
    _ = x^t*x^(n%d) := pow_add ..
    _ = x^(t+d*(n/d))*x^(n%d) := by rw [hs]
    _ = x^(t+n) := by rw [← pow_add,he]
    _ = x^t := hN
  exact (not_le_of_gt (Nat.mod_lt n hd)) (hmin _ hrem H)

/-- Every width with a run of three or more ones followed by zeros has
    exact period equal to the width. -/
theorem shape_exact_width (s k : ℕ) (hk : 3 ≤ k) :
    let n := 2^s*(2^k-1)
    ExactPeriod n n := by
  classical
  let m := 2^k-1
  let t := 2^s
  let n := t*m
  have hp : 8 ≤ (2:ℕ)^k := Nat.pow_le_pow_right (by decide : 0 < 2) hk
  have hm : 7 ≤ m := by dsimp [m]; omega
  have hmk : 2^k = m+1 := by dsimp [m]; omega
  have ht : 0 < t := Nat.two_pow_pos _
  have hn : 0 < n := Nat.mul_pos ht (by omega)
  have hstart : (rule n)^(t+n)=(rule n)^t := shifted_mersenne_row s k (by omega)
  have hex : ∃ d, 0<d ∧ (rule n)^(t+d)=(rule n)^t := ⟨n,hn,hstart⟩
  let d := Nat.find hex
  have hd : 0<d ∧ (rule n)^(t+d)=(rule n)^t := Nat.find_spec hex
  have hmin (e : ℕ) (he : 0<e) (hrow : (rule n)^(t+e)=(rule n)^t) :
      d≤e := Nat.find_min' hex ⟨he,hrow⟩
  have hdiv := least_divides hstart hd.2 hd.1 hmin
  obtain ⟨q,hq⟩ := hdiv
  have hnd : n≤d := by
    by_contra! hsmall
    have hthree : q ≥ 3 ∨ q=2 := by
      by_contra! H
      have hlow : q=0 ∨ q=1 := by omega
      rcases hlow with hl|hl <;> simp [hl] at hq <;> omega
    rcases hthree with H|H
    · have ht7 : t*7 ≤ n := Nat.mul_le_mul_left _ hm
      have hd3 : d*3 ≤ n := hq ▸ Nat.mul_le_mul_left d H
      exact no_short_repeat hd.1 (by omega) hd.2
    · have h2 : n=2*d := by rw [hq,H,Nat.mul_comm]
      cases s with
      | zero =>
        have hmn : n=m := by simp [n,t]
        obtain ⟨v,hv⟩ := Nat.exists_eq_succ_of_ne_zero (by omega : k≠0)
        rw [hv,pow_succ] at hmk
        omega
      | succ s =>
        let p := 2^s
        have htt : t=2*p := by simp [t,p,pow_succ,Nat.mul_comm]
        have hnn : n=p*(2*m) := by dsimp [n]; rw [htt]; ring
        have hdd : d=p*m := by
          rw [hnn,show p*(2*m)=2*(p*m) by ring] at h2
          omega
        have H := hd.2
        rw [hnn,htt,hdd] at H
        exact no_half_repeat hm hmk H
  refine ⟨⟨hn,t,hstart⟩,?_⟩
  rintro e ⟨he,J,H⟩
  exact le_trans hnd (hmin e he (periodic_at_start hn hstart H))

theorem exact_width_iff {n : ℕ} (hn : 3 ≤ n) :
    ExactPeriod n n ↔ ∃ s k : ℕ, 3 ≤ k ∧ n=2^s*(2^k-1) := by
  refine ⟨exact_width_shape hn,?_⟩
  rintro ⟨s,k,hk,rfl⟩
  exact shape_exact_width s k hk

end Rule150Digits

import Mathlib.Data.Nat.Factorization.Basic
import Mathlib.Data.Nat.Prime.Factorial
import Mathlib.Data.Nat.Choose.Basic
import Mathlib.Tactic.IntervalCases
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.Ring
import Mathlib.Tactic.Push

namespace Sigg

theorem distinct_factors {a b m : ℕ} (ha : 0<a) (hb : 0<b)
    (ham : a≤m) (hbm : b≤m) (hne : a≠b) : a*b ∣ m.factorial := by
  have one {x y : ℕ} (hx : 0<x) (hxy : x<y) (hy : y≤m) : x*y ∣ m.factorial := by
    cases y with
    | zero => omega
    | succ k =>
      apply dvd_trans _ (Nat.factorial_dvd_factorial hy)
      rw [Nat.factorial_succ, mul_comm x]
      exact Nat.mul_dvd_mul_left _ (Nat.dvd_factorial hx (by omega))
  rcases lt_or_gt_of_ne hne with h|h
  · exact one ha h hbm
  · rw [mul_comm]; exact one hb h ham

theorem factorial_power (p e : ℕ) (hp : 0<p) : p^e ∣ (e*p).factorial := by
  induction e with
  | zero => simp
  | succ e ih =>
    rw [pow_succ, Nat.succ_mul]
    have A : p ∣ p.factorial := Nat.dvd_factorial hp le_rfl
    exact dvd_trans (Nat.mul_dvd_mul ih A) (Nat.factorial_mul_factorial_dvd_factorial_add _ _)

private theorem grow {p e : ℕ} (hp : 2≤p) (he : 3≤e)
    (h : (e*p)*(e*p+2)<2*p^e) : ((e+1)*p)*((e+1)*p+2)<2*p^(e+1) := by
  have main : ((e+1)*p)*((e+1)*p+2) ≤ 2*((e*p)*(e*p+2)) := by
    obtain ⟨k,rfl⟩ := Nat.exists_eq_add_of_le he
    ring_nf
    omega
  rw [pow_succ]
  calc
    _ ≤ 2*((e*p)*(e*p+2)) := main
    _ < 2*(2*p^e) := by omega
    _ ≤ 2*(p^e*p) := by nlinarith [Nat.mul_le_mul_left (p^e) hp]

private theorem grow_from {p b : ℕ} (hp : 2≤p) (hb : 3≤b)
    (base : (b*p)*(b*p+2)<2*p^b) (e : ℕ) (he : b≤e) :
    (e*p)*(e*p+2)<2*p^e := by
  induction e, he using Nat.le_induction with
  | base => exact base
  | succ k hk ih => exact grow hp (by omega) ih

theorem high_powers {p e : ℕ} (hp : 2≤p) (he : 3≤e) (h : 18≤e*p) :
    (e*p)*(e*p+2)<2*p^e := by
  by_cases h6 : 6≤p
  · apply grow_from hp (b:=3) (by decide) _ _ he
    obtain ⟨k,rfl⟩ := Nat.exists_eq_add_of_le h6
    ring_nf
    omega
  interval_cases p
  · exact grow_from (by decide) (b:=9) (by decide) (by decide) _ (by omega)
  · exact grow_from (by decide) (b:=6) (by decide) (by decide) _ (by omega)
  · exact grow_from (by decide) (b:=5) (by decide) (by decide) _ (by omega)
  · exact grow_from (by decide) (b:=4) (by decide) (by decide) _ (by omega)

theorem prime_obstruction {n s : ℕ} (hn : 18≤n) (hs : 0<s)
    (bound : 2*s≤n*(n+2)) (bad : ¬s ∣ (n-1).factorial) :
    ∃ p e : ℕ, p.Prime ∧ p^e∣s ∧ n≤e*p ∧ (e=1 ∨ e=2) := by
  rw [Nat.dvd_iff_prime_pow_dvd_dvd] at bad
  push_neg at bad
  obtain ⟨p,e,hp,hd,hf⟩ := bad
  have hem : n≤e*p := by
    by_contra! h
    exact hf (dvd_trans (factorial_power p e hp.pos) (Nat.factorial_dvd_factorial (by omega)))
  have hl := Nat.le_of_dvd hs hd
  refine ⟨p,e,hp,hd,hem,?_⟩
  by_contra! h
  have hp₃ : 3≤e := by
    cases e with
    | zero => simp at hem; omega
    | succ e => omega
  have hu := high_powers hp.two_le hp₃ (le_trans hn hem)
  have hh := Nat.mul_le_mul hem (Nat.add_le_add_right hem 2)
  omega

def tri (n : ℕ) := n*(n+1)/2

private theorem two_tri (n : ℕ) : 2*tri n=n*(n+1) :=
  Nat.mul_div_cancel' n.even_mul_succ_self.two_dvd

private theorem even_tri (t : ℕ) : tri (2*t) = t*(2*t+1) := by
  have h := two_tri (2*t)
  nlinarith only [h]

private theorem composite_zero {n : ℕ} (hn : 3≤n) (hc : ¬(n+1).Prime) :
    tri n ∣ (n-1).factorial*n := by
  obtain ⟨a,⟨b,hab⟩,ha,hal⟩ := (Nat.not_prime_iff_exists_dvd_lt (by omega)).mp hc
  have hb : 2≤b := by
    by_contra! h; interval_cases b <;> simp_all
  have nm : n-1+1=n := by omega
  have amax : a≤n-1 := by nlinarith [Nat.mul_le_mul_left a hb]
  have bmax : b≤n-1 := by nlinarith [Nat.mul_le_mul_right b ha]
  have hd : n+1 ∣ 2*(n-1).factorial := by
    by_cases h : a=b
    · subst b
      by_cases h2 : a=2
      · subst a; have : n=3 := by omega
        subst n; decide
      have au : 2*a≤n-1 := by
        have : 3≤a := by omega
        nlinarith [Nat.mul_le_mul_left a this]
      have hd' := distinct_factors (a:=a) (b:=2*a) (m:=n-1) (by omega) (by omega)
        amax au (by omega)
      rw [hab]
      exact dvd_trans (dvd_mul_right (a*a) 2)
        (by simpa only [mul_assoc,mul_left_comm,mul_comm] using dvd_mul_of_dvd_left hd' 2)
    · rw [hab]; exact dvd_mul_of_dvd_right (distinct_factors (by omega) (by omega) amax bmax h) 2
  obtain ⟨k,hk⟩ := hd
  refine ⟨k,?_⟩
  have eq := congrArg (fun x : ℕ => n*x) hk
  have eq₂ := congrArg (fun x : ℕ => x*k) (two_tri n)
  dsimp at eq eq₂
  nlinarith only [eq,eq₂]

private theorem nonsquare {t : ℕ} (ht : 1≤t) (hp : (2*t+1).Prime) (x : ℕ) :
    tri (2*t) ≠ x*x := by
  rw [even_tri]
  intro h
  have hd : 2*t+1∣x*x := h ▸ dvd_mul_left _ _
  have hx := (hp.dvd_mul.mp hd).elim id id
  obtain ⟨k,hk⟩ := hx
  have ht' : t=(2*t+1)*(k*k) := by
    apply Nat.eq_of_mul_eq_mul_left (show 0<2*t+1 by omega)
    rw [mul_comm _ t,h,hk]
    ring
  have := Nat.le_of_dvd (by omega : 0<t) (show 2*t+1∣t from ⟨k*k,ht'⟩) 
  omega

private theorem even_upper {t : ℕ} (ht : 2≤t) :
    tri (2*t)+t ∣ (2*t-1).factorial*(2*t+t) := by
  obtain ⟨k,eq⟩ := distinct_factors (a:=2) (b:=t+1) (m:=2*t-1)
    (by decide) (by omega) (by omega) (by omega) (by omega)
  refine ⟨3*k,?_⟩
  rw [even_tri,eq]
  ring

private theorem window {t j : ℕ} (ht : 9≤t) (hj : j≤t) (hp : (2*t+1).Prime)
    (hfac : tri (2*t)+j ∣ (2*t+j).factorial) :
    ∃ i≤j, tri (2*t)+i ∣ (2*t-1).factorial*(2*t+i) := by
  let T := tri (2*t)
  let s := T+j
  let F := (2*t-1).factorial
  have tval : T=t*(2*t+1) := even_tri t
  have hpos : 0<s := by dsimp [s]; nlinarith
  have hsbound : 2*s≤(2*t)*(2*t+2) := by dsimp [s]; nlinarith
  have lift (d : ℕ) (hl : T≤d) (hu : d≤s) (hd : d∣F) :
      ∃ i≤j, T+i∣F*(2*t+i) := by
    refine ⟨d-T,by dsimp [s] at hu; omega,?_⟩
    rw [show T+(d-T)=d by omega]
    exact dvd_mul_of_dvd_left hd _
  by_cases good : s∣F
  · exact lift s (by dsimp [s]; omega) le_rfl good
  have off := prime_obstruction (n:=2*t) (by omega) hpos hsbound good
  obtain ⟨p,e,pp,hds,hpe,he|he⟩ := off
  · subst e
    simp only [pow_one,one_mul] at hds hpe
    have pmax := pp.dvd_factorial.mp (dvd_trans hds hfac)
    have hn2 : p≠2 := by omega
    obtain ⟨u,hu⟩ := pp.odd_of_ne_two hn2
    obtain ⟨b,hb⟩ := hds
    have bp : 0<b := by
      cases b with
      | zero => rw [Nat.mul_zero] at hb; omega
      | succ k => omega
    have hr : 2*t<p := by omega
    have bu : b≤t := by
      apply Nat.le_of_not_gt
      intro h
      have hh := Nat.mul_le_mul hr h
      nlinarith only [hh,hb,hsbound]
    have bl : t+t+1-(p-2*t) ≤ 2*b := by
      apply Nat.le_of_not_gt
      intro h
      have bl' : 2*b+p≤4*t := by omega
      have h1 := Nat.mul_le_mul_left p bl'
      have h2 := Nat.zero_le ((p-2*t)*(p-2*t))
      have h3 := Nat.sub_add_cancel hpe
      have h4 := congrArg (fun x : ℕ => x*x) h3
      have h5 := congrArg (fun x : ℕ => x*t) h3
      dsimp at h4 h5
      have lower : t*(2*t+1)≤s := by dsimp [s]; omega
      nlinarith only [h1,h2,h4,h5,hb,lower,ht]
    let a := u+1
    let c := 2*b-1
    have ca : c+1=2*b := by dsimp [c]; omega
    have pa : 2*a=p+1 := by dsimp [a]; omega
    have sc : s+b=a*c+a := by
      have h' := congrArg (fun z : ℕ => a*z) ca
      have h'' := congrArg (fun z : ℕ => z*b) pa
      dsimp at h' h''; nlinarith only [h',h'',hb]
    have amax : a≤2*t-2 := by omega
    have cmax : c≤2*t-1 := by omega
    have lower : T≤a*c := by dsimp [s] at sc; omega
    have upper : a*c<s := by omega
    by_cases eq : a=c
    · have neq := nonsquare (by omega : 1≤t) hp a
      change T≠a*a at neq
      have alow : 2≤a := by omega
      have ak : a-1+1=a := by omega
      have ident : (a-1)*(a+1)+1=a*a := by
        have h' := congrArg (fun z : ℕ => z*(a+1)) ak
        dsimp at h'; nlinarith only [h',ak]
      rw [← eq] at lower upper
      exact lift ((a-1)*(a+1)) (by omega) (by omega)
        (distinct_factors (by omega) (by omega) (by omega) (by omega) (by omega))
    · exact lift _ lower upper.le
        (distinct_factors (by omega) (by omega) (by omega) cmax eq)
  · subst e
    obtain ⟨b,hb⟩ := hds
    have bp : 0<b := by
      cases b with
      | zero => rw [Nat.mul_zero] at hb; omega
      | succ k => omega
    have bt : b=1 := by
      by_cases pe : p=t
      · subst p
        have lower : 2*t^2<s := by dsimp [s]; nlinarith
        have upper : s<3*t^2 := by dsimp [s]; nlinarith
        rcases lt_or_ge b 3 with h|h
        · have := Nat.mul_le_mul_left (t^2) (by omega : b≤2)
          nlinarith
        · have := Nat.mul_le_mul_left (t^2) h
          nlinarith
      · apply Nat.le_antisymm _ bp
        apply Nat.le_of_not_gt
        intro ne
        have h1 := Nat.mul_le_mul (by omega : t+1≤p) (by omega : t+1≤p)
        have h2 := Nat.mul_le_mul_left (p^2) (by omega : 2≤b)
        nlinarith only [h1,h2,hb,hsbound]
    subst b
    simp only [mul_one,pow_two] at hb
    have neq := nonsquare (by omega : 1≤t) hp p
    change T≠p*p at neq
    have lower : T≤s := by dsimp [s]; omega
    have pmax : p≤2*t-2 := by
      apply Nat.le_of_not_gt
      intro h
      have ht' : 2*t-1+1=2*t := by omega
      have hh := Nat.mul_le_mul (by omega : 2*t-1≤p) (by omega : 2*t-1≤p)
      have h₁ := congrArg (fun z : ℕ => z*z) ht'
      dsimp at h₁
      nlinarith only [hh,h₁,hsbound,hb,ht',show 4≤t by omega,
        Nat.mul_le_mul_left t (show 4≤t by omega)]
    have pm : p-1+1=p := by omega
    have h' := congrArg (fun z : ℕ => z*(p+1)) pm
    dsimp at h'
    have ident : (p-1)*(p+1)+1=s := by nlinarith only [h',pm,hb]
    exact lift ((p-1)*(p+1)) (by omega) (by omega)
      (distinct_factors (by have := pp.two_le; omega) (by omega) (by omega) (by omega) (by omega))

theorem first_offset {n j : ℕ} (hn : 3≤n) (h : tri n+j ∣ (n+j).factorial) :
    ∃ i≤j, tri n+i ∣ (n-1).factorial*(n+i) := by
  by_cases pp : (n+1).Prime
  · obtain ⟨t,eq⟩ := pp.odd_of_ne_two (by omega)
    have ne : n=2*t := by omega
    subst n
    have ht : 2≤t := by omega
    by_cases hj : t≤j
    · exact ⟨t,hj,even_upper ht⟩
    by_cases big : 9≤t
    · exact window big (by omega) pp h
    have small : t≤8 := by omega
    interval_cases t <;> interval_cases j <;>
      first | exact ⟨0, by decide, by decide⟩ | exact ⟨1, by decide, by decide⟩ |
        exact ⟨2, by decide, by decide⟩ | exact ⟨3, by decide, by decide⟩ |
        exact ⟨4, by decide, by decide⟩ | exact absurd pp (by decide) |
        exact absurd h (by decide)
  · exact ⟨0,by omega,by simpa using composite_zero hn pp⟩

#print axioms first_offset
end Sigg

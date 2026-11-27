import Mathlib.Data.ZMod.Basic
import Mathlib.Tactic.Abel
import Mathlib.Tactic.LinearCombination

namespace ContinuantPeriods

def a (N : ℕ) : ℕ → ZMod N
  | 0 => 0
  | 1 => 1
  | n+2 => (n+1)*a N (n+1)+a N n

def extA (N : ℕ) (j : ℤ) := a N j.natAbs

private theorem centered (N : ℕ) (j : ℤ) :
    extA N (j+1)-extA N (j-1)=(j : ZMod N)*extA N j := by
  cases j with
  | ofNat j =>
    cases j with
    | zero => simp [extA,a]
    | succ i =>
      change extA N (((i+1:ℕ):ℤ)+1) - extA N (((i+1:ℕ):ℤ)-1) =
        (((i+1:ℕ):ℤ):ZMod N) * extA N ((i+1:ℕ):ℤ)
      rw [show ((i+1:ℕ):ℤ)+1=((i+2:ℕ):ℤ) by omega,
          show ((i+1:ℕ):ℤ)-1=(i:ℤ) by omega]
      simp only [extA,Int.natAbs_natCast,Int.cast_natCast]
      rw [a,Nat.cast_add,Nat.cast_one]
      abel
  | negSucc i =>
    have hp : Int.negSucc i + 1 = -(i:ℤ) := by omega
    have hm : Int.negSucc i - 1 = -((i+2:ℕ):ℤ) := by omega
    rw [hp,hm]
    simp only [extA, Int.natAbs_neg,Int.natAbs_natCast,Int.natAbs_negSucc]
    rw [a]
    push_cast
    ring

theorem reflection (N j : ℕ) :
    extA N ((N:ℤ)+j) = extA N ((N:ℤ)-j) := by
  induction j using Nat.twoStepInduction with
  | zero => simp
  | one =>
    have H := centered N N
    simp only [Int.cast_natCast,ZMod.natCast_self,zero_mul,sub_eq_zero] at H
    simpa only [Nat.cast_one] using H
  | more j h₀ h₁ =>
    have hp := centered N ((N:ℤ)+(j+1))
    have hm := centered N ((N:ℤ)-(j+1))
    push_cast at hp hm h₁ ⊢
    simp only [Int.cast_add,Int.cast_sub,Int.cast_natCast,Int.cast_one,
      ZMod.natCast_self,zero_add,zero_sub] at hp hm
    rw [show (N:ℤ)+(j+1)+1=N+(j+2) by ring,show (N:ℤ)+(j+1)-1=N+j by ring] at hp
    rw [show (N:ℤ)-(j+1)+1=N-j by ring,show (N:ℤ)-(j+1)-1=N-(j+2) by ring] at hm
    rw [h₀,h₁] at hp
    linear_combination hp + hm

def Period (f : ℕ → ZMod N) (p : ℕ) : Prop := ∀ j, f (j+p)=f j

theorem twice_width (N : ℕ) : Period (a N) (2*N) := by
  intro j
  have H := reflection N (N+j)
  push_cast at H
  rw [show (N:ℤ)+(N+j)=((j+2*N:ℕ):ℤ) by push_cast; ring,
      show (N:ℤ)-(N+j) = -(j:ℤ) by ring] at H
  simpa [extA] using H

theorem width_dvd_period {N p : ℕ} (h : Period (a N) p) : N ∣ p := by
  have h₀ := h 0
  have h₁ := h 1
  have h₂ := h 2
  simp only [zero_add,a] at h₀
  rw [Nat.add_comm 1 p] at h₁
  rw [Nat.add_comm 2 p,a,h₁,h₀] at h₂
  norm_num [a] at h₂
  exact (ZMod.natCast_zmod_eq_zero_iff_dvd _ _).mp h₂

theorem least_period_either {N p : ℕ} (hN : 0<N) (hp : 0<p) (h : Period (a N) p)
    (hle : ∀ d, 0<d → Period (a N) d → p≤d) : p=N ∨ p=2*N := by
  have hu := hle _ (by omega) (twice_width N)
  obtain ⟨c,he⟩ := width_dvd_period h
  have hc : c≤2 := by
    rw [he,Nat.mul_comm 2 N] at hu
    exact Nat.le_of_mul_le_mul_left hu hN
  rcases (show c=0 ∨ c=1 ∨ c=2 by omega) with hh|hh|hh <;> simp [hh,Nat.mul_comm] at he <;> omega

theorem first_conjecture {N : ℕ} (hN : 0<N) :
    ∃ p, (p=N ∨ p=2*N) ∧ 0<p ∧ Period (a N) p ∧
      ∀ d, 0<d → Period (a N) d → p≤d := by
  classical
  have hex : ∃ p, 0<p ∧ Period (a N) p := ⟨2*N,by omega,twice_width N⟩
  obtain ⟨hp,hper⟩ := Nat.find_spec hex
  have H (d) (hd : 0<d) (H : Period (a N) d) : Nat.find hex ≤ d :=
    Nat.find_min' hex ⟨hd,H⟩
  exact ⟨_,least_period_either hN hp hper H,hp,hper,H⟩

def b (N j : ℕ) := a N (2*j)

theorem even_period (N : ℕ) : Period (b N) N := by
  intro j
  simp only [b,Nat.mul_add]
  exact twice_width N _

theorem odd_width_dvd_even_period {N p : ℕ} (hN : Odd N) (hp : 0<p) (h : Period (b N) p) :
    N ∣ p := by
  have h0 : 0<N := by obtain ⟨t,ht⟩ := hN; omega
  have hprev : b N (N-1)=1 := by
    have H := reflection N (N-2)
    by_cases hsmall : N<2
    · have h1 : N=1 := by omega
      subst N
      exact Subsingleton.elim _ _
    push_cast [show 2≤N by omega] at H
    rw [show (N:ℤ)+(N-2)=((2*(N-1):ℕ):ℤ) by
          push_cast [show 1≤N by omega]; ring,show (N:ℤ)-(N-2)=2 by ring] at H
    simpa [b,extA,a] using H
  have hb₀ : a N (2*p)=0 := by simpa [b,a] using h 0
  have hb₁ : a N (2*p+2)=1 := by
    simpa [b,a,Nat.mul_add,Nat.add_comm 2 (2*p)] using h 1
  have hbpred : a N (2*(p-1))=1 := by
    change b N (p-1)=1
    rw [← even_period N (p-1),show p-1+N=N-1+p by omega,h (N-1),hprev]
  obtain ⟨r,hr⟩ := Nat.exists_eq_succ_of_ne_zero hp.ne'
  subst p
  let t := 2*r
  have hmid : a N (t+2)=0 := by simpa [t,Nat.mul_succ] using hb₀
  have hleft : a N t=1 := by simpa [t] using hbpred
  have hright : a N (t+4)=1 := by simpa [t,Nat.mul_succ] using hb₁
  have hs : a N (t+3)=a N (t+1) := by rw [a,hmid,mul_zero,zero_add]
  have H1 := hright
  rw [a,hs,hmid,add_zero] at H1
  have H2 := hmid
  rw [a,hleft] at H2
  push_cast at H1 H2
  have h4 : 4*((r+1:ℕ):ZMod N)*(a N (t+1))=0 := by
    dsimp [t] at H1 H2 ⊢
    push_cast at H1 H2 ⊢
    linear_combination H1+H2
  have hcancel : 4*((r+1:ℕ):ZMod N)=0 := by
    calc
      _ = (4*((r+1:ℕ):ZMod N)) * (((t:ZMod N)+2+1)*a N (t+1)) := by rw [H1,mul_one]
      _ = 0 := by linear_combination ((t:ZMod N)+2+1)*h4
  have hdiv : N ∣ 4*(r+1) := (ZMod.natCast_zmod_eq_zero_iff_dvd _ _).mp (by simpa using hcancel)
  exact (hN.coprime_two_right.pow_right 2).dvd_of_dvd_mul_left hdiv

theorem least_even_period {N : ℕ} (hN : Odd N) :
    Period (b N) N ∧ ∀ p, 0<p → Period (b N) p → N≤p :=
  ⟨even_period _,fun _ hp h => Nat.le_of_dvd hp (odd_width_dvd_even_period hN hp h)⟩

end ContinuantPeriods

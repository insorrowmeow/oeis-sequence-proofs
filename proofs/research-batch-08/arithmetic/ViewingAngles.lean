import Mathlib.Algebra.BigOperators.Intervals
import Mathlib.Data.Nat.Choose.Basic
import Mathlib.Tactic.IntervalCases
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.Ring

namespace ViewingAngles
open Finset

/-- Count ordered splits t=v+w with v,w,n-t distinct. -/
def allowed (n t : ℕ) : Finset ℕ :=
  (Ico 1 t).filter (fun v => v ≠ t-v ∧ v ≠ n-t ∧ t-v ≠ n-t)

def g (n t : ℕ) := (allowed n t).card

def loss (n : ℕ) : ℕ → ℕ
  | 0 => 0
  | a+1 => loss n a + g n (a+1)

private theorem upper (n t : ℕ) : g n t ≤ t-1 := by
  have H := card_le_card (filter_subset (fun v => v ≠ t-v ∧ v ≠ n-t ∧ t-v ≠ n-t) (Ico 1 t))
  simpa [g,allowed] using H

private theorem lower (n t : ℕ) : t-4 ≤ g n t := by
  let I := Ico 1 t
  let bad := I \ allowed n t
  have H : bad ⊆ {t/2,n-t,t-(n-t)} := by
    intro v hv
    obtain ⟨vI,vN⟩ := mem_sdiff.mp hv
    change v ∈ Ico 1 t at vI
    have hI := mem_Ico.mp vI
    simp only [allowed, mem_filter, vI, true_and, not_and_or, not_not] at vN
    simp only [mem_insert, mem_singleton]
    omega
  have hcard : bad.card ≤ 3 := by
    apply (card_le_card H).trans
    exact (card_insert_le _ _).trans (by have := card_insert_le (n-t) {t-(n-t)}; simp at *; omega)
  have sub : allowed n t ⊆ I := filter_subset _ _
  have eqn := card_sdiff_add_card_eq_card sub
  change bad.card + g n t = (Ico 1 t).card at eqn
  simp only [Nat.card_Ico] at eqn
  omega

private theorem low (n t : ℕ) (ht : 0<t) (h : 2*t ≤ n) :
    g n t = 2*((t-1)/2) := by
  by_cases e : t%2=0
  · have H : allowed n t = (Ico 1 t).erase (t/2) := by
      ext v
      simp only [allowed,mem_filter,mem_Ico,mem_erase]
      omega
    rw [g,H,card_erase_of_mem (by rw [mem_Ico]; omega),Nat.card_Ico]
    omega
  · have H : allowed n t = Ico 1 t := by
      ext v
      simp only [allowed,mem_filter,mem_Ico]
      omega
    rw [g,H,Nat.card_Ico]; omega

/-- Transferring one floor unit from the largest to the smallest floor does not
    increase the count of excluded triples. -/
theorem balance_step (n a b c : ℕ) (hn : 6≤n) (order : c≤b ∧ b≤a)
    (total : a+b+c=n-2) (far : c+2≤a) :
    loss n (a-1)+loss n (c+1) ≤ loss n a+loss n c := by
  have H : g n (c+1) ≤ g n a := by
    by_cases small : 2*a≤n
    · rw [low n a (by omega) small, low n (c+1) (by omega) (by omega)]
      omega
    · have A := upper n (c+1)
      have C := lower n a
      omega
  have e : loss n a = loss n (a-1)+g n a := by
    conv_lhs => rw [show a = a-1+1 by omega]
    rw [loss, Nat.sub_add_cancel (by omega)]
  rw [e, loss]; omega

private theorem low_pair (n r : ℕ) :
    (4*r≤n → loss n (2*r)=2*r*(r-1)) ∧
    (4*r+2≤n → loss n (2*r+1)=2*r^2) := by
  induction r with
  | zero => simp [loss, g, allowed]
  | succ r ih =>
    have A (h : 4*(r+1)≤n) : loss n (2*(r+1)) = 2*(r+1)*r := by
      rw [show 2*(r+1) = (2*r+1)+1 by omega, loss, ih.2 (by omega),
        low n _ (by omega) (by omega), show (2*r+1+1-1)/2=r by omega]; ring
    refine ⟨by simpa using A, ?_⟩
    intro h
    rw [loss,A (by omega),low n _ (by omega) (by omega),
      show (2*(r+1)+1-1)/2 = r+1 by omega]; ring

private theorem sort_three (f : ℕ → ℕ) (a b c : ℕ) :
    ∃ A B C : ℕ, C≤B ∧ B≤A ∧ A+B+C=a+b+c ∧
      A^2+B^2+C^2=a^2+b^2+c^2 ∧ f A+f B+f C=f a+f b+f c := by
  rcases le_total a b with ab|ba
  · rcases le_total b c with bc|cb
    · exact ⟨c,b,a,by omega⟩
    · rcases le_total a c with ac|ca
      · exact ⟨b,c,a,by omega⟩
      · exact ⟨b,a,c,by omega⟩
  · rcases le_total a c with ac|ca
    · exact ⟨c,a,b,by omega⟩
    · rcases le_total b c with bc|cb
      · exact ⟨a,c,b,by omega⟩
      · exact ⟨a,b,c,by omega⟩

/-- The three balanced floors minimize the number of exclusions. -/
theorem minimum_loss (n a b c : ℕ) (hn : 6≤n) (total : a+b+c=n-2) :
    loss n ((n-2)/3) + loss n ((n-1)/3) + loss n (n/3)
      ≤ loss n a + loss n b + loss n c := by
  generalize he : a^2+b^2+c^2 = e
  induction e using Nat.strong_induction_on generalizing a b c with
  | h e ih =>
    obtain ⟨A,B,C,cb,ba,hs,he',hl⟩ := sort_three (loss n) a b c
    by_cases close : A≤C+1
    · have ha : A=n/3 := by omega
      have hb : B=(n-1)/3 := by omega
      have hc : C=(n-2)/3 := by omega
      rw [← hl, ← ha, ← hb, ← hc]; omega
    · obtain ⟨k,hk⟩ : ∃ k, A=k+1 := ⟨A-1, by omega⟩
      subst A
      have step := balance_step n (k+1) B C hn ⟨cb,ba⟩ (by omega) (by omega)
      simp only [Nat.add_sub_cancel] at step
      have smaller : k^2+B^2+(C+1)^2 < e := by
        rw [← he, ← he']
        nlinarith [show C<k by omega]
      have next := ih _ smaller k B (C+1) (by omega) rfl
      omega

theorem loss_small (n a : ℕ) (ha : 2*a≤n) :
    loss n a = 2*(a/2)*((a-1)/2) := by
  obtain ⟨r,hr⟩ : ∃ r, a=2*r ∨ a=2*r+1 := ⟨a/2, by omega⟩
  rcases hr with even|odd
  · subst a
    rw [(low_pair n r).1 (by omega),show 2*r/2=r by omega,
      show (2*r-1)/2=r-1 by omega]
  · subst a
    rw [(low_pair n r).2 (by omega),show (2*r+1)/2=r by omega,
      show (2*r+1-1)/2=r by omega]; ring

/-- Twice the number of unrestricted ordered positive distinct triples of sum n. -/
def twiceUnrestricted (n : ℕ) : ℤ :=
  ((n:ℤ)-1)*((n:ℤ)-2) - 6*(((n-1)/2:ℕ):ℤ) + (if n%3=0 then 4 else 0)

/-- Two times the unrestricted count less the three optimized exclusions. -/
def twiceBest (n : ℕ) : ℤ := twiceUnrestricted n -
  2*((loss n ((n-2)/3) + loss n ((n-1)/3) + loss n (n/3) : ℕ) : ℤ)

def correction : ℕ → ℤ
  | 0 => 6 | 1 => -3 | 2 => 4 | 3 => 3 | 4 => 0 | _ => -5

/-- The optimized expression gives Nakai's six quadratic constituents for all n. -/
theorem six_constituents (n : ℕ) (hn : 3≤n) :
    3*twiceBest n = 2*((n:ℤ)^2-4*n+correction (n%6)) := by
  by_cases small : n<12
  · interval_cases n <;> decide
  unfold twiceBest twiceUnrestricted
  rw [loss_small n ((n-2)/3) (by omega), loss_small n ((n-1)/3) (by omega),
    loss_small n (n/3) (by omega)]
  let k := n/6-2
  have splits : n=6*k+12+0 ∨ n=6*k+12+1 ∨ n=6*k+12+2 ∨ n=6*k+12+3 ∨ n=6*k+12+4 ∨ n=6*k+12+5 := by dsimp [k]; omega
  rcases splits with h|h|h|h|h|h
  · rw [show ((n-2)/3)/2 = k+1 by omega,
        show (((n-2)/3)-1)/2 = k+1 by omega,
        show ((n-1)/3)/2 = k+1 by omega,
        show (((n-1)/3)-1)/2 = k+1 by omega,
        show (n/3)/2 = k+2 by omega,
        show ((n/3)-1)/2 = k+1 by omega,
        show (n-1)/2=3*k+5 by omega,
        show n%3=0 by omega,show n%6=0 by omega,h]
    norm_num [correction]
    ring
  · rw [show ((n-2)/3)/2 = k+1 by omega,
        show (((n-2)/3)-1)/2 = k+1 by omega,
        show ((n-1)/3)/2 = k+2 by omega,
        show (((n-1)/3)-1)/2 = k+1 by omega,
        show (n/3)/2 = k+2 by omega,
        show ((n/3)-1)/2 = k+1 by omega,
        show (n-1)/2=3*k+6 by omega,
        show n%3=1 by omega,show n%6=1 by omega,h]
    norm_num [correction]
    ring
  · rw [show ((n-2)/3)/2 = k+2 by omega,
        show (((n-2)/3)-1)/2 = k+1 by omega,
        show ((n-1)/3)/2 = k+2 by omega,
        show (((n-1)/3)-1)/2 = k+1 by omega,
        show (n/3)/2 = k+2 by omega,
        show ((n/3)-1)/2 = k+1 by omega,
        show (n-1)/2=3*k+6 by omega,
        show n%3=2 by omega,show n%6=2 by omega,h]
    norm_num [correction]
    ring
  · rw [show ((n-2)/3)/2 = k+2 by omega,
        show (((n-2)/3)-1)/2 = k+1 by omega,
        show ((n-1)/3)/2 = k+2 by omega,
        show (((n-1)/3)-1)/2 = k+1 by omega,
        show (n/3)/2 = k+2 by omega,
        show ((n/3)-1)/2 = k+2 by omega,
        show (n-1)/2=3*k+7 by omega,
        show n%3=0 by omega,show n%6=3 by omega,h]
    norm_num [correction]
    ring
  · rw [show ((n-2)/3)/2 = k+2 by omega,
        show (((n-2)/3)-1)/2 = k+1 by omega,
        show ((n-1)/3)/2 = k+2 by omega,
        show (((n-1)/3)-1)/2 = k+2 by omega,
        show (n/3)/2 = k+2 by omega,
        show ((n/3)-1)/2 = k+2 by omega,
        show (n-1)/2=3*k+7 by omega,
        show n%3=1 by omega,show n%6=4 by omega,h]
    norm_num [correction]
    ring
  · rw [show ((n-2)/3)/2 = k+2 by omega,
        show (((n-2)/3)-1)/2 = k+2 by omega,
        show ((n-1)/3)/2 = k+2 by omega,
        show (((n-1)/3)-1)/2 = k+2 by omega,
        show (n/3)/2 = k+2 by omega,
        show ((n/3)-1)/2 = k+2 by omega,
        show (n-1)/2=3*k+8 by omega,
        show n%3=2 by omega,show n%6=5 by omega,h]
    norm_num [correction]
    ring

#print axioms minimum_loss
#print axioms six_constituents
end ViewingAngles

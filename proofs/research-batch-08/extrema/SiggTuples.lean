import Mathlib.Algebra.BigOperators.Intervals
import Mathlib.Order.Interval.Finset.Nat
import Mathlib.Data.Finset.Max
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.Ring

namespace SiggTuples

private def tri (n : ℕ) := n*(n+1)/2

private theorem tri_succ (n : ℕ) : tri (n+1) = tri n + (n+1) := by
  unfold tri
  rw [show (n+1)*(n+1+1)=n*(n+1)+(n+1)*2 by ring,
    Nat.add_mul_div_right _ _ (by decide : 0<2)]

private theorem factorial_step_bound (c : ℕ) : c.factorial ≤ (c+1)*(c-1).factorial := by
  cases c with
  | zero => decide
  | succ n =>
    simp only [Nat.succ_sub_one,Nat.factorial_succ]
    exact Nat.mul_le_mul_right _ (by omega)

private theorem tuple_excess (s : Finset ℕ) (hpos : ∀ x ∈ s, 0<x) :
    ∃ e : ℕ, s.sum id = tri s.card + e ∧
      (∀ x ∈ s, x≤s.card+e) ∧
      s.card.factorial+(s.card-1).factorial*e ≤ s.prod id := by
  induction s using Finset.induction_on_max with
  | h0 => exact ⟨0,by decide,by simp,by decide⟩
  | step a s hmax ih =>
    have ha : 0<a := hpos _ (Finset.mem_insert_self a s)
    have hspos (x) (hx : x ∈ s) : 0<x := hpos _ (Finset.mem_insert_of_mem hx)
    obtain ⟨e,hSum,_,hProd⟩ := ih hspos
    have hs : s ⊆ Finset.Ico 1 a :=
      fun x hx => Finset.mem_Ico.mpr ⟨hspos x hx,hmax x hx⟩
    have hcount := Finset.card_le_card hs
    rw [Nat.card_Ico] at hcount
    have hgap : s.card+1≤a := by omega
    let d := a-(s.card+1)
    have hd : a=s.card+1+d := by dsimp [d]; omega
    have hnot : a ∉ s := fun h => (Nat.lt_irrefl _) (hmax _ h)
    refine ⟨e+d,?_,?_,?_⟩
    · rw [Finset.sum_insert hnot,Finset.card_insert_of_not_mem hnot,tri_succ,hSum]
      dsimp only [id]
      omega
    · intro x hx
      rw [Finset.card_insert_of_not_mem hnot]
      rcases Finset.mem_insert.mp hx with rfl|h
      · omega
      · have := hmax x h
        omega
    · rw [Finset.card_insert_of_not_mem hnot,Finset.prod_insert hnot]
      simp only [Nat.add_sub_cancel,Nat.factorial_succ,id_eq]
      have hc : s.card.factorial ≤ a*(s.card-1).factorial :=
        le_trans (factorial_step_bound _) (Nat.mul_le_mul_right _ hgap)
      have he := Nat.mul_le_mul_right e hc
      have hmain := Nat.mul_le_mul_left a hProd
      rw [hd] at hmain he ⊢
      change (s.card+1)*s.card.factorial + s.card.factorial*(e+d) ≤ (s.card+1+d)*s.prod id
      nlinarith only [he,hmain]

theorem prod_interval (u : ℕ) : (Finset.Icc 1 u).prod id = u.factorial := by
  induction u with
  | zero => decide
  | succ v ih =>
    rw [← Nat.Icc_insert_succ_right (by omega : 1≤v+1),
      Finset.prod_insert (by simp),ih,Nat.factorial_succ]
    rfl

theorem sum_interval (u : ℕ) : (Finset.Icc 1 u).sum id = u*(u+1)/2 := by
  change _ = tri u
  induction u with
  | zero => decide
  | succ v ih =>
    rw [← Nat.Icc_insert_succ_right (by omega : 1≤v+1),
      Finset.sum_insert (by simp),ih,tri_succ]
    exact Nat.add_comm _ _

theorem tri_le_sum {s : Finset ℕ} (hpos : ∀ a∈s, 0<a) :
    s.card*(s.card+1)/2 ≤ s.sum id := by
  obtain ⟨e,he,_,_⟩ := tuple_excess s hpos
  change tri s.card ≤ _
  omega

/-- Entrywise bound, divisibility by the ambient factorial and the sharp
    lower product for actual n-element positive subsets of the prescribed sum. -/
theorem tuple_bounds {s : Finset ℕ} {n j : ℕ} (hn : 0<n) (hcard : s.card=n)
    (hpos : ∀ a ∈ s, 0<a) (hsum : s.sum id = n*(n+1)/2+j) :
    (∀ a ∈ s, a≤n+j) ∧ s.prod id ∣ (n+j).factorial ∧
      (n-1).factorial*(n+j) ≤ s.prod id := by
  obtain ⟨e,he,hbound,hprod⟩ := tuple_excess s hpos
  rw [hcard] at he hbound hprod
  have hej : e=j := by unfold tri at he; omega
  subst e
  refine ⟨hbound,?_,?_⟩
  · rw [← prod_interval]
    exact Finset.prod_dvd_prod_of_subset _ _ _ (fun x hx =>
      Finset.mem_Icc.mpr ⟨hpos x hx,hbound x hx⟩)
  · obtain _|r := n
    · omega
    simp only [Nat.succ_sub_one,Nat.factorial_succ] at hprod ⊢
    nlinarith only [hprod]

end SiggTuples

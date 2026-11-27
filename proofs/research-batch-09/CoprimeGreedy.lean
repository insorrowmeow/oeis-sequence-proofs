import Mathlib.Data.Finset.Card
import Mathlib.Data.Finset.Range
import Mathlib.Data.Nat.GCD.Basic

namespace CoprimeGreedy

def small (s : Finset Nat) (k : Nat) := (s.filter (· < k)).card
def bad (s : Finset Nat) (k : Nat) := (s.filter (fun x => x.gcd k ≠ 1)).card

def eligible (s : Finset Nat) (k : Nat) :=
  0 < k ∧ k ∉ s ∧ small s k = bad s k + 1

inductive Prefix : Finset Nat → Prop where
  | start : Prefix {1}
  | step {s x} : Prefix s → eligible s x →
      (∀ k, eligible s k → x ≤ k) → Prefix (insert x s)

theorem invariant {s : Finset Nat} (hs : Prefix s) (k : Nat) (hk : 1 < k)
    (hm : k ∉ s) : bad s k < small s k := by
  induction hs with
  | start => simp [small, bad, Finset.filter_singleton, hk]
  | @step s x _ hx least ih =>
    have hxk : x ≠ k := by intro h; subst x; simp at hm
    have hks : k ∉ s := fun h => hm (Finset.mem_insert_of_mem h)
    have h := ih hks
    have heq : small s k = bad s k + 1 → x ≤ k :=
      fun he => least k ⟨by omega, hks, he⟩
    obtain ⟨_, hxs, _⟩ := hx
    unfold small bad at *
    by_cases hlt : x < k <;> by_cases hc : x.gcd k = 1 <;>
      simp only [Finset.filter_insert, hlt, hc, not_true_eq_false, not_false_eq_true,
        if_true, if_false] <;>
      simp [hc, hlt, hxs] at h heq ⊢ <;> omega

theorem missing_bound {s : Finset Nat} (hs : Prefix s) (k : Nat) (hk : 1 < k)
    (hm : k ∉ s) : bad s k < k := by
  apply lt_of_lt_of_le (invariant hs k hk hm)
  have h : s.filter (· < k) ⊆ Finset.range k := by
    intro x hx
    exact Finset.mem_range.mpr (Finset.mem_filter.mp hx).2
  simpa [small] using Finset.card_le_card h

end CoprimeGreedy

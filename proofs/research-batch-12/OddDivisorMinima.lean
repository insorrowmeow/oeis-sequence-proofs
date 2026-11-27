import Mathlib.Data.Real.Basic
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.Ring

namespace OddDivisorMinima

-- Coverage by the closed intervals [d,2d] with d in S.
def covers (S : ℝ → Prop) (a b : ℝ) : Prop :=
  ∀ x, a ≤ x → x ≤ b → ∃ d, S d ∧ d ≤ x ∧ x ≤ 2*d

theorem extend_cover (S : ℝ → Prop) (a b p : ℝ) (hp : 0 < p)
    (hjoin : p*a ≤ b) (h : covers S a b) :
    covers (fun d => S d ∨ ∃ e, S e ∧ d = p*e) a (p*b) := by
  intro x hx hupper
  by_cases hxb : x ≤ b
  · obtain ⟨d,hd,hl,hu⟩ := h x hx hxb
    exact ⟨d, Or.inl hd, hl, hu⟩
  · have hlo : a ≤ x/p := (le_div_iff₀ hp).mpr (by linarith [mul_comm a p])
    have hhi : x/p ≤ b := (div_le_iff₀ hp).mpr (by linarith [mul_comm b p])
    obtain ⟨e,he,h1,h2⟩ := h (x/p) hlo hhi
    refine ⟨p*e, Or.inr ⟨e,he,rfl⟩, ?_, ?_⟩
    · simpa [mul_comm] using (le_div_iff₀ hp).mp h1
    · have hh := (div_le_iff₀ hp).mp h2
      linarith only [hh, show 2*e*p = 2*(p*e) by ring]

def divisors (n : Nat) := (List.range (n+1)).filter (fun d => 0 < d && n % d == 0)
def breaks : List Nat → Nat
  | a :: b :: t => (if 2*a < b then 1 else 0) + breaks (b::t)
  | _ => 0

set_option maxRecDepth 12000 in
set_option maxHeartbeats 2000000 in
theorem starting_cases :
    ([15,45,105,135,1155] : List Nat).map (fun n => 1+breaks (divisors n))
    = [3,3,4,3,3] := by decide

end OddDivisorMinima

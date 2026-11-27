import Mathlib.Data.Nat.Basic
import Mathlib.Tactic.NormNum

namespace Navarrete
open scoped Classical

/-- k = 0 also covers the sole digit of zero. -/
def HasDigit (x d : ℕ) : Prop :=
  ∃ k : ℕ, (k = 0 ∨ 10 ^ k ≤ x) ∧ x / 10 ^ k % 10 = d

def Share (x y : ℕ) : Prop := ∃ d, HasDigit x d ∧ HasDigit y d

def hub (t r : ℕ) := 100000000000 * t + 12345678900 + r

private theorem hub_digit (t r d : ℕ) (hr : r < 2) (hd : d < 10) :
    HasDigit (hub t r) d := by
  have : d=0 ∨ d=1 ∨ d=2 ∨ d=3 ∨ d=4 ∨ d=5 ∨ d=6 ∨ d=7 ∨ d=8 ∨ d=9 := by omega
  refine ⟨if d = 0 then 1 else 11-d, ?_, ?_⟩ <;>
    rcases this with h|h|h|h|h|h|h|h|h|h <;> subst d <;> norm_num [hub] <;> omega

private theorem universal (x t r : ℕ) (hr : r < 2) : Share x (hub t r) :=
  ⟨x % 10, ⟨0, Or.inl rfl, by simp⟩, hub_digit t r _ hr (Nat.mod_lt _ (by decide))⟩

private theorem bounded_prefix (f : ℕ → ℕ) (N : ℕ) : ∃ B, ∀ i ≤ N, f i ≤ B := by
  induction N with
  | zero => exact ⟨f 0, by intro i hi; simp [Nat.le_zero.mp hi]⟩
  | succ n ih =>
    obtain ⟨B,h⟩ := ih
    refine ⟨max B (f (n+1)), ?_⟩
    intro i hi
    rcases Nat.le_succ_iff.mp hi with hi|hi
    · exact le_trans (h i hi) (le_max_left ..)
    · subst i; exact le_max_right .. 

private def Eligible {n : ℕ} (g : Fin (n+1) → ℕ) (r x : ℕ) : Prop :=
  x % 2 = r ∧ Share (g ⟨n, by omega⟩) x ∧ ∀ i, g i ≠ x

private theorem options {n : ℕ} (g : Fin (n+1) → ℕ) (r : ℕ) (hr : r < 2) :
    ∃ x, Eligible g r x := by
  obtain ⟨B,h⟩ := bounded_prefix (fun j => if p : j < n+1 then g ⟨j,p⟩ else 0) n
  refine ⟨hub B r, (by unfold hub; omega), universal _ _ _ hr, ?_⟩
  intro i
  have hi := h i (by omega)
  simp only [dif_pos i.isLt] at hi
  change g i ≤ B at hi
  unfold hub
  omega

noncomputable def walk (s : ℕ) : ℕ → ℕ
  | 0 => s
  | n+1 => Nat.find (options (fun i : Fin (n+1) => walk s i.val)
      ((s+n+1)%2) (Nat.mod_lt _ (by decide)))
termination_by n => n
decreasing_by all_goals exact i.isLt

private theorem step (s n : ℕ) :
    Eligible (fun i : Fin (n+1) => walk s i.val) ((s+n+1)%2) (walk s (n+1)) ∧
    ∀ x, Eligible (fun i : Fin (n+1) => walk s i.val) ((s+n+1)%2) x →
      walk s (n+1) ≤ x := by
  classical
  constructor
  · rw [walk.eq_2]
    exact Nat.find_spec (options _ _ (Nat.mod_lt _ (by decide)))
  · intro x hx
    rw [walk.eq_2]
    exact Nat.find_min' _ hx

private theorem injective (s : ℕ) : Function.Injective (walk s) := by
  intro i j hij
  have ne (a b : ℕ) (hab : a < b) : walk s a ≠ walk s b := by
    cases b with
    | zero => omega
    | succ b => exact (step s b).1.2.2 ⟨a,hab⟩
  rcases lt_trichotomy i j with h|h|h
  · exact False.elim (ne i j h hij)
  · exact h
  · exact False.elim (ne j i h hij.symm)

private theorem eventually_large (f : ℕ → ℕ) (hf : Function.Injective f) (k : ℕ) :
    ∃ N, ∀ i ≥ N, k < f i := by
  induction k with
  | zero =>
    by_cases h : ∃ i, f i = 0
    · obtain ⟨j,hj⟩ := h
      refine ⟨j+1, ?_⟩
      intro i hi
      by_contra! h
      have : i = j := hf (by omega)
      omega
    · exact ⟨0, by intro i _; by_contra! hi; exact h ⟨i, by omega⟩⟩
  | succ k ih =>
    obtain ⟨N,hN⟩ := ih
    by_cases h : ∃ i, f i = k+1
    · obtain ⟨j,hj⟩ := h
      refine ⟨max N (j+1), ?_⟩
      intro i hi
      have hi' := hN i (by omega)
      by_contra! h
      have : i = j := hf (by omega)
      omega
    · refine ⟨N, ?_⟩
      intro i hi
      have hi' := hN i hi
      by_contra! hh
      exact h ⟨i, by omega⟩

private theorem force_at (s x n : ℕ) (par : x%2 = (s+n+1)%2)
    (sh : Share (walk s n) x) (big : x < walk s (n+1)) : ∃ i, walk s i = x := by
  by_contra! hh
  have := (step s n).2 x ⟨par, sh, fun i => hh i.val⟩
  omega

private theorem hub_occurs (s t r : ℕ) (hr : r < 2) : ∃ i, walk s i = hub t r := by
  obtain ⟨N,hN⟩ := eventually_large _ (injective s) (hub t r)
  let n := 2*N+s+1+r
  apply force_at s (hub t r) n
  · dsimp [n,hub]; omega
  · exact universal _ _ _ hr
  · apply hN; dsimp [n]; omega

theorem permutation (s : ℕ) : Function.Bijective (walk s) := by
  refine ⟨injective s, ?_⟩
  intro x
  obtain ⟨N,hN⟩ := eventually_large _ (injective s) x
  obtain ⟨B,hB⟩ := bounded_prefix (walk s) N
  let r := (x+1)%2
  have hr : r < 2 := Nat.mod_lt _ (by decide)
  obtain ⟨i,hi⟩ := hub_occurs s B r hr
  have late : N < i := by
    by_contra! h
    have := hB i h
    unfold hub at hi; omega
  obtain ⟨j,rfl⟩ := Nat.exists_eq_succ_of_ne_zero (show i ≠ 0 by omega)
  apply force_at s x (j+1)
  · have hpar := (step s j).1.1
    rw [hi] at hpar; dsimp [hub,r] at hpar; omega
  · rw [hi]
    obtain ⟨d,hx,hu⟩ := universal x B r hr
    exact ⟨d,hu,hx⟩
  · apply hN; omega

theorem a318698 : Function.Bijective (walk 0) := permutation 0
theorem a318699 : Function.Bijective (walk 1) := permutation 1

#print axioms a318698
#print axioms a318699
end Navarrete

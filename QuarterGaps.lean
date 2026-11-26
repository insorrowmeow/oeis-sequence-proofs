import Mathlib.Data.Nat.Sqrt
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.Ring

/-! The units digit of the greedy quarter-square representation (OEIS A376450).
    A376453 consists of the natural numbers whose units digit is one. -/
namespace QuarterGaps

/-- The place values, allowing zero as a harmless sentinel. -/
def IsPlace (a : ℕ) : Prop := ∃ k : ℕ, a = k * k ∨ a = k * (k+1)

theorem quarter_places (a : ℕ) : IsPlace a ↔ ∃ j : ℕ, a = j^2 / 4 := by
  have he (k : ℕ) : (2*k)^2 / 4 = k*k := by
    rw [show (2*k)^2 = 4*(k*k) by ring]; omega
  have ho (k : ℕ) : (2*k+1)^2 / 4 = k*(k+1) := by
    rw [show (2*k+1)^2 = 4*(k*(k+1))+1 by ring]; omega
  constructor
  · rintro ⟨k,rfl | rfl⟩
    · exact ⟨_, (he k).symm⟩
    · exact ⟨_, (ho k).symm⟩
  · rintro ⟨j,rfl⟩
    refine ⟨j/2, ?_⟩
    rcases (show j = 2*(j/2) ∨ j = 2*(j/2)+1 by omega) with hj | hj
    · exact Or.inl ((congrArg (fun x : ℕ => x^2 / 4) hj).trans (he _))
    · exact Or.inr ((congrArg (fun x : ℕ => x^2 / 4) hj).trans (ho _))

def place (n : ℕ) : ℕ :=
  let k := n.sqrt
  if k * (k+1) ≤ n then k * (k+1) else k*k

theorem place_spec (n : ℕ) :
    IsPlace (place n) ∧ place n ≤ n ∧ ∀ a, IsPlace a → a ≤ n → a ≤ place n := by
  have hsq := Nat.sqrt_le n
  simp only [place]
  split <;> rename_i h
  · refine ⟨⟨_, Or.inr rfl⟩, h, ?_⟩
    rintro a ⟨j, rfl | rfl⟩ ha
    · have hj := Nat.le_sqrt.mpr ha
      exact Nat.mul_le_mul hj (by omega)
    · have hj : j ≤ n.sqrt := Nat.le_sqrt.mpr (by nlinarith)
      exact Nat.mul_le_mul hj (by omega)
  · refine ⟨⟨_, Or.inl rfl⟩, hsq, ?_⟩
    rintro a ⟨j, rfl | rfl⟩ ha
    · exact Nat.mul_self_le_mul_self (Nat.le_sqrt.mpr ha)
    · have hj : j ≤ n.sqrt := Nat.le_sqrt.mpr (by nlinarith)
      have hne : j ≠ n.sqrt := by
        intro he
        exact h (he ▸ ha)
      have hlt : j < n.sqrt := by omega
      exact Nat.mul_le_mul hj hlt

private theorem place_pos {n : ℕ} (hn : 0 < n) : 0 < place n :=
  (place_spec n).2.2 1 ⟨1, Or.inl rfl⟩ hn

/-- Subtract the largest usable denomination until the remainder is 0 or 1. -/
def digit (n : ℕ) : ℕ :=
  if n ≤ 1 then n else digit (n - place n)
termination_by n
decreasing_by exact Nat.sub_lt (by omega) (place_pos (by omega))

@[simp] theorem digit_zero : digit 0 = 0 := by rw [digit]; rfl
@[simp] theorem digit_one : digit 1 = 1 := by rw [digit]; rfl

theorem digit_step {n : ℕ} (hn : 1 < n) : digit n = digit (n - place n) := by
  rw [digit]; simp [show ¬ n ≤ 1 by omega]

theorem digit_binary (n : ℕ) : digit n ≤ 1 := by
  induction n using Nat.strong_induction_on with
  | h n ih =>
    by_cases hs : n ≤ 1
    · rw [digit, if_pos hs]; exact hs
    · rw [digit_step (by omega)]
      exact ih _ (Nat.sub_lt (by omega) (place_pos (by omega)))

theorem digit_three : digit 3 = 1 := by
  rw [digit_step (by decide : 1 < 3), show 3 - place 3 = 1 by decide, digit_one]

/-- No two consecutive natural numbers both end in one. -/
theorem separated (n : ℕ) : ¬ (digit n = 1 ∧ digit (n+1) = 1) := by
  induction n using Nat.strong_induction_on with
  | h n ih =>
    by_cases hsmall : n ≤ 1
    · rcases (show n = 0 ∨ n = 1 by omega) with rfl | rfl
      · simp
      · have htwo : digit 2 = 0 := by
          rw [digit_step (by decide : 1 < 2), show 2 - place 2 = 0 by decide, digit_zero]
        simp [htwo]
    · by_cases he : place (n+1) = n+1
      · rw [digit_step (show 1 < n+1 by omega), he, Nat.sub_self, digit_zero]
        simp
      · have hbound := (place_spec (n+1)).2.1
        have same : place (n+1) = place n := Nat.le_antisymm
          ((place_spec n).2.2 _ (place_spec (n+1)).1 (by omega))
          ((place_spec (n+1)).2.2 _ (place_spec n).1 (by have := (place_spec n).2.1; omega))
        have rec := ih (n-place n) (Nat.sub_lt (by omega) (place_pos (by omega)))
        have hall := (place_spec n).2.1
        rwa [digit_step (show 1 < n by omega), digit_step (show 1 < n+1 by omega), same,
          show n+1-place n = (n-place n)+1 by omega]

/-- Consecutive members of A376453, described without indexing an infinite list. -/
def Gap (a b : ℕ) : Prop :=
  a < b ∧ digit a = 1 ∧ digit b = 1 ∧ ∀ j, a < j → j < b → digit j = 0

theorem base_gap : Gap 1 3 := by
  refine ⟨by decide, digit_one, digit_three, ?_⟩
  intro j hj h3
  obtain rfl : j = 2 := by omega
  rw [digit_step (by decide : 1 < 2), show 2 - place 2 = 0 by decide, digit_zero]

private theorem pronic_copy (k r : ℕ) (hk : 1 ≤ k) (hr : r ≤ k) :
    digit (k*(k+1)+r) = digit r := by
  have root : (k*(k+1)+r).sqrt = k := (Nat.eq_sqrt.mpr ⟨by nlinarith, by nlinarith⟩).symm
  rw [digit_step (show 1 < k*(k+1)+r by nlinarith)]
  simp [place, root]

private theorem square_copy (k r : ℕ) (hk : 2 ≤ k) (hr : r < k) :
    digit (k*k+r) = digit r := by
  have root : (k*k+r).sqrt = k := (Nat.eq_sqrt.mpr ⟨by omega, by nlinarith⟩).symm
  rw [digit_step (show 1 < k*k+r by nlinarith)]
  simp [place, root, show ¬ k*(k+1) ≤ k*k+r by nlinarith]

/-- A gap ending at k+1 lifts across the next square, gaining one unit. -/
theorem lift_gap (a k : ℕ) (hk : 1 ≤ k) (h : Gap a (k+1)) :
    Gap (k*(k+1)+a) ((k+1)*(k+1)+1) := by
  obtain ⟨hab, ha, _, hbetween⟩ := h
  have edge : (k+1)*(k+1) = k*(k+1)+(k+1) := by ring
  refine ⟨by omega, (pronic_copy k a hk (by omega)).trans ha,
    (square_copy (k+1) 1 (by omega) (by omega)).trans digit_one, ?_⟩
  intro j hj hend
  by_cases he : j = (k+1)*(k+1)
  · subst j
    simpa using (square_copy (k+1) 0 (by omega) (by omega)).trans digit_zero
  · let r := j-k*(k+1)
    have hjr : j = k*(k+1)+r := by dsimp [r]; omega
    have hlow : a < r := by omega
    have hupp : r < k+1 := by omega
    rw [hjr, pronic_copy k r hk (by omega)]
    exact hbetween _ hlow hupp

theorem spectrum (d : ℕ) : (∃ a b, Gap a b ∧ b-a = d) ↔ 2 ≤ d := by
  constructor
  · rintro ⟨a,b,⟨hab,ha,hb,_⟩,rfl⟩
    have h := separated a
    by_contra! hh
    have : b = a+1 := by omega
    exact h ⟨ha, this ▸ hb⟩
  · intro hd
    obtain ⟨t, rfl⟩ := Nat.exists_eq_add_of_le hd
    induction t with
    | zero => exact ⟨1, 3, base_gap, rfl⟩
    | succ t ih =>
      obtain ⟨a, b, hg, hlen⟩ := ih (by omega)
      cases b with
      | zero => omega
      | succ k =>
        have hh := lift_gap a k (by omega) hg
        refine ⟨_,_,hh,?_⟩
        have edge : (k+1)*(k+1) = k*(k+1)+(k+1) := by ring
        omega

theorem explicit_six : Gap 104080799 104080805 := by
  have h3 := lift_gap 1 2 (by decide) base_gap
  have h4 := lift_gap 7 9 (by decide) h3
  have h5 := lift_gap 97 100 (by decide) h4
  exact lift_gap 10197 10201 (by decide) h5

/-- Every permitted gap occurs arbitrarily far along the sequence. -/
theorem recurrent_gaps (d N : ℕ) (hd : 2 ≤ d) :
    ∃ a b, N < a ∧ Gap a b ∧ b-a = d := by
  obtain ⟨a,b,hg,hlen⟩ := (spectrum d).mpr hd
  obtain ⟨hab,ha,hb,hbetween⟩ := hg
  let k := N+b+2
  have hk : 2 ≤ k := by dsimp [k]; omega
  have hbk : b < k := by dsimp [k]; omega
  have hNk : N < k := by dsimp [k]; omega
  have hsize : k ≤ k*k := by nlinarith [Nat.mul_le_mul_left k (show 1 ≤ k by omega)]
  refine ⟨k*k+a, k*k+b, by omega, ⟨by omega, (square_copy _ _ hk (by omega)).trans ha,
    (square_copy _ _ hk hbk).trans hb, ?_⟩, by omega⟩
  intro j hj hj'
  let r := j-k*k
  have hr : j = k*k+r := by dsimp [r]; omega
  rw [hr, square_copy _ _ hk (by omega)]
  exact hbetween _ (by omega) (by omega)

#print axioms spectrum
#print axioms explicit_six
#print axioms recurrent_gaps
end QuarterGaps

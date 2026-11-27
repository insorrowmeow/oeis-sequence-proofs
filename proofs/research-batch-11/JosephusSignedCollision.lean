import Mathlib.Tactic.Linarith
import Mathlib.Tactic.Ring
import Mathlib.Algebra.Order.Ring.Abs

namespace JosephusSignedCollision

/-- One stage of the trajectory in the question. -/
def update (s x : ℤ) : ℤ := |x - s - x % s|

def B : ℕ → ℤ → ℤ
  | 0, t => t
  | s+1, t => update (s+1) (B s t)

/-- Survivor count among the first r positions after deleting every (s+1)-st. -/
def count (s r : ℤ) : ℤ := r - r / (s+1)

private theorem update_quot (s x : ℤ) (hs : 0 ≤ s) :
    update s x = s * |x / s - 1| := by
  unfold update
  have h : x - s - x % s = s * (x / s - 1) := by
    nlinarith [Int.ediv_add_emod x s]
  rw [h, abs_mul, abs_of_nonneg hs]

private theorem rank_update (s r : ℤ) (hs : 0 < s) :
    update (s+1) (s*(r-s)) = (s+1) * |count s r - (s+1)| := by
  have hp : 0 < s + 1 := by omega
  have hlo := Int.emod_nonneg r (ne_of_gt hp)
  have hhi := Int.emod_lt_of_pos r hp
  have hqr := Int.ediv_add_emod r (s+1)
  have h : (s * (r-s)) / (s+1) = r - r / (s+1) - s := by
    apply (Int.ediv_eq_iff_of_pos hp).2
    constructor <;> nlinarith
  rw [update_quot _ _ (by omega), h]
  unfold count
  congr 2
  ring

private theorem count_neighbors (s r : ℤ) (hs : 0 < s) :
    count s (r-1) = if r % (s+1) = 0 then count s r else count s r - 1 := by
  have hp : 0 < s+1 := by omega
  have hr := Int.ediv_add_emod r (s+1)
  have hlo := Int.emod_nonneg r (ne_of_gt hp)
  have hhi := Int.emod_lt_of_pos r hp
  unfold count
  split <;> rename_i hc
  · have hq : (r-1)/(s+1)=r/(s+1)-1 := by
      apply (Int.ediv_eq_iff_of_pos hp).2
      constructor <;> nlinarith
    omega
  · have hq : (r-1)/(s+1)=r/(s+1) := by
      have : 1 ≤ r % (s+1) := by omega
      apply (Int.ediv_eq_iff_of_pos hp).2
      constructor <;> nlinarith
    omega

/-- Sieve outcome for an active entry currently in position r before round s.
A true flag means a permanent survivor of the indicated final rank. -/
inductive Fate : ℕ → ℤ → Bool → ℕ → Prop
  | survivor (s : ℕ) : Fate s s true s
  | deleted {s : ℕ} {r : ℤ} (h : r % (s+1) = 0) : Fate s r false s
  | later {s j : ℕ} {r : ℤ} {f : Bool} (hr : (s:ℤ) < r)
      (h : r % (s+1) ≠ 0) (tail : Fate (s+1) (count s r) f j) : Fate s r f j

private theorem count_live (s r : ℤ) (hs : 0 < s) (hlt : s < r)
    (hn : r % (s+1) ≠ 0) : s+1 ≤ count s r := by
  have hp : 0 < s+1 := by omega
  have hr := Int.ediv_add_emod r (s+1)
  have hlo := Int.emod_nonneg r (ne_of_gt hp)
  have hq := Int.ediv_nonneg (a:=r) (b:=s+1) (by omega) (by omega)
  unfold count
  by_cases h : r / (s+1) = 0
  · omega
  · have hh : 0 ≤ (r/(s+1)-1) * s := mul_nonneg (by omega) (by omega)
    have : 1 ≤ r % (s+1) := by omega
    nlinarith

private theorem fate_exists (s : ℕ) (r : ℤ) (hs : 0 < s) (hr : (s:ℤ) ≤ r) :
    ∃ f j, Fate s r f j := by
  by_cases he : r = s
  · exact ⟨true, s, he ▸ Fate.survivor s⟩
  by_cases hd : r % (s+1) = 0
  · exact ⟨false, s, Fate.deleted hd⟩
  have hs' : 0 < (s:ℤ) := by exact_mod_cast hs
  have hl : (s:ℤ) < r := by omega
  have hc := count_live s r hs' hl hd
  obtain ⟨f,j,h⟩ := fate_exists (s+1) (count s r) (by omega) (by exact_mod_cast hc)
  exact ⟨f,j,Fate.later hl hd h⟩
termination_by (r-(s:ℤ)).toNat
decreasing_by
  unfold count
  have := Int.ediv_nonneg (a:=r) (b:=(s:ℤ)+1) (by omega) (by omega)
  omega

/-- This expresses both the least collision time j+1 and the sign at j. -/
def Collision (n : ℤ) (f : Bool) (j : ℕ) : Prop :=
  (∀ k ≤ j, B k n ≠ B k (n-1)) ∧ B (j+1) n = B (j+1) (n-1) ∧
    B j n - B j (n-1) = if f then -(j:ℤ) else (j:ℤ)

private theorem earlier {n : ℤ} {s : ℕ}
    (he : ∀ k < s, B k n ≠ B k (n-1)) (h : B s n ≠ B s (n-1)) :
    ∀ k ≤ s, B k n ≠ B k (n-1) := by
  intro k hk
  obtain rfl|hlt := eq_or_lt_of_le hk
  · exact h
  · exact he k hlt

private theorem classify {s j : ℕ} {r n : ℤ} {f : Bool} (hf : Fate s r f j)
    (hs : 0 < s) (hr : (s:ℤ) ≤ r) (h₁ : B s n = s * |r-s|)
    (h₂ : B s (n-1) = s * |(r-1)-s|) (he : ∀ k < s, B k n ≠ B k (n-1)) :
    Collision n f j := by
  induction hf with
  | survivor s =>
    have hc : (s:ℤ)-1-s = -1 := by ring
    simp [hc] at h₁ h₂
    have hne : B s n ≠ B s (n-1) := by omega
    refine ⟨earlier he hne, ?_, ?_⟩
    · simp only [B, h₁, h₂, Nat.cast_add, Nat.cast_one]
      rw [update_quot _ _ (by omega), update_quot _ _ (by omega)]
      rw [Int.ediv_eq_zero_of_lt (a := (s:ℤ)) (by omega) (by omega), Int.zero_ediv]
    · simp [h₁, h₂]
  | @deleted s r hd =>
    have hs' : 0 < (s:ℤ) := by exact_mod_cast hs
    have hl : (s:ℤ) < r := by
      by_contra! h
      have heq : r = s := by omega
      rw [heq, Int.emod_eq_of_lt (by omega) (by omega)] at hd
      omega
    rw [abs_of_nonneg (by omega)] at h₁ h₂
    have hdiff : B s n - B s (n-1) = s := by rw [h₁,h₂]; ring
    refine ⟨earlier he (by omega), ?_, hdiff⟩
    simp only [B, h₁, h₂, Nat.cast_add, Nat.cast_one]
    rw [rank_update _ _ hs', rank_update _ _ hs', count_neighbors _ _ hs', if_pos hd]
  | @later s j r f hl hd tail ih =>
    have hs' : 0 < (s:ℤ) := by exact_mod_cast hs
    rw [abs_of_nonneg (by omega)] at h₁ h₂
    have hdiff : B s n - B s (n-1) = s := by rw [h₁,h₂]; ring
    apply ih (by omega) (by exact_mod_cast count_live s r hs' hl hd)
    · simp only [B, h₁, Nat.cast_add, Nat.cast_one]
      exact rank_update _ _ hs'
    · simp only [B, h₂, Nat.cast_add, Nat.cast_one]
      rw [rank_update _ _ hs', count_neighbors _ _ hs', if_neg hd]
    · exact fun k hk => earlier he (by omega) k (by omega)

/-- Its sieve outcome uniquely determines the first collision and its sign. -/
theorem outcome_collision {n j : ℕ} {f : Bool} (hn : 1 ≤ n) (hf : Fate 1 n f j) :
    Collision n f j := by
  apply classify hf (by decide) (by exact_mod_cast hn)
  · simp [B, update]
  · simp [B, update]
  · intro k hk
    have : k = 0 := by omega
    simp [this, B]
    omega

/-- Every input admits a signed collision in the round following its sieve outcome. -/
theorem signed_first_collision (n : ℕ) (hn : 1 ≤ n) :
    ∃ f j, Fate 1 n f j ∧ Collision n f j := by
  obtain ⟨f,j,hf⟩ := fate_exists 1 n (by decide) (by exact_mod_cast hn)
  exact ⟨f,j,hf,outcome_collision hn hf⟩

end JosephusSignedCollision

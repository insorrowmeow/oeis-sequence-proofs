import Mathlib.Data.Nat.Basic
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.Ring

namespace IndexPermutations

/-- A block argument for sequences with linear resets and integer divisions. -/
theorem covers (f : ℕ → ℕ) (M D : ℕ) (hM : 0 < M) (hD : 1 < D)
    (hpos : ∀ i, 0 < i → 0 < f i) (hbound : ∀ i, f i ≤ M*i)
    (hparent : ∀ i, ∃ j, f j = f i / D)
    (hstep : ∀ i, 2 ≤ i → f (i+1) = f i / D ∨ f (i+1) = M*(i+1)) :
    ∀ n, 0 < n → ∃ i, f i = n := by
  intro n hn
  by_contra hmissing
  have ancestor (i e : ℕ) : ∃ j, f j = f i / D^e := by
    induction e with
    | zero => exact ⟨i, by simp⟩
    | succ e ih =>
      obtain ⟨j,hj⟩ := ih
      obtain ⟨l,hl⟩ := hparent j
      exact ⟨l, by rw [hl,hj,Nat.div_div_eq_div_mul,pow_succ]⟩
  let s := 4*M+n+4
  let h := s+s
  let W := D^h
  have hs : s < D^s := Nat.lt_pow_self hD
  have hW : W = D^s * D^s := by dsimp [W,h]; rw [pow_add]
  have hsq : s*s < W := hW ▸ Nat.mul_self_lt_mul_self hs
  have haux : 4*M ≤ s := by dsimp [s]; omega
  have hN : n < s := by dsimp [s]; omega
  have hlen : M*(h+h) < W := by
    have hc := Nat.mul_le_mul_right s haux
    dsimp [h]; nlinarith
  have hnW : n < W := by nlinarith [Nat.le_mul_self s]
  have hwp : 0 < W := by omega
  let T := W*n/M
  have hlo : M*T ≤ W*n := Nat.mul_div_le _ _
  have hhi : W*n < M*(T+1) := by
    have hrem := Nat.mod_lt (W*n) hM
    have heq := Nat.mod_add_div (W*n) M
    dsimp [T]; rw [Nat.mul_add]; omega
  have ht : 2 ≤ T := by
    have : 2*M ≤ W := by
      have h1 : 2 ≤ h+h := by dsimp [s,h]; omega
      have := Nat.mul_le_mul_left M h1
      nlinarith
    have hww : W ≤ W*n := by simpa using Nat.mul_le_mul_left W hn
    exact (Nat.le_div_iff_mul_le hM).mpr (by omega)
  have descend (l : ℕ) (hl : l ≤ h+h) : f (T+l) = f T / D^l := by
    induction l with
    | zero => simp
    | succ l ih =>
      rcases hstep (T+l) (by omega) with hh | hh
      · rw [show T+(l+1) = (T+l)+1 by omega, hh, ih (by omega), Nat.div_div_eq_div_mul, pow_succ]
      · exfalso
        apply hmissing
        obtain ⟨j,hj⟩ := ancestor ((T+l)+1) h
        refine ⟨j,?_⟩
        rw [hj,hh]
        change M*(T+l+1) / W = n
        have hlow : W*n ≤ M*(T+l+1) := by
          have := Nat.mul_le_mul_left M (show T+1 ≤ T+l+1 by omega)
          omega
        have hhigh : M*(T+l+1) < W*(n+1) := by
          have := Nat.mul_le_mul_left M hl
          nlinarith [show M*(T+l+1) = M*T + M*(l+1) by ring]
        exact Nat.le_antisymm (by
          have := (Nat.div_lt_iff_lt_mul hwp).mpr (show M*(T+l+1) < (n+1)*W by nlinarith)
          omega) ((Nat.le_div_iff_mul_le hwp).mpr (by nlinarith))
  have hlast := descend (h+h) le_rfl
  have hsmall : f T < D^(h+h) := by
    rw [pow_add]
    change f T < W*W
    exact lt_of_le_of_lt ((hbound T).trans hlo) ((Nat.mul_lt_mul_left hwp).mpr hnW)
  rw [Nat.div_eq_of_lt hsmall] at hlast
  have := hpos (T+(h+h)) (by omega)
  omega

/-- At time zero the stored sentinel forbids zero. Two supplied positive seeds
    let the same implementation cover the two-seed variant A050138 as well. -/
def history (M D u v : ℕ) : ℕ → List ℕ
  | 0 => [0]
  | 1 => [u,0]
  | 2 => [v,u,0]
  | t+3 =>
    let past := history M D u v (t+2)
    let q := past.headD 0 / D
    (if q ∈ past then M*(t+3) else q) :: past

def value (M D u v t : ℕ) := (history M D u v t).headD 0

section
variable (M D u v : ℕ)
local notation "H" => history M D u v
local notation "f" => value M D u v

private theorem hist_succ (i : ℕ) : H (i+1) = f (i+1) :: H i := by
  rcases i with _ | _ | i <;> rfl

private theorem hist_mem (i x : ℕ) : x ∈ H i ↔ ∃ j ≤ i, f j = x := by
  induction i with
  | zero => simp [history,value,eq_comm]
  | succ i ih =>
    rw [hist_succ,List.mem_cons,ih]
    constructor
    · rintro (rfl | ⟨j,hj,hv⟩)
      · exact ⟨_,le_rfl,rfl⟩
      · exact ⟨j,by omega,hv⟩
    · rintro ⟨j,hj,hv⟩
      rcases (show j = i+1 ∨ j ≤ i by omega) with rfl | h
      · exact Or.inl hv.symm
      · exact Or.inr ⟨_,h,hv⟩

private theorem rec_step (i : ℕ) (hi : 2 ≤ i) : f (i+1) =
    if f i / D ∈ H i then M*(i+1) else f i / D := by
  rcases i with _ | _ | i <;> first | omega | rfl

/-- Sufficient seed conditions: the two supplied seeds are admissible,
    and the quotient of the first seed is eventually present. -/
theorem permutation (hM : 0 < M) (hD : 1 < D) (hu : 0 < u) (hub : u ≤ M)
    (hv : 0 < v) (hvb : v ≤ M*2) (hne : u ≠ v)
    (hseed : ∃ j, f j = u/D) : Function.Bijective f := by
  have bound (i : ℕ) : f i ≤ M*i := by
    induction i with
    | zero => exact Nat.zero_le _
    | succ i ih =>
      rcases i with _ | _ | t
      · simpa [value,history] using hub
      · exact hvb
      · rw [rec_step _ _ _ _ _ (by omega)]
        split
        · exact le_rfl
        · exact le_trans (Nat.div_le_self _ _) (ih.trans (Nat.mul_le_mul_left _ (by omega)))
  have fresh (i j : ℕ) (hj : j < i) : f i ≠ f j := by
    rcases i with _ | _ | _ | t
    · omega
    · obtain rfl : j = 0 := by omega
      exact Nat.ne_of_gt hu
    · rcases (show j=0 ∨ j=1 by omega) with rfl | rfl
      · exact Nat.ne_of_gt hv
      · exact hne.symm
    · rw [rec_step _ _ _ _ _ (by omega)]
      split <;> rename_i hh
      · have := bound j
        exact Nat.ne_of_gt ((Nat.mul_lt_mul_left hM).mpr hj |> lt_of_le_of_lt this)
      · intro he
        exact hh ((hist_mem _ _ _ _ _ _).mpr ⟨j,by omega,he.symm⟩)
  have pos (i : ℕ) (hi : 0 < i) : 0 < f i := Nat.pos_of_ne_zero (fresh i 0 hi)
  have parent (i : ℕ) : ∃ j, f j = f i / D := by
    rcases i with _ | _ | t
    · exact ⟨0, by change 0 = 0/D; simp⟩
    · exact hseed
    · by_cases hm : f (t+2)/D ∈ H (t+2)
      · obtain ⟨j,_,hj⟩ := (hist_mem _ _ _ _ _ _).mp hm
        exact ⟨_,hj⟩
      · exact ⟨t+3, by rw [rec_step _ _ _ _ _ (by omega),if_neg hm]⟩
  constructor
  · intro i j he
    rcases lt_trichotomy i j with h | h | h
    · exact False.elim ((fresh j i h) he.symm)
    · exact h
    · exact False.elim ((fresh i j h) he)
  · intro n
    cases n with
    | zero => exact ⟨0,rfl⟩
    | succ n =>
      apply covers f M D hM hD pos bound parent _ (n+1) (by omega)
      intro i hi
      rw [rec_step _ _ _ _ i hi]
      split <;> simp
end

/-- When the first seed is 1 the prescribed second term is 2*M. -/
theorem standard (M D : ℕ) (hM : 0 < M) (hD : 1 < D) :
    Function.Bijective (value M D 1 (M*2)) := by
  apply permutation M D 1 (M*2) hM hD (by decide) hM (by omega) le_rfl (by omega)
  exact ⟨0, (Nat.div_eq_of_lt hD).symm⟩

theorem a050128 : Function.Bijective (value 2 2 1 4) := standard 2 2 (by decide) (by decide)
theorem a050135 : Function.Bijective (value 4 2 1 8) := standard 4 2 (by decide) (by decide)
theorem a050136 : Function.Bijective (value 5 2 1 10) := standard 5 2 (by decide) (by decide)

theorem a050137 : Function.Bijective (value 2 2 2 1) := by
  apply permutation <;> first | decide | exact ⟨2,rfl⟩

theorem a050138 : Function.Bijective (value 3 2 2 6) := by
  apply permutation <;> first | decide | exact ⟨4,rfl⟩

#print axioms standard
#print axioms a050137
#print axioms a050138
end IndexPermutations

import Mathlib.Combinatorics.Young.SemistandardTableau
import Mathlib.Algebra.BigOperators.Group.Finset.Basic
import Mathlib.SetTheory.Cardinal.Finite
import Mathlib.Algebra.Polynomial.Coeff
import Mathlib.Tactic.Linarith

/-! A determinant-shift counterexample to Pak--Panova, section 3.5.
    The alphabet is 0,...,n and the shape is an (n+1)-square with
    two additional boxes at the end of the first row. -/

namespace SchurPlateaus
open Finset

def square (n : ℕ) := (range (n+1)) ×ˢ (range (n+1))

@[simp] theorem mem_square {n i j : ℕ} :
    (i,j) ∈ square n ↔ i ≤ n ∧ j ≤ n := by simp [square, Nat.lt_succ_iff]

def shape (n : ℕ) : YoungDiagram where
  cells := insert (0,n+2) (insert (0,n+1) (square n))
  isLowerSet := by
    rintro ⟨k,l⟩ ⟨i,j⟩ h hc
    have hi : i ≤ k := h.1
    have hj : j ≤ l := h.2
    change (k,l) ∈ insert _ (insert _ (square n)) at hc
    change (i,j) ∈ insert _ (insert _ (square n))
    simp only [mem_insert, Prod.mk.injEq, mem_square] at hc ⊢
    omega

@[simp] theorem mem_shape {n i j : ℕ} :
    (i,j) ∈ shape n ↔ (i=0 ∧ j=n+2) ∨ (i=0 ∧ j=n+1) ∨ i ≤ n ∧ j ≤ n := by
  change (i,j) ∈ insert _ (insert _ (square n)) ↔ _
  simp only [mem_insert, Prod.mk.injEq, mem_square]

theorem square_exact (n k : ℕ) :
    (∀ i < k, ∀ j < k, (i,j) ∈ shape n) ↔ k ≤ n+1 := by
  constructor
  · intro H
    by_contra! hk
    have h := H (n+1) (by omega) 0 (by omega)
    simp at h
  · intro H i hi j hj
    exact mem_shape.mpr (Or.inr (Or.inr ⟨by omega,by omega⟩))

abbrev Bounded (μ : YoungDiagram) (n : ℕ) :=
  {T : SemistandardYoungTableau μ // ∀ i j, T i j ≤ n}

def weight {μ : YoungDiagram} (T : SemistandardYoungTableau μ) :=
  ∑ c ∈ μ.cells, T c.1 c.2

noncomputable def coeff (μ : YoungDiagram) (n k : ℕ) :=
  Nat.card {T : Bounded μ n // weight T.val = k}

def base (n : ℕ) := ∑ c ∈ square n, c.1

private theorem column_gap {n j : ℕ} (T : Bounded (shape n) n) (hj : j ≤ n)
    (i k : ℕ) (hi : i+k ≤ n) : T.val i j + k ≤ T.val (i+k) j := by
  induction k with
  | zero => simp
  | succ k ih =>
    have hprev := ih (by omega)
    have hnext := T.val.col_strict (j:=j) (show i+k < i+(k+1) by omega)
      (mem_shape.mpr (Or.inr (Or.inr ⟨hi,hj⟩)))
    omega

theorem forced {n i j : ℕ} (T : Bounded (shape n) n) (hi : i ≤ n) (hj : j ≤ n) :
    T.val i j = i := by
  have hlow := column_gap T hj 0 i (by omega)
  have hhigh := column_gap T hj i (n-i) (by omega)
  have hcap := T.property (i+(n-i)) j
  simp only [zero_add] at hlow
  omega

def fill (n u v : ℕ) (hu : u ≤ v) (hv : v ≤ n) : Bounded (shape n) n := by
  let f (i j : ℕ) := if i ≤ n ∧ j ≤ n then i else
    if i=0 ∧ j=n+1 then u else if i=0 ∧ j=n+2 then v else 0
  refine ⟨⟨f, ?_, ?_, ?_⟩, ?_⟩
  · intro i j k h hc
    rw [mem_shape] at hc
    dsimp [f]
    split_ifs <;> omega
  · intro i k j h hc
    rw [mem_shape] at hc
    dsimp [f]
    split_ifs <;> omega
  · intro i j hc
    rw [mem_shape] at hc
    dsimp [f]
    split_ifs <;> omega
  · intro i j
    change f i j ≤ n
    dsimp [f]
    split_ifs <;> omega

@[simp] theorem fill_left {n u v} (hu : u ≤ v) (hv : v ≤ n) :
    (fill n u v hu hv).val 0 (n+1) = u := by
  change (if 0 ≤ n ∧ n+1 ≤ n then 0 else if 0=0 ∧ n+1=n+1 then u else _) = u
  simp

@[simp] theorem fill_right {n u v} (hu : u ≤ v) (hv : v ≤ n) :
    (fill n u v hu hv).val 0 (n+2) = v := by
  change (if 0 ≤ n ∧ n+2 ≤ n then 0 else if 0=0 ∧ n+2=n+1 then u else
    if 0=0 ∧ n+2=n+2 then v else 0) = v
  simp

theorem weight_eq {n} (T : Bounded (shape n) n) :
    weight T.val = base n + T.val 0 (n+1) + T.val 0 (n+2) := by
  have sq : (∑ c ∈ square n, T.val c.1 c.2) = base n := by
    apply sum_congr rfl
    rintro ⟨i,j⟩ hij
    exact forced T (mem_square.mp hij).1 (mem_square.mp hij).2
  simp [weight, shape, Finset.sum_insert, sq, add_comm, add_left_comm]

theorem tail_order {n} (T : Bounded (shape n) n) : T.val 0 (n+1) ≤ T.val 0 (n+2) :=
  T.val.row_weak (by omega) (mem_shape.mpr (Or.inl ⟨rfl,rfl⟩))

theorem bounded_ext {n} {T U : Bounded (shape n) n}
    (h1 : T.val 0 (n+1) = U.val 0 (n+1))
    (h2 : T.val 0 (n+2) = U.val 0 (n+2)) : T = U := by
  apply Subtype.ext
  apply SemistandardYoungTableau.ext
  intro i j
  by_cases h : (i,j) ∈ shape n
  · rcases mem_shape.mp h with ⟨rfl,rfl⟩ | ⟨rfl,rfl⟩ | ⟨hi,hj⟩
    · exact h2
    · exact h1
    · rw [forced T hi hj,forced U hi hj]
  · rw [T.val.zeros h, U.val.zeros h]

def coeffEquiv {n t} (ht : t ≤ n) :
    {T : Bounded (shape n) n // weight T.val = base n + t} ≃ Fin (t/2+1) where
  toFun T := ⟨T.val.val 0 (n+1), by
    have h := T.property
    rw [weight_eq] at h
    have ho := tail_order T.val
    omega⟩
  invFun k := ⟨fill n k.val (t-k.val) (by have := k.isLt; omega) (by omega), by
    rw [weight_eq,fill_left,fill_right]
    have := k.isLt
    omega⟩
  left_inv T := by
    apply Subtype.ext
    apply bounded_ext
    · simp
    · simp
      have h := T.property
      rw [weight_eq] at h
      omega
  right_inv k := by apply Fin.ext; simp

theorem coefficients {n t} (ht : t ≤ n) :
    coeff (shape n) n (base n+t) = t/2+1 := by
  unfold coeff
  rw [Nat.card_congr (coeffEquiv ht), Nat.card_eq_fintype_card, Fintype.card_fin]

theorem separated_plateaus {n k} (h : 2*k+1 ≤ n) :
    coeff (shape n) n (base n+2*k) = k+1 ∧
    coeff (shape n) n (base n+(2*k+1)) = k+1 := by
  rw [coefficients (show 2*k ≤ n by omega), coefficients h]
  omega

instance boundedFinite (μ : YoungDiagram) (n : ℕ) : Finite (Bounded μ n) := by
  let read (T : Bounded μ n) (c : ↥μ.cells) : Fin (n+1) :=
    ⟨T.val c.val.1 c.val.2,Nat.lt_succ_of_le (T.property _ _)⟩
  apply Finite.of_injective read
  intro T U eq
  apply Subtype.ext
  apply SemistandardYoungTableau.ext
  intro i j
  by_cases hc : (i,j) ∈ μ.cells
  · exact congrArg Fin.val (congrFun eq ⟨(i,j),hc⟩)
  · rw [T.val.zeros hc,U.val.zeros hc]

/-- The principal specialization of the Schur polynomial in n+1
    variables, by the semistandard-tableau definition. -/
noncomputable def schurPS (μ : YoungDiagram) (n : ℕ) : Polynomial ℕ :=
  letI := Fintype.ofFinite (Bounded μ n)
  ∑ T : Bounded μ n, Polynomial.X ^ weight T.val

theorem schur_coeff (μ : YoungDiagram) (n j : ℕ) :
    (schurPS μ n).coeff j = coeff μ n j := by
  classical
  letI := Fintype.ofFinite (Bounded μ n)
  unfold schurPS coeff
  rw [Polynomial.finset_sum_coeff,Nat.card_eq_fintype_card]
  simp [Polynomial.coeff_X_pow,Fintype.card_subtype,eq_comm]

def SupportEnds (f : ℕ → ℕ) (lo hi : ℕ) :=
  0 < f lo ∧ 0 < f hi ∧ ∀ i, i < lo ∨ hi < i → f i = 0

theorem support_ends (n : ℕ) : SupportEnds ((schurPS (shape n) n).coeff)
    (base n) (base n+2*n) := by
  simp only [SupportEnds,schur_coeff]
  refine ⟨?_,?_,?_⟩
  · have H := coefficients (n:=n) (t:=0) (Nat.zero_le _)
    simpa using H.ge.trans_lt' (show 0 < 1 by decide)
  · unfold coeff
    apply Nat.card_pos_iff.mpr
    refine ⟨⟨⟨fill n n n le_rfl le_rfl,?_⟩⟩,inferInstance⟩
    rw [weight_eq,fill_left,fill_right]
    omega
  · intro i h
    unfold coeff
    apply Nat.card_eq_zero.mpr
    apply Or.inl
    refine ⟨?_⟩
    intro T
    have hw := T.property
    rw [weight_eq] at hw
    have hlu := T.val.property 0 (n+1)
    have hlv := T.val.property 0 (n+2)
    omega

/-- The strict left-hand inequalities, skipping the first pair just
    as in Pak--Panova (Theorem 1, symbol (circle)). -/
def StrictLeft (f : ℕ → ℕ) (lo hi : ℕ) :=
  ∀ j, lo+1 ≤ j → 2*(j+1) ≤ lo+hi → f j < f (j+1)

theorem not_strict {n : ℕ} (h : 4 ≤ n) :
    ¬StrictLeft ((schurPS (shape n) n).coeff) (base n) (base n+2*n) := by
  intro H
  have e := H (base n+2) (by omega) (by omega)
  simp only [schur_coeff] at e
  have p := separated_plateaus (n:=n) (k:=1) (by omega)
  norm_num at p
  rw [show base n + 2 + 1 = base n + 3 by omega] at e
  omega

/-- No uniform Durfee threshold can force even the left-half strict
    inequalities of the principal specialization. -/
theorem no_durfee_threshold :
    ¬∃ D : ℕ, ∀ (μ : YoungDiagram) (n : ℕ),
      (∀ i < D, ∀ j < D, (i,j) ∈ μ) →
      ∀ lo hi, SupportEnds ((schurPS μ n).coeff) lo hi →
        StrictLeft ((schurPS μ n).coeff) lo hi := by
  rintro ⟨D,H⟩
  let n := D+4
  have sq := (square_exact n D).mpr (by dsimp [n];omega)
  exact not_strict (n:=n) (by dsimp [n];omega)
    (H (shape n) n sq _ _ (support_ends n))

#print axioms coefficients
#print axioms separated_plateaus
#print axioms no_durfee_threshold
end SchurPlateaus

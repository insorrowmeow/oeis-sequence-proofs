import Mathlib.Data.Nat.Basic
import Mathlib.Tactic.Linarith

namespace ReverseProductDigits

/-- Two-ended carry induction, in the column notation of Proposition 14 of
    Ezerman–Meyer–Solé. Both ends of the carry sequence are zero. -/
theorem all_carries_vanish {m : ℕ} (raw digit carry : ℕ → ℕ)
    (raw_sym : ∀ j<m, raw j=raw (m-1-j))
    (digit_sym : ∀ j<m, digit j=digit (m-1-j))
    (update : ∀ j<m, raw j + carry j = digit j + 10*carry (j+1))
    (first : carry 0=0) (last : carry m=0) :
    ∀ j≤m, carry j=0 ∧ carry (m-j)=0 := by
  intro j
  induction j with
  | zero => intro _; simpa using And.intro first last
  | succ j ih =>
    intro h
    have hj : j<m := by omega
    have hr : m-1-j<m := by omega
    obtain ⟨hl,ht⟩ := ih (by omega)
    have e₁ := update j hj
    have e₂ := update (m-1-j) hr
    rw [← raw_sym j hj, ← digit_sym j hj, show m-1-j+1=m-j by omega, ht] at e₂
    rw [hl] at e₁
    rw [show m-1-j=m-(j+1) by omega] at e₂
    constructor <;> omega

def weight : List ℕ → ℕ
  | [] => 0
  | x::xs => x*x + weight xs

private theorem twos (ds : List ℕ) : 4*ds.count 2 ≤ weight ds := by
  induction ds with
  | nil => decide
  | cons a ds ih =>
    by_cases h : a=2
    · subst a; simp [List.count_cons,weight]; omega
    · simp [List.count_cons,h,weight]; omega

private theorem ends (a b : ℕ) (ds : List ℕ) :
    weight (a::(ds++[b])) = a*a+weight ds+b*b := by
  suffices weight (ds++[b]) = weight ds + b*b by simp [weight,this,Nat.add_assoc]
  induction ds with
  | nil => simp [weight]
  | cons x xs ih => simp [weight,ih,Nat.add_assoc]

/-- With two nonzero endpoints different from two, a digit-square budget of
    nine permits at most one interior two. -/
theorem at_most_one_two {a b : ℕ} (ds : List ℕ)
    (ha : 0<a) (hb : 0<b) (ha₂ : a≠2) (hb₂ : b≠2)
    (h : weight (a::(ds++[b])) < 10) :
    (a::(ds++[b])).count 2 ≤ 1 := by
  rw [ends] at h
  have hh := twos ds
  have pa : 0<a*a := Nat.mul_pos ha ha
  have pb : 0<b*b := Nat.mul_pos hb hb
  simp [List.count_cons,List.count_append,ha₂,hb₂]
  omega

theorem unequal_extreme_and_central {a b : ℕ} (ds : List ℕ) (ha : 0<a) (hb : 0<b) :
    a*b < weight (a::(ds++[b])) := by
  rw [ends]
  nlinarith [sq_nonneg ((a:ℤ)-b),Nat.mul_pos ha hb]

#print axioms all_carries_vanish
#print axioms at_most_one_two
end ReverseProductDigits

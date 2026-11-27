import Mathlib.Data.Nat.Fib.Basic
import Mathlib.Data.List.OfFn

namespace FibonacciCycleWords

inductive Letter where | A | B
  deriving DecidableEq
open Letter
abbrev Word := List Letter

/-- The two iterates of A ↦ AB and B ↦ A. -/
def blocks : ℕ → Word × Word
  | 0 => ([A],[B])
  | j+1 => ((blocks j).1 ++ (blocks j).2, (blocks j).1)

def X (j : ℕ) := (blocks j).1 ++ (blocks j).2 ++ (blocks j).1
def Y (j : ℕ) := (blocks j).2 ++ (blocks j).1 ++ (blocks j).1
def doubled (j : ℕ) := X j ++ X j ++ Y j ++ Y j

theorem block_lengths (j : ℕ) :
    (blocks j).1.length=Nat.fib (j+2) ∧ (blocks j).2.length=Nat.fib (j+1) := by
  induction j with
  | zero => decide
  | succ j ih =>
    change ((blocks j).1 ++ (blocks j).2).length=Nat.fib ((j+1)+2) ∧
      (blocks j).1.length=Nat.fib (j+2)
    rw [List.length_append,ih.1,ih.2,Nat.fib_add_two (n:=j+1)]
    change Nat.fib (j+2)+Nat.fib (j+1)=Nat.fib (j+1)+Nat.fib (j+2) ∧ _
    omega

theorem conjugate_lengths (j : ℕ) : (X j).length=Nat.fib (j+4) ∧ (Y j).length=Nat.fib (j+4) := by
  obtain ⟨hp,hq⟩ := block_lengths j
  have h3 : Nat.fib (j+3)=Nat.fib (j+1)+Nat.fib (j+2) := Nat.fib_add_two (n:=j+1)
  have h4 : Nat.fib (j+4)=Nat.fib (j+2)+Nat.fib (j+3) := Nat.fib_add_two (n:=j+2)
  simp only [X,Y,List.length_append,hp,hq]
  omega

theorem five_steps (j : ℕ) : (blocks (j+5)).1=doubled j ++ (blocks j).2 := by
  simp [blocks,doubled,X,Y,List.append_assoc]

private theorem nested {j k : ℕ} (h : j ≤ k) : (blocks j).1 <+: (blocks k).1 := by
  induction k,h using Nat.le_induction with
  | base => exact List.prefix_rfl
  | succ k _ ih =>
    exact ih.trans ⟨(blocks k).2,rfl⟩

private theorem grows (j : ℕ) : j < (blocks j).1.length ∧ 0 < (blocks j).2.length := by
  induction j with
  | zero => decide
  | succ j ih =>
    simp only [blocks,List.length_append]
    omega

/-- The infinite Fibonacci word, the pointwise limit of its nested finite iterates. -/
def fibonacciLetter (i : ℕ) : Letter := (blocks i).1[i]'(grows i).1

private theorem prefix_agrees {j : ℕ} {w : Word} (hw : w <+: (blocks j).1)
    {i : ℕ} (hi : i<w.length) : w[i] = fibonacciLetter i := by
  have h₁ := (hw.trans (nested (Nat.le_max_left j i))).getElem hi
  have h₂ := (nested (Nat.le_max_right j i)).getElem (grows i).1
  exact h₁.trans h₂.symm

/-- All 4F_{j+4} letters of the prefix agree with X²Y², for every j>=0. -/
theorem fibonacci_prefix (j : ℕ) :
    List.ofFn (fun i : Fin (4*Nat.fib (j+4)) => fibonacciLetter i)=doubled j := by
  have hprefix : doubled j <+: (blocks (j+5)).1 := ⟨(blocks j).2,(five_steps j).symm⟩
  obtain ⟨hx,hy⟩ := conjugate_lengths j
  apply List.ext_getElem
  · simp only [List.length_ofFn,doubled,List.length_append,hx,hy]; omega
  · intro i _ hi
    simpa only [List.getElem_ofFn] using (prefix_agrees hprefix hi).symm

#print axioms fibonacci_prefix

end FibonacciCycleWords

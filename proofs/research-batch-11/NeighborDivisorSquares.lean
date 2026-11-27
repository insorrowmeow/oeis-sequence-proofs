import Mathlib.Data.Nat.Prime.Basic
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.Ring

namespace NeighborDivisorSquares

def LargestProper (d n : Nat) := d ∣ n ∧ d < n ∧ ∀ e, e ∣ n → e < n → e ≤ d

private theorem maximal {d n p : Nat} (hp : 2 ≤ p) (hd : 0 < d)
    (he : n = p*d) (least : ∀ t, 2 ≤ t → t ∣ n → p ≤ t) :
    LargestProper d n := by
  refine ⟨⟨p, by rw [he, Nat.mul_comm]⟩, by rw [he]; nlinarith, ?_⟩
  rintro e ⟨t, ht⟩ hl
  have ht2 : 2 ≤ t := by
    by_contra! h
    obtain h0|h1 : t=0 ∨ t=1 := by omega
    · simp [h0] at ht
      omega
    · simp [h1] at ht
      omega
  have hpt := least t ht2 ⟨e, by simpa [Nat.mul_comm] using ht⟩
  by_contra! hed
  nlinarith [Nat.mul_le_mul_left e hpt, Nat.mul_lt_mul_of_pos_left hed (by omega : 0<p)]

private theorem leftDiv (h : Nat) : LargestProper (42*h+1) (210*h+5) := by
  apply maximal (p:=5) (by decide) (by omega) (by ring)
  intro t ht hdiv
  by_contra! hlt
  obtain h2|h3|h4 : t=2 ∨ t=3 ∨ t=4 := by omega
  all_goals subst t; omega

private theorem midDiv (h : Nat) : LargestProper (105*h+3) (210*h+6) := by
  exact maximal (p:=2) (by decide) (by omega) (by ring) (fun _ ht _ => ht)

private theorem rightDiv (h : Nat) : LargestProper (30*h+1) (210*h+7) := by
  apply maximal (p:=7) (by decide) (by omega) (by ring)
  intro t ht hdiv
  by_contra! hlt
  obtain h2|h3|h4|h5|h6 : t=2 ∨ t=3 ∨ t=4 ∨ t=5 ∨ t=6 := by omega
  all_goals subst t; omega

structure State where
  x : Nat
  y : Nat
  h : Nat

def step (s : State) : State :=
  ⟨51841*s.x+54096*s.y, 49680*s.x+51841*s.y,
   s.h+18282240*s.x^2+38154976*s.x*s.y+19907328*s.y^2⟩

def orbit : Nat → State
  | 0 => ⟨2,2,0⟩
  | n+1 => step (orbit n)

private theorem invariant (t : Nat) :
    let s := orbit t
    s.x^2=147*s.h+4 ∧ s.y^2=135*s.h+4 ∧ t ≤ s.h := by
  induction t with
  | zero => decide
  | succ t ih =>
    change (orbit t).x^2=147*(orbit t).h+4 ∧
      (orbit t).y^2=135*(orbit t).h+4 ∧ t ≤ (orbit t).h at ih
    rcases ih with ⟨hx,hy,ht⟩
    simp only [orbit, step]
    refine ⟨by nlinarith, by nlinarith, by nlinarith⟩

theorem unbounded_double_exceptions (B : Nat) :
    ∃ k l m r x y, B < k ∧ LargestProper l (k-1) ∧ LargestProper m k ∧
     LargestProper r (k+1) ∧ l+m=x^2 ∧ m+r=y^2 ∧ 1 < l ∧ 1 < r := by
  let s := orbit (B+1)
  have hx : s.x^2=147*s.h+4 := (invariant (B+1)).1
  have hy : s.y^2=135*s.h+4 := (invariant (B+1)).2.1
  have ht : B+1 ≤ s.h := (invariant (B+1)).2.2
  refine ⟨210*s.h+6,42*s.h+1,105*s.h+3,30*s.h+1,s.x,s.y,by omega,
    ?_,midDiv _,rightDiv _,by omega,by omega,by omega,by omega⟩
  simpa using leftDiv s.h

end NeighborDivisorSquares

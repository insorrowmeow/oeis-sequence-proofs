import Mathlib.Data.Nat.Basic
import Mathlib.Tactic.Ring

namespace Carryless

/-- Multiply binary polynomials over F₂, reading the second factor from its low end. -/
def product (m n : ℕ) : ℕ :=
  if hn : n = 0 then 0 else (2 * product m (n/2)) ^^^ (m * (n%2))
termination_by n
decreasing_by exact Nat.div_lt_self (by omega) (by decide)

@[simp] theorem product_zero (m : ℕ) : product m 0 = 0 := by rw [product]; simp

private theorem product_bit (m n b : ℕ) (hb : b < 2) :
    product m (2*n+b) = (2*product m n) ^^^ (m*b) := by
  by_cases hz : 2*n+b = 0
  · obtain rfl : n=0 := by omega
    obtain rfl : b=0 := by omega
    simp
  · rw [product, dif_neg hz, show (2*n+b)/2=n by omega, show (2*n+b)%2=b by omega]

abbrev State := Option (ℕ × ℕ)

def test (s m : ℕ) (q : State) (n : ℕ) : Prop :=
  match q with
  | none => False
  | some (c,h) => s*n+c = product m n ^^^ h

instance (s m : ℕ) (q : State) (n : ℕ) : Decidable (test s m q n) := by
  cases q with
  | none => exact isFalse id
  | some p => exact Nat.decEq _ _

def next (s m : ℕ) (q : State) (b : ℕ) : State :=
  match q with
  | none => none
  | some (c,h) =>
    let u := c+s*b
    let v := m*b ^^^ h
    if u%2 = v%2 then some (u/2,v/2) else none

private theorem shift_test (s m : ℕ) (q : State) (n b : ℕ) (hb : b < 2) :
    test s m q (2*n+b) ↔ test s m (next s m q b) n := by
  rcases q with _ | ⟨c,h⟩
  · rfl
  simp only [test, next, product_bit _ _ _ hb, Nat.xor_assoc]
  let u := c+s*b
  let v := m*b ^^^ h
  let z := 2*product m n ^^^ v
  have hlow : z % 2 = v % 2 := by
    change (2*product m n ^^^ v) % 2^1 = _
    rw [Nat.xor_mod_two_pow]; simp
  have hhigh : z/2 = product m n ^^^ (v/2) := by
    dsimp [z]; rw [Nat.xor_div_two]; simp
  have hu : s*(2*n+b)+c = 2*(s*n)+u := by dsimp [u]; ring
  change s*(2*n+b)+c = z ↔ test s m (if u%2=v%2 then some (u/2,v/2) else none) n
  by_cases he : u%2=v%2
  · rw [if_pos he]
    change s*(2*n+b)+c = z ↔ s*n+u/2 = product m n ^^^ (v/2)
    rw [hu, ← hhigh]
    omega
  · rw [if_neg he]
    change s*(2*n+b)+c = z ↔ False
    rw [hu]
    constructor
    · intro eq
      have q := congrArg (fun x : ℕ => x%2) eq
      change (2*(s*n)+u)%2 = z%2 at q
      rw [Nat.mul_add_mod_self_left, hlow] at q
      exact he q
    · exact False.elim

private abbrev st (c h : ℕ) : State := some (c,h)
private def states : List (State × State) := [
  (st 0 0, st 0 0), (st 3 5, st 2 6), (st 1 2, st 1 3),
  (st 5 7, st 3 5), (none, st 0 1), (none, st 3 7),
  (st 2 3, st 1 2), (st 6 6, st 4 4), (none, none),
  (none, st 1 3), (none, st 4 5), (st 3 3, st 2 2),
  (st 1 1, st 1 1), (st 5 4, st 3 7), (st 4 5, st 3 6)]

private def cfg (i : Fin 15) := states.getD i.val (none, none)
private def dest (i : Fin 15) (b : Fin 2) : Fin 15 :=
  let table : List (Fin 15 × Fin 15) :=
    [(0,1),(2,3),(4,5),(6,7),(8,8),(9,10),(8,8),(11,7),
     (8,8),(4,5),(8,8),(12,13),(0,14),(9,10),(8,8)]
  let p := table.getD i.val (8,8)
  if b.val = 0 then p.1 else p.2

private theorem closed : ∀ (i : Fin 15) (b : Fin 2),
    cfg (dest i b) = (next 7 11 (cfg i).1 b, next 5 13 (cfg i).2 b) := by decide

private def accepts : State → Bool
  | none => false
  | some (c,h) => c == h

private theorem test_zero (s m : ℕ) (q : State) : test s m q 0 ↔ accepts q = true := by
  rcases q with _|⟨c,h⟩ <;> simp [test,accepts]

private theorem same (n : ℕ) : ∀ i : Fin 15,
    test 7 11 (cfg i).1 n ↔ test 5 13 (cfg i).2 n := by
  induction n using Nat.strong_induction_on with
  | h n ih =>
    by_cases hn : n = 0
    · subst n; simp only [test_zero]; decide
    intro i
    let b : Fin 2 := ⟨n%2, Nat.mod_lt _ (by decide)⟩
    have H := ih (n/2) (Nat.div_lt_self (by omega) (by decide)) (dest i b)
    rw [closed] at H
    have hb : 2*(n/2)+b.val = n := by dsimp [b]; omega
    exact hb ▸ ((shift_test 7 11 _ _ _ b.isLt).trans
      (H.trans (shift_test 5 13 _ _ _ b.isLt).symm))

/-- Antti Karttunen's conjecture in OEIS A115770. -/
theorem karttunen (n : ℕ) : 7*n = product 11 n ↔ 5*n = product 13 n := by
  have H := same n 0
  change (7*n+0 = product 11 n ^^^ 0) ↔ (5*n+0 = product 13 n ^^^ 0) at H
  simpa using H

#print axioms karttunen
end Carryless

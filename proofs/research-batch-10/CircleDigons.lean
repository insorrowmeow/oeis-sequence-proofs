import Lean

namespace CircleDigons

def change (a b : Bool) : Nat := if a = b then 0 else 1

def changes (a : Bool) : List Bool → Nat
  | [] => 0
  | b :: bs => change a b + changes b bs

def finish (a : Bool) : List Bool → Bool
  | [] => a
  | b :: bs => finish b bs

theorem parity (a : Bool) (bs : List Bool) :
    changes a bs % 2 = change a (finish a bs) := by
  induction bs generalizing a with
  | nil => simp [changes, finish, change]
  | cons b bs ih =>
    have h := ih b
    simp only [changes, finish]
    cases he : finish b bs <;> rw [he] at h <;>
      cases a <;> cases b <;> simp [change] at h ⊢ <;> omega

theorem antipodal_insertion (a b x : Bool) :
    (change a x + change x b + change (!a) (!x) + change (!x) (!b)
      = change a b + change (!a) (!b)) ∨
    (change a x + change x b + change (!a) (!x) + change (!x) (!b)
      = change a b + change (!a) (!b) + 4) := by
  cases a <;> cases b <;> cases x <;> decide

end CircleDigons

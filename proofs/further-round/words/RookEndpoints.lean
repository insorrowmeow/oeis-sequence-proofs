import Mathlib.GroupTheory.Perm.Basic

/- The rows of the board are numbered from zero in this file.
   On permutations the final cell q is specified by p(q) = 0. -/
namespace RookEndpoints

abbrev Cell (m : ℕ) := Fin (m+1)

def AtEndpoint {m : ℕ} (q : Cell m) (rule : Cell m → Cell m → Prop) :=
  {p : Equiv.Perm (Cell m) // p q = 0 ∧ ∀ i, i ≠ q → rule i (p i)}

def FreeEndpoint {m : ℕ} (q : Cell m) (rule : Cell m → Cell m → Prop) :=
  {p : Equiv.Perm (Cell m) //
    p 0 = 0 ∧ ∀ i, i ≠ 0 → i ≠ q → rule i (p i)}

private def exchange {m : ℕ} (q : Cell m) (p : Equiv.Perm (Cell m)) :=
  (Equiv.swap 0 q).trans p

/-- Removing the endpoint constraint frees row q and fixes the leftmost cell.
    The leftmost row in the old board permits any nonzero image. -/
def endpointEquiv {m : ℕ} (q : Cell m) (hq : q ≠ 0)
    (rule : Cell m → Cell m → Prop) (leftBlack : ∀ v ≠ 0, rule 0 v) :
    AtEndpoint q rule ≃ FreeEndpoint q rule where
  toFun p := ⟨exchange q p.val, by
    constructor
    · simpa [exchange] using p.property.1
    · intro i hi hiq
      simpa [exchange, Equiv.swap_apply_of_ne_of_ne hi hiq] using p.property.2 i hiq⟩
  invFun p := ⟨exchange q p.val, by
    constructor
    · simpa [exchange] using p.property.1
    · intro i hiq
      by_cases hi : i = 0
      · subst i
        simp only [exchange, Equiv.trans_apply, Equiv.swap_apply_left]
        apply leftBlack
        intro he
        exact hq (p.val.injective (he.trans p.property.1.symm))
      · simpa [exchange, Equiv.swap_apply_of_ne_of_ne hi hiq] using p.property.2 i hi hiq⟩
  left_inv p := by apply Subtype.ext; ext i; simp [exchange]
  right_inv p := by apply Subtype.ext; ext i; simp [exchange]

def typeOne {m : ℕ} (black : Cell m → Prop) (i j : Cell m) : Prop :=
  i < j → black i

def typeTwo {m : ℕ} (black : Cell m → Prop) (i j : Cell m) : Prop :=
  i < j ↔ black i

def firstKind {m : ℕ} (black : Cell m → Prop) (h : black 0)
    (q : Cell m) (hq : q ≠ 0) :
    AtEndpoint q (typeOne black) ≃ FreeEndpoint q (typeOne black) :=
  endpointEquiv q hq _ (fun _ _ _ => h)

def secondKind {m : ℕ} (black : Cell m → Prop) (h : black 0)
    (q : Cell m) (hq : q ≠ 0) :
    AtEndpoint q (typeTwo black) ≃ FreeEndpoint q (typeTwo black) :=
  endpointEquiv q hq _ (fun _ hv => ⟨fun _ => h, fun _ => Fin.pos_iff_ne_zero.mpr hv⟩)

#print axioms firstKind
#print axioms secondKind
end RookEndpoints

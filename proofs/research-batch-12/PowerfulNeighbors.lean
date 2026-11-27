import Mathlib.Data.Finset.Card
import Mathlib.Tactic.NormNum

namespace PowerfulNeighbors

/-- The center residue and the six nonzero offsets are taken modulo q.
    Test the center against the residues ±1, ±2 and ±3. -/
def good (q a b : ℕ) : Bool :=
  let center := (b^3 * a^2) % q
  [1,2,3].all fun d => center != d % q && (center+d) % q != 0

set_option maxRecDepth 4000 in
theorem modulo_four : ∀ b : Fin 4,
    ((List.range 4).filter fun a => good 4 a b.val).length =
      if b.val % 2 = 0 then 4 else 2 := by decide

set_option maxRecDepth 4000 in
theorem modulo_nine : ∀ b : Fin 9,
    ((List.range 9).filter fun a => good 9 a b.val).length =
      if b.val % 3 = 0 then 9 else 5 := by decide

end PowerfulNeighbors

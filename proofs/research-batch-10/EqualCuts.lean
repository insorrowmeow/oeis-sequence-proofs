import Mathlib.Tactic.Ring

namespace EqualCuts

-- Relative to its start, a path records its displacement and twice ∫ x dy.
structure PathData where
  x : Int
  y : Int
  area : Int

def join (p q : PathData) : PathData :=
  ⟨p.x+q.x, p.y+q.y, p.area+q.area+2*p.x*q.y⟩

def chain : List PathData → PathData
  | [] => ⟨0,0,0⟩
  | p::ps => join p (chain ps)

theorem equal_block_chain (x y : Int) (paths : List PathData)
    (h : ∀ p ∈ paths, p.x = x ∧ p.y = y ∧ p.area = x*y) :
    (chain paths).x = paths.length*x ∧
    (chain paths).y = paths.length*y ∧
    (chain paths).area = (paths.length*x)*(paths.length*y) := by
  induction paths with
  | nil => simp [chain]
  | cons p ps ih =>
    obtain ⟨hx,hy,ha⟩ := h p (by simp)
    obtain ⟨ix,iy,ia⟩ := ih (fun q hq => h q (by simp [hq]))
    constructor
    · simp [chain,join,hx,ix]
      ring
    constructor
    · simp [chain,join,hy,iy]
      ring
    · simp [chain,join,ha,ia,hx,iy]
      ring

-- A half-turn followed by reversing traversal preserves displacement
-- and complements twice the signed area to 2*x*y.
def partner (p : PathData) : PathData := ⟨p.x,p.y,2*p.x*p.y-p.area⟩

theorem pad (p core : PathData) (h : core.area = core.x*core.y) :
    let full := join (join p core) (partner p)
    full.area = full.x*full.y := by
  simp [join,partner,h]
  ring

end EqualCuts

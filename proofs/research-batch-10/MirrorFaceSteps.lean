import Mathlib.Logic.ExistsUnique

namespace MirrorFaceSteps

abbrev Point := Int × Int

def inside (u v : Int) (p : Point) : Prop :=
  0 ≤ p.1 ∧ p.1 < u ∧ 0 ≤ p.2 ∧ p.2 < v

def unit (x y : Int) : Prop := y = x+1 ∨ y = x-1

def adj (p q : Point) : Prop :=
  if (p.1+p.2)%2=0 then unit p.1 q.1 ∧ p.2=q.2
  else p.1=q.1 ∧ unit p.2 q.2

theorem route_displacement (p r q : Point) (h1 : adj p r) (h2 : adj r q) :
    unit p.1 q.1 ∧ unit p.2 q.2 := by
  simp only [adj, unit] at h1 h2 ⊢
  split at h1 <;> split at h2 <;> omega

-- Entrywise A² = P_u ⊗ P_v. Every diagonal target has one intermediate
-- face, whichever of the two coordinate directions is traversed first.
theorem unique_route (u v : Int) (p q : Point) (hp : inside u v p) (hq : inside u v q) :
    (∃! r : Point, inside u v r ∧ adj p r ∧ adj r q) ↔
      unit p.1 q.1 ∧ unit p.2 q.2 := by
  obtain ⟨x,y⟩ := p
  obtain ⟨z,w⟩ := q
  simp only [inside, Prod.fst, Prod.snd] at hp hq
  constructor
  · rintro ⟨⟨a,b⟩, ⟨_,h1,h2⟩, _⟩
    exact route_displacement _ _ _ h1 h2
  · intro h
    rcases h with ⟨h1,h2⟩
    simp only [unit, Prod.fst, Prod.snd] at h1 h2
    by_cases h : (x+y)%2=0
    · refine ⟨(z,y), ?_, ?_⟩
      · simp only [inside, adj, unit, Prod.fst, Prod.snd, h, if_true]
        split
        · omega
        · exact ⟨⟨hq.1, hq.2.1, hp.2.2⟩, ⟨h1, trivial⟩, trivial, h2⟩
      · rintro ⟨a,b⟩ ⟨_,ha,hb⟩
        simp only [adj, unit, Prod.fst, Prod.snd, h, if_true] at ha hb
        apply Prod.ext <;> simp only [Prod.fst, Prod.snd] <;> split at hb <;> omega
    · refine ⟨(x,w), ?_, ?_⟩
      · simp only [inside, adj, unit, Prod.fst, Prod.snd, h, if_false]
        split
        · exact ⟨⟨hp.1, hp.2.1, hq.2.2⟩, ⟨trivial, h2⟩, h1, trivial⟩
        · omega
      · rintro ⟨a,b⟩ ⟨_,ha,hb⟩
        simp only [adj, unit, Prod.fst, Prod.snd, h, if_false] at ha hb
        apply Prod.ext <;> simp only [Prod.fst, Prod.snd] <;> split at hb <;> omega

end MirrorFaceSteps

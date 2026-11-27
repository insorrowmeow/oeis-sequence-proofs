import Std

/-! Exhaustive coefficient count for the Coulter--Do--Moskovsky distinct-label
refinement, genus zero and two cycles of size three. Vertices in this file
are zero based. The six transpositions have weakly increasing larger ends.
Orbit labels are maintained by union of the orbits containing the endpoints.
The normalizing factor for two labelled cycles is 2!/6! = 1/360. -/

namespace HiveCount

abbrev Row := Array Nat

def vertices : Row := #[0, 1, 2, 3, 4, 5]

/-- The orbit of v under p has length exactly three. -/
def inThreeCycle (p : Row) (v : Nat) : Bool :=
  let w := p[v]!
  let u := p[w]!
  w != v && u != v && p[u]! == v

/-- For a permutation on six letters, this is precisely cycle type (3,3). -/
def hasType33 (p : Row) := vertices.all (inThreeCycle p)

def swapEnds (p : Row) (a b : Nat) : Row :=
  (p.set! a p[b]!).set! b p[a]!

def mergeOrbits (labels : Row) (a b : Nat) : Row :=
  let old := labels[b]!
  let newLabel := labels[a]!
  if old == newLabel then labels else labels.map (fun v => if v == old then newLabel else v)

/-- Search an exact distinct-label mask. Bit b-1 represents larger endpoint b
(zero-based). The two recursive sums choose a larger endpoint at least the
previous one, and then a smaller endpoint. The identity and singleton orbits
are supplied by rawCount. -/
def enumerate (target : Nat) : Nat → Nat → Nat → Row → Row → Nat
  | 0, _, seen, p, labels =>
      if seen == target && labels.all (· == labels[0]!) && hasType33 p then 1 else 0
  | steps+1, lower, seen, p, labels => Id.run do
      let mut count := 0
      for b in [lower:6] do
        let bit := 2^(b-1)
        if target &&& bit != 0 then
          for a in [:b] do
            count := count + enumerate target steps b (seen ||| bit)
              (swapEnds p a b) (mergeOrbits labels a b)
      return count

/-- Transitivity forces the last vertex to occur, hence bit 4 is present
in each contributing monomial. The other four bits encode t2,...,t5. -/
def rawCount (m : Nat) := enumerate (16+m) 6 1 0 vertices vertices

def counts := (List.range 16).map rawCount

def expected : List Nat :=
  [360,120,312,72,696,200,520,120,1752,520,1352,312,2856,696,1752,360]

theorem counts_exact : counts = expected := by native_decide

#print axioms counts_exact

end HiveCount

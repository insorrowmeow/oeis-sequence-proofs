import Std

/-! Kernel computation of the distinct-larger-end counts for cycle type (3,3).
The marked letter is the current larger endpoint. Each connected component
of the graph of transpositions consists of whole cycles of their product.
Compression records these lengths while distinguishing the marked cycle.
Order of cycles and components in the lists is immaterial to the recurrence. -/

namespace HiveCycles

structure State where
  marked : Nat
  same : List Nat
  others : List (List Nat)
  deriving Repr

/-- Choose one item, remembering the rest. Repetitions retain multiplicity. -/
def picks {α : Type} : List α → List (α × List α)
  | [] => []
  | x::xs => (x, xs) :: ((picks xs).map fun (y, ys) => (y, x::ys))

/-- Advance to the next larger letter, initially an isolated fixed point. -/
def advance (s : State) : State := ⟨1, [], (s.marked :: s.same) :: s.others⟩

/-- All choices extendible to a connected six-edge graph on six vertices,
recorded as (multiplicity,state). Exactly five edges must join previously
different components. The remaining edge splits the sole permutation cycle
of its graph component into two. Once there is a two-cycle component, only
edges joining distinct graph components may still be used.
Within the marked cycle there is one way to produce each possible new
marked length from 1 through marked-1. Choosing a letter in any other cycle
joins that entire cycle to the marked one. There are as many choices as
letters in that cycle. In the last sum the graph components also merge. -/
def step (s : State) : List (Nat × State) :=
  let split := if s.same.isEmpty && s.others.all (fun c => c.length == 1) then
    ((List.range (s.marked-1)).filter (fun i => i+1 ≤ 3 && s.marked-(i+1) ≤ 3)).map fun i =>
      (1, ⟨i+1, [s.marked-(i+1)], s.others⟩)
    else []
  let connect := (picks s.others).flatMap fun (cycles, rest) =>
    (picks cycles).map fun (j, leftover) =>
      (j, ⟨s.marked+j, s.same ++ leftover, rest⟩)
  split ++ connect

/-- An event either introduces the next label, or applies a transposition
whose larger endpoint is the current marked label. -/
inductive Event | next | transpose

def run : List Event → State → Nat
  | [], s => if s.others.isEmpty && s.marked == 3 && s.same == [3] then 1 else 0
  | .next::xs, s => run xs (advance s)
  | .transpose::xs, s => ((step s).map fun (multiplicity,u) => multiplicity * run xs u).sum

/-- Counts of occurrences of each possible larger label. Zero occurrences
are allowed precisely for the labels absent from the target support. -/
def schedules : List Bool → Nat → List (List Event)
  | [], total => if total == 0 then [[]] else []
  | present::tail, total =>
    ((List.range (total+1)).filter (fun h => (h != 0) == present)).flatMap fun h =>
      (schedules tail (total-h)).map fun xs =>
        .next :: (List.replicate h .transpose ++ xs)

def rawCount (m : Nat) :=
  let supp := (List.range 4).map (m.testBit ·) ++ [true]
  ((schedules supp 6).map fun xs => run xs ⟨1,[],[]⟩).sum

def counts := (List.range 16).map rawCount

set_option maxRecDepth 65536
set_option maxHeartbeats 10000000
private theorem count0 : rawCount 0 = 360 := by decide +kernel
private theorem count1 : rawCount 1 = 120 := by decide +kernel
private theorem count2 : rawCount 2 = 312 := by decide +kernel
private theorem count3 : rawCount 3 = 72 := by decide +kernel
private theorem count4 : rawCount 4 = 696 := by decide +kernel
private theorem count5 : rawCount 5 = 200 := by decide +kernel
private theorem count6 : rawCount 6 = 520 := by decide +kernel
private theorem count7 : rawCount 7 = 120 := by decide +kernel
private theorem count8 : rawCount 8 = 1752 := by decide +kernel
private theorem count9 : rawCount 9 = 520 := by decide +kernel
private theorem count10 : rawCount 10 = 1352 := by decide +kernel
private theorem count11 : rawCount 11 = 312 := by decide +kernel
private theorem count12 : rawCount 12 = 2856 := by decide +kernel
private theorem count13 : rawCount 13 = 696 := by decide +kernel
private theorem count14 : rawCount 14 = 1752 := by decide +kernel
private theorem count15 : rawCount 15 = 360 := by decide +kernel
theorem counts_exact : counts = [360, 120, 312, 72, 696, 200, 520, 120, 1752, 520, 1352, 312, 2856, 696, 1752, 360] := by
  change [rawCount 0, rawCount 1, rawCount 2, rawCount 3, rawCount 4, rawCount 5, rawCount 6, rawCount 7, rawCount 8, rawCount 9, rawCount 10, rawCount 11, rawCount 12, rawCount 13, rawCount 14, rawCount 15] = _
  rw [count0, count1, count2, count3, count4, count5, count6, count7, count8, count9, count10, count11, count12, count13, count14, count15]
#print axioms counts_exact
end HiveCycles

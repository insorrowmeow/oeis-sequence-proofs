import Mathlib.Tactic.NormNum

namespace PerimeterMagic

abbrev Form := ℤ × ℤ
abbrev Slice := ℤ × Form × List ℕ
abbrev Term := ℤ × ℕ × List ℕ

def value (a r : Form) := a.1*r.1 + a.2*r.2

def uniqueAt (r : Form) (l : List Form) : List Form :=
  l.foldl (fun acc f => if acc.any (fun g => value g r == value f r) then acc else f::acc) []

def minus (a b : Form) : Form := (a.1-b.1, a.2-b.2)
def plus (a b : Form) : Form := (a.1+b.1, a.2+b.2)
def times (k : ℤ) (a : Form) : Form := (k*a.1,k*a.2)

def differences (r : Form) (l h : List Form) :=
  uniqueAt r (l.flatMap fun x => h.map fun y => minus x y)

def fixedGaps (r : Form) : List Slice := Id.run do
  let z : Form := (0,0)
  let u : Form := (1,0)
  let v : Form := (0,1)
  let uv := plus u v
  let sides := [z,u,v,uv]
  let fa := differences r sides [z,u]
  let fb := differences r sides [z,v]
  let fd := differences r [z,v] [z,u]
  let mut out : List Slice := [(1,uv,[1,1,1])]
  for f in fa ++ fb ++ fd do
    let h := if value f r ≥ 0 then f else times (-1) f
    out := (-1,plus uv h,[1,2]) :: out
  let joint (a b : Form) :=
    let c := if value a r ≤ 0 && value a r ≤ value b r then a
             else if value b r ≤ 0 then b else z
    minus (plus uv (plus a b)) (times 3 c)
  for a in fa do
    for b in fb do
      unless fd.any (fun d => value d r == value (minus a b) r) do
        out := (1,joint a b,[3]) :: out
    for d in fd do out := (1,joint a (minus a d),[3]) :: out
  for b in fb do
    for d in fd do out := (1,joint (plus b d) b,[3]) :: out
  return out

def rays : List Form := [(0,1),(1,4),(1,3),(1,2),(2,3),(3,4),(1,1)]

def terms : List Term := Id.run do
  let mut out : List Term := []
  for (l,r) in rays.zip rays.tail do
    for (c,f,d) in fixedGaps (plus l r) do
      let a := (value f l).toNat
      let b := (value f r).toNat
      out := (c,3+a+b,a::b::d) :: out
  for r in rays.tail.dropLast do
    for (c,f,d) in fixedGaps r do
      let a := (value f r).toNat
      out := (c,3+a,a::d) :: out
  return out

def common : List ℕ :=
  [1,1,1,1,2,2,3,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,24,25]

def target : List ℤ := [1,2,3,2,0,-3,-6,-8,-9,-7,-3,4,10,15,16,14,8,0,
              -8,-14,-16,-15,-10,-4,3,7,9,8,6,3,0,-2,-3,-2,-1]

def numerator : List ℤ := List.replicate 12 0 ++
  [3,15,50,127,267,481,793,1173,1625,2079,2520,2826,3045,3038,2906,2580,2187,
   1673,1231,796,491,236,98]

def horner (base : ℤ) (xs : List ℤ) := xs.foldr (fun x a => x + base*a) 0
def factors (base : ℤ) (xs : List ℕ) := xs.foldl (fun a k => a*(1-base^k)) 1

def containsPowers (full d : List ℕ) :=
  d.all fun k => decide (d.count k ≤ full.count k) && k != 0

set_option maxRecDepth 100000
set_option maxHeartbeats 0

/-- Each denominator divides the common product, with every multiplicity checked. -/
theorem shape : terms.length = 922 ∧ terms.all (fun s => containsPowers common s.2.2) ∧
    terms.all (fun s => s.1.natAbs == 1) ∧ common.length = 29 ∧
    (target.map Int.natAbs).sum = 222 ∧ (numerator.map Int.natAbs).sum = 30240 := by
  decide +kernel

/-- Clearing denominators and evaluating the resulting integer polynomials at 2^48. -/
theorem packed_identity :
    let base : ℤ := 2^48
    let denom := factors base common
    let total := terms.foldl (fun acc s =>
      acc + s.1 * base^s.2.1 * (denom / factors base s.2.2)) 0
    total * horner base target = denom * horner base numerator := by
  decide +kernel

#print axioms shape
#print axioms packed_identity

end PerimeterMagic

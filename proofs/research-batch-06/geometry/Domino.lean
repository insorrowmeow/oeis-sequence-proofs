import Mathlib.Data.Matrix.Notation
import Mathlib.Data.List.Sublists
import Mathlib.Tactic.FinCases
import Mathlib.Tactic.Ring
import Mathlib.Tactic.Linarith

namespace DominoA333650

abbrev State := ℕ × List ℕ
abbrev Vec := Fin 13 → ℤ

/-- The state records used excess and the top row relative to its leftmost brick. -/
def keys : Fin 13 → State :=
  ![(0,[0]),(1,[0]),(1,[0,1]),(2,[0]),(2,[0,1]),(2,[0,1,2]),(2,[0,2]),
    (3,[0]),(3,[0,1]),(3,[0,1,2]),(3,[0,1,2,3]),(3,[0,2]),(3,[0,3])]

def successors (s : State) : List State :=
  let sites := (List.range (s.2.foldl max 0+2)).filter (s.2 ++ s.2.map (·+1)).contains
  sites.sublists.filterMap fun row =>
    match row with
    | [] => none
    | left :: tail =>
      if s.1+tail.length ≤ 3 then
        some (s.1+tail.length, (left :: tail).map (·-left))
      else none

def start : Vec := ![1,0,1,0,0,1,0,0,0,0,1,0,0]

def step (v : Vec) : Vec :=
  ![2*v 0, 2*v 1+3*v 2, v 0, 2*v 3+3*v 4+4*v 5+4*v 6, v 1+2*v 2, 0, v 2,
    2*v 7+3*v 8+4*v 9+5*v 10+4*v 11+4*v 12, v 3+2*v 4+3*v 5+3*v 6, v 2, 0,
    v 4+2*v 5+2*v 6, v 5+v 6]

theorem no_omitted_states : ∀ i, (successors (keys i)).all (List.ofFn keys).contains = true := by
  decide

theorem initial_states : ∀ i, start i = (if (keys i).2 = List.range ((keys i).1+1) then 1 else 0) := by
  decide

theorem distinct_states : Function.Injective keys := by
  change ∀ ⦃i j : Fin 13⦄, keys i=keys j → i=j
  decide

theorem all_bases : ∀ b : Fin 4, (List.ofFn keys).contains (b.val,List.range (b.val+1)) = true := by
  decide

theorem transition_table : ∀ i j,
    step (fun k => if k=i then 1 else 0) j = ((successors (keys i)).count (keys j) : ℕ) := by
  decide

/-- The sparse transition is the complete sum over possible next rows,
    with each normalized output counted with its placement multiplicity. -/
theorem whole_transition (v : Vec) (j : Fin 13) :
    step v j = ∑ i : Fin 13, ((successors (keys i)).count (keys j) : ℤ)*v i := by
  simp_rw [← transition_table]
  fin_cases j <;> simp [Fin.sum_univ_succ,step] <;> ring

/-- Index zero is a one-layer tower. -/
def counts : ℕ → Vec
  | 0 => start
  | k+1 => step (counts k)

def scale (a : ℤ) (v : Vec) : Vec := fun i => a*v i

private theorem step_scale (a : ℤ) (v : Vec) : step (scale a v) = scale a (step v) := by
  funext i
  fin_cases i <;> simp [step,scale] <;> ring

private def polys (k : ℤ) : Vec :=
  ![384,1152+288*k,192,2640+1020*k+108*k^2,624+144*k,0,96,
    6096+2724*k+441*k^2+27*k^3,1488+546*k+54*k^2,96,0,336+72*k,48]

private theorem step_polys (k : ℤ) : step (polys k)=scale 2 (polys (k+1)) := by
  funext i
  fin_cases i <;> simp [step,polys,scale] <;> ring

private theorem all_counts (k : ℕ) : scale 48 (counts (k+3))=scale (2^k) (polys k) := by
  induction k with
  | zero => funext i; fin_cases i <;> decide
  | succ k ih =>
    change scale 48 (step (counts (k+3)))=scale (2^(k+1)) (polys ((k+1:ℕ):ℤ))
    rw [← step_scale,ih,step_scale,step_polys]
    funext i
    simp [scale,pow_succ]
    ring

def d1 (v : Vec) : ℤ := v 1+v 2
def d2 (v : Vec) : ℤ := v 3+v 4+v 5+v 6
def d3 (v : Vec) : ℤ := v 7+v 8+v 9+v 10+v 11+v 12

/-- Initial terms before the common polynomial regime. -/
theorem prefixes :
    ([0,1,2].map fun n => d1 (counts n)) = [1,4,11] ∧
    ([0,1,2].map fun n => d2 (counts n)) = [1,7,24] ∧
    ([0,1,2].map fun n => d3 (counts n)) = [1,12,52] := by decide

/-- Scaled versions of the three OEIS closed forms for index m=k+3. -/
theorem diagonals (k : ℕ) :
    let m : ℤ := k+3
    d1 (counts (k+3)) = 2^k*(10+6*m) ∧
    4*d2 (counts (k+3)) = 2^k*(70+43*m+9*m^2) ∧
    16*d3 (counts (k+3)) = 2^k*(588+367*m+84*m^2+9*m^3) := by
  dsimp only
  have table := all_counts k
  have h (i : Fin 13) := congrFun table i
  obtain ⟨h1,h2,h3,h4,h5,h6,h7,h8,h9,h10,h11,h12⟩ :
    _ ∧ _ ∧ _ ∧ _ ∧ _ ∧ _ ∧ _ ∧ _ ∧ _ ∧ _ ∧ _ ∧ _ :=
    ⟨h 1,h 2,h 3,h 4,h 5,h 6,h 7,h 8,h 9,h 10,h 11,h 12⟩
  simp [scale,polys] at h1 h2 h3 h4 h5 h6 h7 h8 h9 h10 h11 h12
  unfold d1 d2 d3
  constructor
  · nlinarith only [h1,h2]
  constructor
  · nlinarith only [h3,h4,h5,h6]
  · nlinarith only [h7,h8,h9,h10,h11,h12]

#print axioms no_omitted_states
#print axioms transition_table
#print axioms diagonals

end DominoA333650

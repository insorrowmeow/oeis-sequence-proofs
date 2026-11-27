import Mathlib.Tactic.Ring

namespace OddNeighbors

def offsets : List Int := [-7,-6,-5,-4,-3,-2,-1,1,2,3,4,5,6,7]

def rootsNine (x : Int) : List Int :=
  offsets.filter (fun d => (x^2+d) % 9 = 0)

theorem exceptions_at_three :
    (List.range 9).map (fun (i : Nat) => rootsNine (i: Int)) =
      [[],[-1],[-4,5],[],[-7,2],[-7,2],[],[-4,5],[-1]] := by decide

theorem lower_offset (k : Int) : (4*k+2)^2-4=16*k*(k+1) := by ring

theorem upper_offset (k : Int) : (4*k+2)^2+4=8*(2*k*(k+1)+1) := by ring

end OddNeighbors

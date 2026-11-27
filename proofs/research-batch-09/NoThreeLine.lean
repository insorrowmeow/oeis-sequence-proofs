import Lean

namespace NoThreeLine

-- The determinant is written as equality of two sums to avoid truncated subtraction.
def allowed (a : Array Nat) (n y : Nat) : Bool :=
  (List.range n).all fun j =>
    (List.range j).all fun i =>
      (j-i)*y + (n-j)*a[i]! != (n-i)*a[j]!

def greedyPrefix (a : Array Nat) : Bool :=
  (List.range a.size).all fun n =>
    allowed a n a[n]! && (List.range a[n]!).all (fun y => !(allowed a n y))

def sample : Array Nat :=
  #[0,0,1,1,4,3,8,2,2,5,7,4,5,8,16,3,7,14,12,23,16,12,25,31]

theorem witness :
    greedyPrefix sample = true ∧ 4 * sample[23]! > 5 * 23 ∧
    4 * sample[23]! > 5 * 24 := by decide

end NoThreeLine

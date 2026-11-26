import FrohlichWitness

namespace Frohlich

theorem witness_413343_native : question 413343 := by
  apply witness_of_remainder
  rw [central_eval]
  native_decide

#print axioms witness_413343_native

end Frohlich

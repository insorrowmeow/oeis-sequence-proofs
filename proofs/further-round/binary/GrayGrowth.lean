import binary.GrayBounds
import binary.GrayLimit

open Filter
open scoped Topology

/-- Stanislav Sykora's mean-growth conjecture for the OEIS A265386 sequence. -/
theorem sykora_a265386 :
    Tendsto (fun n : ℕ => ((GrayBounds.seq (2*n) : ℝ) / (GrayBounds.seq n : ℝ))
      ^ (1 / (n : ℝ))) atTop (𝓝 (Real.sqrt 2)) :=
  GrayLimit.ratio_limit GrayBounds.seq GrayBounds.dyadic_bounds

#print axioms sykora_a265386

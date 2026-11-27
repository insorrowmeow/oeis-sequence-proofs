import Mathlib.Data.Finsupp.Multiset

namespace CriticalGap

/-- Record each slack index as many times as its coordinate specifies. -/
noncomputable def slackMultisetEquiv (j k : ℕ) :
    {w : Fin j → ℕ // (∑ i, w i) = k} ≃ Sym (Fin j) k :=
  (Sym.equivNatSumOfFintype (Fin j) k).symm

theorem slackMultisetEquiv_apply {j k : ℕ} (w : {w : Fin j → ℕ // (∑ i, w i) = k}) :
    (slackMultisetEquiv j k w : Multiset (Fin j)) = ∑ i, w.val i • {i} :=
  Sym.coe_equivNatSumOfFintype_symm_apply (Fin j) k w

theorem slackMultisetEquiv_symm_apply {j k : ℕ} (M : Sym (Fin j) k) (i : Fin j) :
    ((slackMultisetEquiv j k).symm M).val i = (M : Multiset (Fin j)).count i := rfl

end CriticalGap

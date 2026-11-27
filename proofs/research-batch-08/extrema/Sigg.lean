import extrema.SiggTuples
import extrema.SiggArithmetic

namespace Sigg

def canonicalOffset (n i : ℕ) : Prop :=
  n*(n+1)/2+i ∣ (n-1).factorial*(n+i)

instance (n i : ℕ) : Decidable (canonicalOffset n i) := by unfold canonicalOffset; infer_instance

private theorem triangle_large {n : ℕ} (hn : 3≤n) :
    2*n ≤ n*(n+1)/2 := by
  apply (Nat.le_div_iff_mul_le (by decide : 0<2)).mpr
  nlinarith [Nat.mul_le_mul_left n (show 4≤n+1 by omega)]

theorem canonical_exists {n : ℕ} (hn : 3≤n) : ∃ i, canonicalOffset n i := by
  let T := n*(n+1)/2
  let F := (n-1).factorial
  have hT : 2*n≤T := triangle_large hn
  have hF : 2≤F := Nat.factorial_le (by omega : 2≤n-1)
  let S := F*(T-n)
  have hS : T≤S := by
    have := Nat.mul_le_mul_right (T-n) hF
    dsimp [S]
    omega
  refine ⟨S-T,?_⟩
  change T+(S-T) ∣ F*(n+(S-T))
  rw [Nat.add_sub_of_le hS]
  refine ⟨F-1,?_⟩
  have he : S + n = T+(n+(S-T)) := by omega
  have h₁ : T-n+n=T := by omega
  have h₂ : F-1+1=F := by omega
  change F*(n+(S-T)) = S*(F-1)
  nlinarith only [congrArg (fun x : ℕ => F*x) he,
    congrArg (fun x : ℕ => F*x) h₁, congrArg (fun x : ℕ => S*x) h₂,
    show S = F*(T-n) from rfl]

def minOffset (n : ℕ) (hn : 3≤n) := Nat.find (canonical_exists hn)

/-- The actual set {1,2,...,n-1,n+i}. -/
def canonicalSet (n i : ℕ) : Finset ℕ := insert (n+i) (Finset.Icc 1 (n-1))

theorem canonical_set_data {n : ℕ} (hn : 3≤n) (i : ℕ) :
    (canonicalSet n i).card=n ∧ (∀ x∈canonicalSet n i, 0<x) ∧
    (canonicalSet n i).sum id=n*(n+1)/2+i ∧
    (canonicalSet n i).prod id=(n-1).factorial*(n+i) := by
  have hnot : n+i ∉ Finset.Icc 1 (n-1) := by simp; omega
  unfold canonicalSet
  rw [Finset.card_insert_of_not_mem hnot,Finset.sum_insert hnot,
    Finset.prod_insert hnot,SiggTuples.sum_interval,SiggTuples.prod_interval]
  simp only [Nat.card_Icc,id_eq]
  refine ⟨by omega,?_,?_,Nat.mul_comm _ _⟩
  · intro x hx
    rcases Finset.mem_insert.mp hx with rfl|h
    · omega
    · exact (Finset.mem_Icc.mp h).1
  · obtain _|r := n
    · omega
    simp only [Nat.succ_sub_one]
    have he : (r+1)*(r+1+1)=r*(r+1)+(r+1)*2 := by ring
    rw [he,Nat.add_mul_div_right _ _ (by decide : 0<2)]
    omega

def Admissible (n : ℕ) (s : Finset ℕ) : Prop :=
  s.card=n ∧ (∀ x∈s, 0<x) ∧ s.sum id ∣ s.prod id

theorem least_k {n : ℕ} (hn : 3≤n) :
    let a := n+minOffset n hn
    n≤a ∧ canonicalOffset n (a-n) ∧
      ∀ k≥n, canonicalOffset n (k-n) → a≤k := by
  dsimp only
  have h0 := Nat.find_spec (canonical_exists hn)
  refine ⟨by omega,by simpa [minOffset] using h0,?_⟩
  intro k hk h
  have hm : minOffset n hn ≤ k-n := Nat.find_min' (canonical_exists hn) h
  omega

private theorem minima_from_offset {n : ℕ} (hn : 3≤n)
    (first : ∀ j, n*(n+1)/2+j ∣ (n+j).factorial → ∃ i≤j, canonicalOffset n i) :
    let c := canonicalSet n (minOffset n hn)
    Admissible n c ∧ ∀ s, Admissible n s →
      c.sum id ≤ s.sum id ∧ c.prod id ≤ s.prod id ∧
        c.prod id / c.sum id ≤ s.prod id / s.sum id := by
  dsimp only
  let T := n*(n+1)/2
  let F := (n-1).factorial
  let i := minOffset n hn
  let c := canonicalSet n i
  have hcut : T+i ∣ F*(n+i) := Nat.find_spec (canonical_exists hn)
  obtain ⟨hcard,hpos,hcs,hcp⟩ := canonical_set_data hn i
  change c.sum id=T+i at hcs
  change c.prod id=F*(n+i) at hcp
  change Admissible n c ∧ _
  refine ⟨⟨hcard,hpos,by rwa [hcs,hcp]⟩,?_⟩
  rintro s ⟨hs,hspos,hsdvd⟩
  have hT : 2*n≤T := triangle_large hn
  have hsum := SiggTuples.tri_le_sum hspos
  rw [hs] at hsum
  change T≤s.sum id at hsum
  let j := s.sum id-T
  have hsj : s.sum id=T+j := by dsimp [j]; omega
  obtain ⟨_,hfactor,hprod⟩ := SiggTuples.tuple_bounds (by omega) hs hspos hsj
  obtain ⟨u,hu,hgood⟩ := first j (hsj ▸ dvd_trans hsdvd hfactor)
  have hi : i≤j := le_trans (Nat.find_min' (canonical_exists hn) hgood) hu
  change F*(n+j)≤s.prod id at hprod
  change c.sum id≤s.sum id ∧ c.prod id≤s.prod id ∧ c.prod id / c.sum id≤s.prod id / s.sum id
  rw [hcs,hcp,hsj]
  refine ⟨by omega,le_trans (Nat.mul_le_mul_left _ (by omega : n+i≤n+j)) hprod,?_⟩
  have hmono : (n+i)*(T+j) ≤ (n+j)*(T+i) := by
    obtain ⟨v,hv⟩ := Nat.exists_eq_add_of_le hi
    rw [hv]
    nlinarith [Nat.mul_le_mul_right v (show n≤T by omega)]
  apply (Nat.le_div_iff_mul_le (by omega : 0<T+j)).mpr
  apply Nat.le_of_mul_le_mul_right (c:=T+i) _ (by omega)
  calc
    F*(n+i)/(T+i)*(T+j)*(T+i) = F*(n+i)/(T+i)*(T+i)*(T+j) := by ring
    _ = F*(n+i)*(T+j) := by rw [Nat.div_mul_cancel hcut]
    _ ≤ F*(n+j)*(T+i) := by simpa only [Nat.mul_assoc] using Nat.mul_le_mul_left F hmono
    _ ≤ s.prod id*(T+i) := Nat.mul_le_mul_right _ hprod

/-- Sigg's conjecture for all positive n-element subsets. The offset is chosen
    by the actual least-index operator, and the three inequalities use the
    sum, product and integral quotient of the displayed feasible sets. -/
theorem simultaneous_minima {n : ℕ} (hn : 3≤n) :
    let c := canonicalSet n (minOffset n hn)
    Admissible n c ∧ ∀ s, Admissible n s →
      c.sum id ≤ s.sum id ∧ c.prod id ≤ s.prod id ∧
        c.prod id / c.sum id ≤ s.prod id / s.sum id :=
  minima_from_offset hn (fun _ hj => first_offset hn hj)

#print axioms simultaneous_minima

end Sigg

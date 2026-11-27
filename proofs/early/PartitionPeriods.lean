import Std

namespace PartitionPeriods

inductive Represented (parts : List Nat) : Nat → Prop
  | zero : Represented parts 0
  | part {a} : a ∈ parts → Represented parts a
  | add {a b} : Represented parts a → Represented parts b → Represented parts (a+b)

private theorem sum_represented (p : List Nat) : Represented p p.sum := by
  have h : ∀ q : List Nat, (∀ a ∈ q, a ∈ p) → Represented p q.sum := by
    intro q
    induction q with
    | nil => exact fun _ => .zero
    | cons a q ih =>
      intro sub
      exact .add (.part (sub a (by simp))) (ih (fun b h => sub b (by simp [h])))
  exact h p (fun _ ha => ha)

private theorem represented_multiple {p : List Nat} {n : Nat} (h : Represented p n) (m : Nat) :
    Represented p (m*n) := by
  induction m with
  | zero => simpa using (Represented.zero : Represented p 0)
  | succ m ih => simpa [Nat.succ_mul] using ih.add h

private theorem singleton_dvd {n k : Nat} (h : Represented [n] k) : n ∣ k := by
  induction h with
  | zero => exact Nat.dvd_zero _
  | part mem => simpa using (List.mem_singleton.mp mem ▸ Nat.dvd_refl n)
  | add _ _ ih jh => exact Nat.dvd_add ih jh

private def words (n : Nat) : Nat → List (List Nat)
  | 0 => [[]]
  | k+1 => [] :: ((List.range n).map Nat.succ).flatMap
      (fun a => (words n k).map (a :: ·))

/-- Enumerate weakly decreasing lists of positive parts summing to n. Every
such list has at most n entries, and every entry is at most n. -/
def partitions (n : Nat) : List (List Nat) :=
  (words n n).filter (fun p => decide (p.sum=n ∧ p.Pairwise (· ≥ ·)))

private theorem alphabet_mem (a n : Nat) :
    a ∈ (List.range n).map Nat.succ ↔ 0<a ∧ a≤n := by
  cases a <;> simp [List.mem_map] <;> omega

private theorem words_mem {n k : Nat} {p : List Nat} :
    p ∈ words n k ↔ p.length≤k ∧ ∀ a ∈ p, 0<a ∧ a≤n := by
  induction k generalizing p with
  | zero => cases p <;> simp [words]
  | succ k ih =>
    cases p with
    | nil => simp [words]
    | cons a p =>
      simp only [words, List.mem_cons, List.cons_ne_nil, false_or, List.mem_flatMap]
      constructor
      · rintro ⟨b,hb,member⟩
        obtain ⟨q,hq,eq⟩ := List.mem_map.mp member
        cases eq
        obtain ⟨len,elts⟩ := ih.mp hq
        have := (alphabet_mem a n).mp hb
        simp_all
      · rintro ⟨len,elts⟩
        have ha := elts a (Or.inl rfl)
        refine ⟨a, (alphabet_mem a n).mpr ha, List.mem_map.mpr ⟨p, ih.mpr ⟨?_,?_⟩, rfl⟩⟩
        · simpa using len
        · exact fun b hb => elts b (Or.inr hb)

private theorem part_le_sum {a : Nat} {p : List Nat} (h : a ∈ p) : a ≤ p.sum := by
  induction p with
  | nil => simp at h
  | cons b p ih =>
    obtain eq | rest := List.mem_cons.mp h
    · simp [eq]
    · have := ih rest
      simp only [List.sum_cons]
      omega

private theorem length_le_sum {p : List Nat} (pos : ∀ a ∈ p, 0<a) : p.length ≤ p.sum := by
  induction p with
  | nil => simp
  | cons a p ih =>
    have head := pos a (by simp)
    have tail := ih (fun b h => pos b (by simp [h]))
    simp only [List.sum_cons, List.length_cons]
    omega

theorem mem_partitions {n : Nat} {p : List Nat} :
    p ∈ partitions n ↔ p.sum=n ∧ p.Pairwise (· ≥ ·) ∧ ∀ a ∈ p, 0<a := by
  simp only [partitions, List.mem_filter, words_mem, decide_eq_true_eq]
  constructor
  · rintro ⟨⟨_,all⟩,sum,sort⟩
    exact ⟨sum, sort, fun a h => (all a h).1⟩
  · rintro ⟨sum, sort, pos⟩
    subst n
    exact ⟨⟨length_le_sum pos, fun a h => ⟨pos a h, part_le_sum h⟩⟩, rfl, sort⟩

private theorem words_nodup (n k : Nat) : (words n k).Nodup := by
  induction k with
  | zero => simp [words]
  | succ k ih =>
    apply List.nodup_cons.mpr
    constructor
    · simp [List.mem_flatMap, List.mem_map]
    · apply List.pairwise_flatMap.mpr
      constructor
      · intro a _
        apply List.pairwise_map.mpr
        exact ih.imp (fun h eq => h (List.cons.inj eq).2)
      · apply List.pairwise_map.mpr
        apply List.nodup_range.imp
        intro a b h x hx y hy eq
        obtain ⟨s,_,rfl⟩ := List.mem_map.mp hx
        obtain ⟨t,_,rfl⟩ := List.mem_map.mp hy
        exact h (Nat.succ.inj (List.cons.inj eq).1)

theorem partitions_nodup (n : Nat) : (partitions n).Nodup :=
  (words_nodup n n).filter _

private theorem singleton_partition {n : Nat} (hn : 0 < n) : [n] ∈ partitions n := by
  simp [mem_partitions, hn]

private theorem partition_sum {n : Nat} {p : List Nat} (h : p ∈ partitions n) : p.sum=n :=
  (mem_partitions.mp h).1

attribute [local instance] Classical.propDecidable

private noncomputable def hits (k : Nat) : List (List Nat) → Nat
  | [] => 0
  | p :: ps => if Represented p k then hits k ps + 1 else hits k ps

noncomputable def row (n k : Nat) := hits k (partitions n)

private theorem hits_le (k : Nat) (ps : List (List Nat)) : hits k ps ≤ ps.length := by
  induction ps with
  | nil => simp [hits]
  | cons p ps ih => simp only [hits, List.length_cons]; split <;> omega

private theorem full (k : Nat) (ps : List (List Nat)) :
    hits k ps = ps.length ↔ ∀ p ∈ ps, Represented p k := by
  induction ps with
  | nil => simp [hits]
  | cons p ps ih =>
    by_cases h : Represented p k
    · simp [hits, h, ih]
    · have bound := hits_le k ps
      simp [hits, h]
      omega

private theorem step {n k : Nat} (ps : List (List Nat)) (sums : ∀ p ∈ ps, p.sum=n) :
    hits k ps ≤ hits (k+n) ps := by
  induction ps with
  | nil => simp [hits]
  | cons p ps ih =>
    have tail := ih (fun q h => sums q (by simp [h]))
    have hp := sum_represented p
    rw [sums p (by simp)] at hp
    simp only [hits]
    split
    · rename_i mem
      rw [if_pos (mem.add hp)]
      omega
    · split <;> omega

private theorem max_attained {a : Nat → Nat} (M : Nat) (bound : ∀ j, a j ≤ M) :
    ∃ i, ∀ j, a j ≤ a i := by
  induction M with
  | zero => exact ⟨0, fun j => by have := bound j; omega⟩
  | succ M ih =>
    by_cases high : ∃ i, a i = M+1
    · obtain ⟨i,h⟩ := high
      exact ⟨i, fun j => by simpa [h] using bound j⟩
    · apply ih
      intro j
      have := bound j
      have : a j ≠ M+1 := fun eq => high ⟨_,eq⟩
      omega

private theorem residue_stabilizes (n r : Nat) :
    ∃ i, ∀ j, i ≤ j → row n (r+j*n) = row n (r+(j+1)*n) := by
  let a := fun j => row n (r+j*n)
  have grow (i) : a i ≤ a (i+1) := by
    simpa [a, row, Nat.succ_mul, Nat.add_assoc] using
      (step (n:=n) (k:=r+i*n) (partitions n) (fun _ h => partition_sum h))
  have mono {i j : Nat} (h : i ≤ j) : a i ≤ a j := by
    induction h with
    | refl => exact Nat.le_refl _
    | step h ih => exact Nat.le_trans ih (grow _)
  obtain ⟨i,bound⟩ := max_attained (a:=a) (partitions n).length (fun j => hits_le _ _)
  exact ⟨i, fun j h => Nat.le_antisymm (grow j) (Nat.le_trans (bound _) (mono h))⟩

private theorem uniform_bound (n m : Nat) :
    ∃ b, ∀ r, r < m → ∀ j, b ≤ j → row n (r+j*n) = row n (r+(j+1)*n) := by
  induction m with
  | zero => exact ⟨0, by omega⟩
  | succ m ih =>
    obtain ⟨b,hb⟩ := ih
    obtain ⟨c,hc⟩ := residue_stabilizes n m
    refine ⟨max b c, ?_⟩
    intro r hr j hj
    by_cases eq : r=m
    · subst r
      exact hc _ (Nat.le_trans (Nat.le_max_right ..) hj)
    · exact hb r (by omega) _ (Nat.le_trans (Nat.le_max_left ..) hj)

def EventualPeriod (n period : Nat) : Prop :=
  ∃ K, ∀ k, K ≤ k → row n (k+period) = row n k

theorem row_period {n : Nat} (hn : 0 < n) : EventualPeriod n n := by
  obtain ⟨b, stable⟩ := uniform_bound n n
  refine ⟨b*n, ?_⟩
  intro k hk
  have bound := (Nat.le_div_iff_mul_le hn).mpr hk
  have eq := (stable (k%n) (Nat.mod_lt k hn) (k/n) bound).symm
  have divmod : k%n + k/n*n = k := by simpa [Nat.mul_comm] using Nat.mod_add_div k n
  simpa only [Nat.succ_mul, ← Nat.add_assoc, divmod] using eq

theorem divides_period {n period : Nat} (hn : 0 < n) (h : EventualPeriod n period) : n ∣ period := by
  obtain ⟨K, eq⟩ := h
  have fullK : hits (K*n) (partitions n) = (partitions n).length := by
    apply (full ..).mpr
    intro p hp
    have h := sum_represented p
    rw [partition_sum hp] at h
    exact represented_multiple h K
  have shifted := (eq (K*n) (Nat.le_mul_of_pos_right _ hn)).trans fullK
  have mem := (full ..).mp shifted [n] (singleton_partition hn)
  exact (Nat.dvd_add_iff_right (Nat.dvd_mul_left n K)).mpr (singleton_dvd mem)

theorem least_period {n : Nat} (hn : 0 < n) :
    EventualPeriod n n ∧ ∀ p, 0 < p → EventualPeriod n p → n ≤ p :=
  ⟨row_period hn, fun _ hp h => Nat.le_of_dvd hp (divides_period hn h)⟩

end PartitionPeriods

#print axioms PartitionPeriods.least_period

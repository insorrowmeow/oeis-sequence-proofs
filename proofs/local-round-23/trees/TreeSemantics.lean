import TreeEnumeration
import Mathlib.Data.List.Nodup
import Mathlib.Algebra.BigOperators.Ring.List

/-! Completeness and uniqueness of the ordered-forest enumeration. -/
namespace VoloshynTrees

private theorem choice_list (u v : Forest) :
    choices u v = (List.range (labels u+1)).map (fun i => .cons (2+i) u v) := by
  simp [choices,List.range_succ]

private theorem mem_choices {w u v : Forest} :
    w ∈ choices u v ↔ ∃ a, 2 ≤ a ∧ a ≤ 2 + labels u ∧ w = .cons a u v := by
  rw [choice_list]
  constructor
  · intro h
    obtain ⟨i,hi,rfl⟩ := List.mem_map.mp h
    have hb := List.mem_range.mp hi
    exact ⟨2+i,by omega,by omega,rfl⟩
  · rintro ⟨a,ha,hb,rfl⟩
    apply List.mem_map.mpr
    exact ⟨a-2, List.mem_range.mpr (by omega), by congr 1; omega⟩

private theorem mem_join {w : Forest} {A B : List Forest} :
    w ∈ joinAll A B ↔ ∃ u ∈ A, ∃ v ∈ B, ∃ a,
      2 ≤ a ∧ a ≤ 2+labels u ∧ w = .cons a u v := by
  simp only [joinAll,List.mem_flatMap,mem_choices]

theorem mem_forests {w : Forest} {n : ℕ} :
    w ∈ forests n ↔ nodes w = n ∧ valid w := by
  induction n using Nat.strong_induction_on generalizing w with
  | h n ih =>
    cases n with
    | zero =>
      cases w <;> simp [forests,nodes,valid]
    | succ n =>
      rw [forests,List.mem_flatMap]
      constructor
      · rintro ⟨i,_,hi⟩
        obtain ⟨u,hu,v,hv,a,ha,hb,rfl⟩ := mem_join.mp hi
        obtain ⟨un,uv⟩ := (ih i.val i.isLt).mp hu
        obtain ⟨vn,vv⟩ := (ih (n-i.val) (by omega)).mp hv
        refine ⟨?_,ha,hb,uv,vv⟩
        simp only [nodes,un,vn]
        omega
      · rintro ⟨hn,hv⟩
        cases w with
        | empty => simp [nodes] at hn
        | cons a u v =>
          change nodes u + nodes v + 1 = n+1 at hn
          obtain ⟨ha,hb,hu,hv⟩ := hv
          let i : Fin (n+1) := ⟨nodes u,by omega⟩
          refine ⟨i, List.mem_finRange _, mem_join.mpr ⟨u, ?_,v, ?_,a,ha,hb,rfl⟩⟩
          · exact (ih i.val i.isLt).mpr ⟨rfl,hu⟩
          · exact (ih (n-i.val) (by omega)).mpr ⟨by dsimp [i]; omega,hv⟩

private theorem nodup_choices (u v : Forest) : (choices u v).Nodup := by
  rw [choice_list]
  apply List.Nodup.map _ List.nodup_range
  intro i j h
  exact Nat.add_left_cancel (Forest.cons.inj h).1

private theorem nodup_join {A B : List Forest} (hA : A.Nodup) (hB : B.Nodup) :
    (joinAll A B).Nodup := by
  apply List.nodup_flatMap.mpr
  refine ⟨fun u _ => List.nodup_flatMap.mpr ⟨fun v _ => nodup_choices u v, ?_⟩, ?_⟩
  · apply hB.imp
    intro v v' hne w hw hw'
    obtain ⟨a,_,_,rfl⟩ := mem_choices.mp hw
    obtain ⟨b,_,_,he⟩ := mem_choices.mp hw'
    exact hne (Forest.cons.inj he).2.2
  · apply hA.imp
    intro u u' hne w hw hw'
    obtain ⟨v,_,hw⟩ := List.mem_flatMap.mp hw
    obtain ⟨v',_,hw'⟩ := List.mem_flatMap.mp hw'
    obtain ⟨a,_,_,rfl⟩ := mem_choices.mp hw
    obtain ⟨b,_,_,he⟩ := mem_choices.mp hw'
    exact hne (Forest.cons.inj he).2.1

theorem forests_nodup (n : ℕ) : (forests n).Nodup := by
  induction n using Nat.strong_induction_on with
  | h n ih =>
    cases n with
    | zero => simp [forests]
    | succ n =>
      rw [forests,List.nodup_flatMap]
      refine ⟨fun i _ => nodup_join (ih i.val i.isLt) (ih _ (by omega)), ?_⟩
      apply (List.nodup_finRange _).imp
      intro i j hne w hw hw'
      obtain ⟨u,hu,v,_,a,_,_,rfl⟩ := mem_join.mp hw
      obtain ⟨u',hu',v',_,a',_,_,he⟩ := mem_join.mp hw'
      have ix := (mem_forests.mp hu).1
      have jx := (mem_forests.mp hu').1
      exact hne (Fin.ext (ix.symm.trans ((congrArg nodes (Forest.cons.inj he).2.1).trans jx)))

/-- Count the leaves and the maximal internal vertices separately. -/
def leaves : Forest → ℕ
  | .empty => 0
  | .cons _ u v => (if u = .empty then 1 else 0) + leaves u + leaves v

def maximalInternal : Forest → ℕ
  | .empty => 0
  | .cons a u v => (if u ≠ .empty ∧ a=2+labels u then 1 else 0) +
      maximalInternal u + maximalInternal v

theorem marks_statistic {w : Forest} (hw : valid w) :
    marks w = leaves w + maximalInternal w := by
  induction w with
  | empty => rfl
  | cons a u v ihu ihv =>
    obtain ⟨ha,hb,hu,hv⟩ := hw
    obtain rfl | h := eq_or_ne u .empty
    · have he : a = 2 := by simp only [labels] at hb; omega
      subst a
      simp [marks,leaves,maximalInternal,ihv hv,labels]
      omega
    · by_cases hm : a = 2 + labels u <;>
        simp [marks,leaves,maximalInternal,h,hm,ihu hu,ihv hv] <;> omega

/-- A description tree with s edges. The list of ordered children is encoded
    by its forest. Every non-root vertex is the lower endpoint of one edge. -/
structure DescriptionTree (s : ℕ) where
  rootLabel : ℕ
  children : Forest
  nonrootRules : valid children
  edgeCount : nodes children = s
  rootRule : rootLabel = 2+labels children

def completeRoot (w : Forest) := Forest.cons (2+labels w) w .empty

def rootEquiv (s : ℕ) : {w : Forest // w ∈ forests s} ≃ DescriptionTree s where
  toFun w := ⟨2+labels w.val,w.val,(mem_forests.mp w.property).2,(mem_forests.mp w.property).1,rfl⟩
  invFun t := ⟨t.children,mem_forests.mpr ⟨t.edgeCount,t.nonrootRules⟩⟩
  left_inv _ := rfl
  right_inv t := by rcases t with ⟨a,w,hv,hn,rfl⟩; rfl

/-- The source's ν statistic, computed on the entire rooted tree. -/
def nu {s : ℕ} (t : DescriptionTree s) : ℕ :=
  let tree := Forest.cons t.rootLabel t.children .empty
  leaves tree + maximalInternal tree

theorem nu_eq {s : ℕ} (t : DescriptionTree s) :
    nu t = 1 + marks t.children := by
  rcases t with ⟨a,w,hv,hn,rfl⟩
  have hh : valid (completeRoot w) := ⟨by omega,le_rfl,hv,True.intro⟩
  change leaves (completeRoot w) + maximalInternal (completeRoot w) = 1+marks w
  rw [← marks_statistic hh]
  simp [completeRoot,marks]

private theorem positive_marks {w : Forest} (hw : valid w) (hn : w ≠ .empty) :
    0 < marks w := by
  induction w with
  | empty => contradiction
  | cons a u v ihu _ =>
    obtain ⟨ha,hb,hu,_⟩ := hw
    obtain rfl | h := eq_or_ne u .empty
    · have he : a=2 := by simp only [labels] at hb; omega
      simp [marks,labels,he]
    · have ht := ihu hu h
      simp only [marks]
      omega

/-- Each allowed rooted, ordered tree appears once. -/
def descriptionTrees (s : ℕ) : List (DescriptionTree s) :=
  (forests s).attach.map (rootEquiv s)

theorem descriptionTrees_complete {s : ℕ} (t : DescriptionTree s) : t ∈ descriptionTrees s := by
  exact List.mem_map.mpr ⟨(rootEquiv s).symm t,List.mem_attach _ _,(rootEquiv s).apply_symm_apply t⟩

theorem descriptionTrees_nodup (s : ℕ) : (descriptionTrees s).Nodup :=
  (forests_nodup s).attach.map (rootEquiv s).injective

noncomputable instance (s : ℕ) : Fintype (DescriptionTree s) := by
  classical exact Fintype.ofList (descriptionTrees s) descriptionTrees_complete

def treeRow {R : Type*} [CommRing R] (z : R) (s : ℕ) : R :=
  ((descriptionTrees s).map fun t => z^(nu t-2)).sum

theorem treeRow_eq_sum {R : Type*} [CommRing R] (z : R) (s : ℕ) :
    treeRow z s = ∑ t : DescriptionTree s, z^(nu t-2) := by
  classical
  have hu : (descriptionTrees s).toFinset = Finset.univ := by
    ext t; simp [descriptionTrees_complete]
  rw [← hu]
  exact (List.sum_toFinset _ (descriptionTrees_nodup s)).symm

theorem Wrow_eq_z_mul_treeRow {R : Type*} [CommRing R] (z : R) {s : ℕ} (hs : 0 < s) :
    Wrow z 1 s = z * treeRow z s := by
  change ((forests s).map (wt z 1)).sum = z*_
  unfold treeRow descriptionTrees
  rw [List.map_map, ← List.sum_map_mul_left, ← List.attach_map_val]
  apply congrArg List.sum
  apply List.map_congr_left
  intro w _
  have hn := (mem_forests.mp w.property).1
  have hp : 0 < marks w.val := positive_marks (mem_forests.mp w.property).2 (by
    intro h; simp [h,nodes] at hn; omega)
  have ht := nu_eq (rootEquiv s w)
  change nu (rootEquiv s w) = 1+marks w.val at ht
  have he : marks w.val = (nu (rootEquiv s w)-2)+1 := by omega
  simp only [wt,one_pow,mul_one,Function.comp_apply]
  rw [he,pow_succ,mul_comm]

#print axioms mem_forests
#print axioms forests_nodup
#print axioms nu_eq
#print axioms Wrow_eq_z_mul_treeRow
end VoloshynTrees

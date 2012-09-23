Require Import ProofIrrelevance.
Require Export Coend LimitFunctors.
Require Import Common Notations ChainCategory.

Set Implicit Arguments.

Generalizable All Variables.

Local Open Scope type_scope.

Section Coend.
  Context `(C : @SpecializedCategory objC).
  Context `(D : @SpecializedCategory objD).

  Let COp := OppositeCategory C.

  Variable F : SpecializedFunctor (COp * C) D.

  Definition CoendFunctor_Index_Object := { ds : objC * objC & Morphism C (snd ds) (fst ds) } + objC.

  Global Arguments CoendFunctor_Index_Object /.

  Definition CoendFunctor_Index_Morphism (s d : CoendFunctor_Index_Object) : Set :=
    match (s, d) with
      | (inl sdm, inr c) => (fst (projT1 sdm) = c) + (snd (projT1 sdm) = c)
      | _ => (s = d)
    end.

  Global Arguments CoendFunctor_Index_Morphism s d /.

  Definition CoendFunctor_Index_Identity x : CoendFunctor_Index_Morphism x x :=
    match x as s return (CoendFunctor_Index_Morphism s s) with
      | inl s => eq_refl
      | inr s => eq_refl
    end.

  Global Arguments CoendFunctor_Index_Identity x /.

  Ltac inj H := injection H; clear H; intros; subst.
  
  Definition CoendFunctor_Index_Compose s d d' :
    CoendFunctor_Index_Morphism d d'
    -> CoendFunctor_Index_Morphism s d
    -> CoendFunctor_Index_Morphism s d'.
  Proof.
    destruct s, d, d'; simpl; intros;
      try abstract congruence;
        match goal with
          | [ H : _ + _ |- _ ] => destruct H; [ left | right ];
            abstract congruence
        end.
  Defined.

  Definition CoendFunctor_Index : SpecializedCategory CoendFunctor_Index_Object.
  Proof.
    refine {|
      Morphism' := CoendFunctor_Index_Morphism;
      Identity' := CoendFunctor_Index_Identity;
      Compose' := CoendFunctor_Index_Compose
    |}; abstract (simpl; intros;
      repeat (match goal with
                | [ x : _ + _ |- _ ] => destruct x; simpl in *
                | _ => apply proof_irrelevance
                | _ => congruence
                | _ => f_equal
              end)).
  Defined.

  Definition CoendFunctor_Diagram_ObjectOf : CoendFunctor_Index -> D :=
    fun x => match x with
               | inl c0c1 => F (projT1 c0c1)
               | inr c => F (c, c)
             end.

  Global Arguments CoendFunctor_Diagram_ObjectOf _ /.

  Hint Resolve Identity.
  Hint Extern 1 (Morphism' _ ?X ?X) => apply Identity.
  Hint Extern 1 (Morphism' _ _ _) => hnf.
  Hint Extern 1 (Morphism _ _ _) => apply F.

  Definition CoendFunctor_Diagram_MorphismOf s d :
    CoendFunctor_Index_Morphism s d
    -> Morphism D (CoendFunctor_Diagram_ObjectOf s) (CoendFunctor_Diagram_ObjectOf d).
  Proof.
    destruct s, d; simpl in *; intros;
      repeat match goal with
               | _ => discriminate
               | [ H : inl _ = inl _ |- _ ] => inj H
               | [ H : inr _ = inr _ |- _ ] => inj H
               | [ H : sigT _ |- _ ] => destruct H; simpl in *
               | [ H : _ + _ |- _ ] => destruct H; subst
             end; auto.
  Defined.

  Ltac inj' H :=
    match type of H with
      | ?X = ?X => fail 1
      | _ => injection H; intros; subst
    end.

  Definition CoendFunctor_Diagram : SpecializedFunctor CoendFunctor_Index D.
  Proof.
    refine (Build_SpecializedFunctor
      CoendFunctor_Index D
      CoendFunctor_Diagram_ObjectOf
      CoendFunctor_Diagram_MorphismOf
      _
      _);
    repeat match goal with
             | [ |- forall x : CoendFunctor_Index_Object, _ ] =>
               destruct x
           end; simpl; intros;
    repeat match goal with
             | _ => discriminate
             | _ => progress (subst; unfold eq_rect_r)
             | [ H : inl _ = inl _ |- _ ] => inj' H
             | [ H : inr _ = inr _ |- _ ] => inj' H
             | [ x : sigT _ |- _ ] => destruct x; simpl in *
             | [ H : _ + _ |- _ ] => destruct H
             | _ => rewrite <- eq_rect_eq
           end; auto.
  Defined.

  Hypothesis HasColimits : forall G : SpecializedFunctor CoendFunctor_Index D, Colimit G.

  Definition CoendFunctor := ColimitFunctor HasColimits.
End Coend.

(* TODO: Figure out why the notation for this is the same as the notation for the Grothendieck construction *)
(*Notation "∫ F" := (Coend F).*)
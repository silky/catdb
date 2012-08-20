Require Export SpecializedCategory Functor.
Require Import Common.

Set Implicit Arguments.

Generalizable All Variables.

Section SumCategory.
  Context `(C : @SpecializedCategory objC morC).
  Context `(D : @SpecializedCategory objD morD).

  Definition SumCategory_Morphism (s d : objC + objD) : Type
    := match (s, d) with
         | (inl s, inl d) => morC s d
         | (inr s, inr d) => morD s d
         | _ => Empty_set
       end.

  Global Arguments SumCategory_Morphism _ _ /.

  Definition SumCategory_Identity (x : C + D) : SumCategory_Morphism x x
    := match x with
         | inl x => Identity x
         | inr x => Identity x
       end.

  Global Arguments SumCategory_Identity _ /.

  Definition SumCategory_Compose (s d d' : C + D) (m1 : SumCategory_Morphism d d') (m2 : SumCategory_Morphism s d) : SumCategory_Morphism s d'.
    (* XXX NOTE: try to use typeclasses and work up to existance of morphisms here *)
    case s, d, d'; simpl in *; try destruct_to_empty_set; present_spcategory_all;
      eapply Compose; eassumption.
  Defined.

  Global Arguments SumCategory_Compose [_ _ _] _ _ /.

  Definition SumCategory : @SpecializedCategory (objC + objD)%type SumCategory_Morphism.
    refine {|
      Identity' := SumCategory_Identity;
      Compose' := SumCategory_Compose
    |};
    abstract (
      repeat match goal with
               | [ H : Empty_set |- _ ] => case H
               | _ => let H := fresh in intro H; try (case H; clear H); simpl in *
             end;
      t_with t'
    ).
  Defined.
End SumCategory.

Infix "+" := SumCategory : category_scope.

Section SumCategoryFunctors.
  Context `(C : @SpecializedCategory objC morC).
  Context `(D : @SpecializedCategory objD morD).

  Definition inl_Functor : SpecializedFunctor C (C + D).
    match goal with
      | [ |- SpecializedFunctor ?C ?D ] =>
        refine (Build_SpecializedFunctor C D
          (@inl _ _)
          (fun _ _ m => m)
          _
          _
        )
    end;
    abstract eauto.
  Defined.

  Definition inr_Functor : SpecializedFunctor D (C + D).
    match goal with
      | [ |- SpecializedFunctor ?C ?D ] =>
        refine (Build_SpecializedFunctor C D
          (@inr _ _)
          (fun _ _ m => m)
          _
          _
        )
    end;
    abstract eauto.
  Defined.
End SumCategoryFunctors.

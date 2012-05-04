Require Import Bool Omega.

Set Implicit Arguments.

Section path'.
  Variable V : Type.
  Variable E : V -> V -> Type.

  Inductive path' (s : V) : V -> Type :=
  | NoEdges : path' s s
  | AddEdge : forall d d', path' s d -> E d d' -> path' s d'.

  Fixpoint prepend s d (p : path' s d) : forall s', E s' s -> path' s' d :=
    match p with
      | NoEdges => fun _ E' => AddEdge (NoEdges _) E'
      | AddEdge _ _ p' E => fun _ E' => AddEdge (prepend p' E') E
    end.

  Fixpoint concatenate s d d' (p : path' s d) (p' : path' d d') : path' s d' :=
    match p' with
      | NoEdges => p
      | AddEdge _ _ p' E => AddEdge (concatenate p p') E
    end.

  Fixpoint concatenate' s d (p : path' s d) : forall d', path' d d' -> path' s d' :=
    match p with
      | NoEdges => fun _ p' => p'
      | AddEdge _ _ p E => fun _ p' => concatenate' p (prepend p' E)
    end.

  Variable typeOf : V -> Type.
  Variable functionOf : forall s d, E s d -> typeOf s -> typeOf d.

  Fixpoint compose s d (p : path' s d) : typeOf s -> typeOf d :=
    match p with
      | NoEdges => fun x => x
      | AddEdge _ _ p' E => fun x => functionOf E (compose p' x)
    end.
End path'.

Implicit Arguments NoEdges [V E s].
Implicit Arguments AddEdge [V E s d d'].
Implicit Arguments prepend [V E s d s'].

Section path'_Theorems.
  Variable V : Type.
  Variable E : V -> V -> Type.

  Lemma concatenate_noedges_p : forall s d (p : path' E s d), (concatenate NoEdges p) = p.
    intros.
    induction p; trivial; simpl.
    rewrite IHp; trivial.
  Qed.

  Lemma concatenate_p_noedges : forall s d (p : path' E s d), (concatenate p NoEdges) = p.
    simpl; trivial.
  Qed.

  Lemma concatenate'_addedge : forall s d d' d'' (p : path' E s d) (p' : path' E d d') (e : E d' d''), concatenate' p (AddEdge p' e) = AddEdge (concatenate' p p') e.
    intros; intuition.
    induction p; simpl; trivial.
  Qed.


  Lemma addedge_equal : forall s d d' (p p' : path' E s d), (p = p') -> (forall (e : E d d'), (AddEdge p e = AddEdge p' e)).
    intros; intuition.
    congruence.
  Qed.

  Lemma concatenate'_p_noedges : forall s d (p : path' E s d), concatenate' p NoEdges = p.
    intros; intuition.
    induction p; intuition; simpl.
    rewrite concatenate'_addedge.
    rewrite (addedge_equal IHp).
    trivial.
  Qed.

  Lemma concatenate'_noedges_p : forall s d (p : path' E s d), concatenate' NoEdges p = p.
    intros; intuition.
  Qed.
  
  
  Lemma concatenate_prepend_equivalent : forall s d d' (p : path' E s d) (p' : path' E d d'), (concatenate p p') = (concatenate' p p').
    intuition.
    induction p; simpl; intuition.
    rewrite concatenate_noedges_p; trivial.
    assert (H : (forall s d d' (p : path' E s d)  (e : E _ d'), AddEdge p e = concatenate p (AddEdge NoEdges e))).
    simpl; trivial.
    induction p'; simpl; intuition.
    rewrite concatenate'_addedge.
    rewrite concatenate'_p_noedges; trivial.
    rewrite concatenate'_addedge.
    assert (H0 : (forall s d d' d'' (p : path' E s d) (p' : path' E d' d'') (e : E d d'),
      (concatenate (AddEdge p e) p') = (concatenate' p (prepend p' e)))).
    intros; simpl; intuition.
    induction p'0; simpl; intuition; trivial.
    rewrite concatenate'_addedge. rewrite concatenate'_p_noedges. trivial.
    rewrite concatenate'_addedge; simpl. rewrite (addedge_equal IHp'0); trivial.
    rewrite H0; trivial.
  Qed.
End path'_Theorems.


Section EquivalenceRelation.
  Variable Object : Type.
  Variable Relation : Object -> Object -> Type.
  Variable RelationsEquivalent' : forall o1 o2, Relation o1 o2 -> Relation o1 o2 -> Prop.

  Implicit Arguments RelationsEquivalent' [o1 o2].

  Record EquivalenceRelation := {
    RelationsEquivalent :> forall o1 o2, Relation o1 o2 -> Relation o1 o2 -> Prop := RelationsEquivalent';
    Reflexive : forall o1 o2 (r : Relation o1 o2),
      RelationsEquivalent r r;
    Symmetric : forall o1 o2 (r1 r2 : Relation o1 o2),
      RelationsEquivalent r1 r2 -> RelationsEquivalent r2 r1;
    Transitive : forall o1 o2 (r1 r2 r3 : Relation o1 o2),
      RelationsEquivalent r1 r2 -> RelationsEquivalent r2 r3 -> RelationsEquivalent r1 r3
  }.
End EquivalenceRelation.

Implicit Arguments EquivalenceRelation [Object Relation].
Implicit Arguments RelationsEquivalent [Object Relation o1 o2].
Implicit Arguments Reflexive [Object Relation RelationsEquivalent' o1 o2].
Implicit Arguments Symmetric [Object Relation RelationsEquivalent' o1 o2].
Implicit Arguments Transitive [Object Relation RelationsEquivalent' o1 o2].

Record Category := {
  Vertex :> Type;
  Edge : Vertex -> Vertex -> Type;

  PathsEquivalent : forall s d, (path' Edge s d) -> (path' Edge s d) -> Prop;
  PathsEquivalence : EquivalenceRelation PathsEquivalent;

  PreCompose : forall s d (E : Edge s d) d' (p1 p2 : path' _ d d'),
    PathsEquivalent p1 p2 -> PathsEquivalent (prepend p1 E) (prepend p2 E);
  PostCompose : forall s d (p1 p2 : path' _ s d) d' (E : Edge d d'),
    PathsEquivalent p1 p2 -> PathsEquivalent (AddEdge p1 E) (AddEdge p2 E)
}.

Section Category.
  Variable C : Category.

  Definition path := path' C.(Edge).

  Record Instance := {
    TypeOf :> C -> Type;
    FunctionOf : forall s d (E : C.(Edge) s d), TypeOf s -> TypeOf d;
    EquivalenceOf : forall s d (p1 p2 : path s d), C.(PathsEquivalent) p1 p2
      -> forall x, compose TypeOf FunctionOf p1 x = compose TypeOf FunctionOf p2 x
  }.

  Record NaturalTransformation (I J : Instance) := {
    ComponentsOf :> forall c : C, I c -> J c;
    Commutes : forall s d (p : path s d),
      forall x, ComponentsOf d (compose I I.(FunctionOf) p x)
        = compose J J.(FunctionOf) p (ComponentsOf s x)
  }.
End Category.

Section Categories.
  Variables C D : Category.

  Section transferPath.
    Variable vertexOf : C -> D.
    Variable pathOf : forall s d, C.(Edge) s d -> path D (vertexOf s) (vertexOf d).

    Fixpoint transferPath s d (p : path C s d) : path D (vertexOf s) (vertexOf d) :=
      match p with
        | NoEdges => NoEdges
        | AddEdge _ _ p' E => concatenate (transferPath p') (pathOf _ _ E)
      end.
  End transferPath.

  Record Functor := {
    VertexOf :> C -> D;
    PathOf : forall s d, C.(Edge) s d -> path D (VertexOf s) (VertexOf d);
    FEquivalenceOf : forall s d (p1 p2 : path C s d),
      PathsEquivalent C p1 p2
      -> PathsEquivalent D (transferPath VertexOf PathOf p1) (transferPath VertexOf PathOf p2)
  }.
End Categories.

Record SaturatedCategory := {
  Object :> Type;
  Morphism : Object -> Object -> Type;

  MorphismsEquivalent : forall o1 o2, (Morphism o1 o2) -> (Morphism o1 o2) -> Prop;
  MorphismsEquivalence : EquivalenceRelation MorphismsEquivalent;

  Identity : forall o, Morphism o o;
  Compose : forall s d d', Morphism d d' -> Morphism s d -> Morphism s d';

  PreComposeMorphisms : forall s d d' (m : Morphism d d') (m1 m2 : Morphism s d),
    MorphismsEquivalent m1 m2 -> MorphismsEquivalent (Compose m m1) (Compose m m2);
  PostComposeMorphisms : forall s d d' (m1 m2 : Morphism d d') (m : Morphism s d),
    MorphismsEquivalent m1 m2 -> MorphismsEquivalent (Compose m1 m) (Compose m2 m);

  Associativity : forall o1 o2 o3 o4 (m1 : Morphism o1 o2) (m2 : Morphism o2 o3) (m3 : Morphism o3 o4),
    MorphismsEquivalent (Compose (Compose m3 m2) m1) (Compose m3 (Compose m2 m1));
  IdentityAxiom : forall a b (f : Morphism a b),
    MorphismsEquivalent (Compose (Identity b) f) f /\
    MorphismsEquivalent (Compose f (Identity a)) f
}.

Implicit Arguments Compose [s s0 d d'].
Implicit Arguments Identity [s].
Implicit Arguments MorphismsEquivalent [s o1 o2].

Section SaturatedCategories.
  Variable C : Category.
  Variable S : SaturatedCategory.
  Definition saturate : SaturatedCategory.
    refine {| Object := C.(Vertex);
      Morphism := path C;
      MorphismsEquivalence := C.(PathsEquivalence);
      Identity := (fun _ => NoEdges);
      Compose := (fun _ _ _ m1 m2 => concatenate m2 m1)
      |}.
    induction m; intuition; apply C.(PostCompose); intuition.
    induction m; intuition. rewrite concatenate_noedges_p. rewrite concatenate_noedges_p. intuition.
    rewrite concatenate_prepend_equivalent. rewrite concatenate_prepend_equivalent. simpl.
    rewrite <- concatenate_prepend_equivalent. rewrite <- concatenate_prepend_equivalent.
    assert (forall s (e : Edge C s _), PathsEquivalent _ (prepend m1 e) (prepend m2 e)).
    intros; intuition; simpl.
    apply (C.(PreCompose) _ _ m1 m2 H).
    apply (IHm _ _ (H0 _ _)).

    induction m3; simpl; intuition.
    simpl. apply C.(PathsEquivalence).(Reflexive).
    apply C.(PostCompose); assumption.

    intuition; simpl. apply (C.(PathsEquivalence).(Reflexive)).
    rewrite concatenate_noedges_p. apply C.(PathsEquivalence).(Reflexive).
  Defined.

  Fixpoint compose_morphism_path s d (p : path' S.(Morphism) s d) : (Morphism _ s d) :=
    match p with
      | NoEdges => Identity s
      | AddEdge _ _ p' E => Compose E (compose_morphism_path p')
    end.

  Definition unsaturate : Category.
    Hint Rewrite compose_morphism_path.
    refine {| Vertex := S.(Object);
      Edge := S.(Morphism);
      PathsEquivalent := (fun _ _ p p' => MorphismsEquivalent (compose_morphism_path p) (compose_morphism_path p'))
    |}.
    refine {| Reflexive := (fun s d (p : path' S.(Morphism) s d)  => S.(MorphismsEquivalence).(Reflexive) (compose_morphism_path p));
      Symmetric := (fun _ _ p p' => S.(MorphismsEquivalence).(Symmetric) (compose_morphism_path p) (compose_morphism_path p'));
      Transitive := (fun _ _ p1 p2 p3 => S.(MorphismsEquivalence).(Transitive) (compose_morphism_path p1) (compose_morphism_path p2) (compose_morphism_path p3))
      |}.
    assert (H0 : (forall s d d' (E : Morphism S s d) (p : path' _ d d'),
      MorphismsEquivalent (compose_morphism_path (prepend p E)) (Compose (compose_morphism_path p) E))).
    intros; simpl; intuition.
    induction p; simpl.
    assert (H : (MorphismsEquivalent (Compose E (Identity s)) E)).
    apply (IdentityAxiom _ _ _ E).
    apply (S.(MorphismsEquivalence).(Transitive) _ _ _ H).
    apply (S.(MorphismsEquivalence).(Symmetric)).
    apply (IdentityAxiom _ _ _ E).
    assert (H1 : (MorphismsEquivalent (Compose e (compose_morphism_path (prepend p E))) (Compose e (Compose (compose_morphism_path p) E)))).
    apply (S.(PreComposeMorphisms)).
    assumption.
    apply (S.(MorphismsEquivalence).(Transitive) _ _ _ H1).
    apply (S.(MorphismsEquivalence).(Symmetric)).
    apply S.(Associativity).
    intros; intuition; simpl.
    apply (S.(MorphismsEquivalence).(Transitive) _ _ _ (H0 _ _ _ _ _)).
    apply (S.(MorphismsEquivalence).(Symmetric)).
    apply (S.(MorphismsEquivalence).(Transitive) _ _ _ (H0 _ _ _ _ _)).
    apply (S.(PostComposeMorphisms)).
    apply (S.(MorphismsEquivalence).(Symmetric)).
    assumption.

    intros; intuition.
    apply (S.(PreComposeMorphisms)); intuition; simpl.
  Defined.
End SaturatedCategories.

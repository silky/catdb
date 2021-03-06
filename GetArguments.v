(* Define helper methods to get the nth argument from [f a b c ...].
   Argument 0 is [f], 1 is [a], etc. *)

Generalizable All Variables.

Set Asymmetric Patterns.

Set Universe Polymorphism.

(* Definitions generated by the python script
def mk_get_arg(n, m, indent=0, prefix='Global '):
    if not isinstance(indent, str): indent = ''.join([' '] * indent)
    rtn = indent + 'Definition get_arg_%d_of_%d ' % (n, m)
    args = ['a%d' % i for i in range(m)]
    types = []
    for i in range(m):
        types.append((('A%d ' % i) + ' '.join(args[:i])).strip())
    rtn += '`{f : forall '
    rtn += ' '.join('(%s : %s)' % arg for arg in zip(args, types))
    rtn += ', Type} {' + ' '.join(args) + '} '
    rtn += '(_ : f ' + ' '.join(args) + ') := '
    rtn += args[n - 1] if n > 0 else 'f'
    rtn += '.\n' + indent
    rtn += prefix + 'Arguments get_arg_%d_of_%d / ' % (n, m)
    rtn += ' '.join(['_'] * (len(types) + 1 + len(args) + 1))
    if n == 0:
        rtn += ' ' + ' '.join(['_'] * m) # for the type of f
    rtn += '.'
    return rtn

for m in range(1, 10):
    for n in range(m + 1):
        print(mk_get_arg(n, m, prefix=''))
*)

Definition get_arg_0_of_1 `{f : forall (a0 : A0), Type} {a0} (_ : f a0) := f.
Arguments get_arg_0_of_1 / _ _ _ _ _.
Definition get_arg_1_of_1 `{f : forall (a0 : A0), Type} {a0} (_ : f a0) := a0.
Arguments get_arg_1_of_1 / _ _ _ _.
Definition get_arg_0_of_2 `{f : forall (a0 : A0) (a1 : A1 a0), Type} {a0 a1} (_ : f a0 a1) := f.
Arguments get_arg_0_of_2 / _ _ _ _ _ _ _ _.
Definition get_arg_1_of_2 `{f : forall (a0 : A0) (a1 : A1 a0), Type} {a0 a1} (_ : f a0 a1) := a0.
Arguments get_arg_1_of_2 / _ _ _ _ _ _.
Definition get_arg_2_of_2 `{f : forall (a0 : A0) (a1 : A1 a0), Type} {a0 a1} (_ : f a0 a1) := a1.
Arguments get_arg_2_of_2 / _ _ _ _ _ _.
Definition get_arg_0_of_3 `{f : forall (a0 : A0) (a1 : A1 a0) (a2 : A2 a0 a1), Type} {a0 a1 a2} (_ : f a0 a1 a2) := f.
Arguments get_arg_0_of_3 / _ _ _ _ _ _ _ _ _ _ _.
Definition get_arg_1_of_3 `{f : forall (a0 : A0) (a1 : A1 a0) (a2 : A2 a0 a1), Type} {a0 a1 a2} (_ : f a0 a1 a2) := a0.
Arguments get_arg_1_of_3 / _ _ _ _ _ _ _ _.
Definition get_arg_2_of_3 `{f : forall (a0 : A0) (a1 : A1 a0) (a2 : A2 a0 a1), Type} {a0 a1 a2} (_ : f a0 a1 a2) := a1.
Arguments get_arg_2_of_3 / _ _ _ _ _ _ _ _.
Definition get_arg_3_of_3 `{f : forall (a0 : A0) (a1 : A1 a0) (a2 : A2 a0 a1), Type} {a0 a1 a2} (_ : f a0 a1 a2) := a2.
Arguments get_arg_3_of_3 / _ _ _ _ _ _ _ _.
Definition get_arg_0_of_4 `{f : forall (a0 : A0) (a1 : A1 a0) (a2 : A2 a0 a1) (a3 : A3 a0 a1 a2), Type} {a0 a1 a2 a3} (_ : f a0 a1 a2 a3) := f.
Arguments get_arg_0_of_4 / _ _ _ _ _ _ _ _ _ _ _ _ _ _.
Definition get_arg_1_of_4 `{f : forall (a0 : A0) (a1 : A1 a0) (a2 : A2 a0 a1) (a3 : A3 a0 a1 a2), Type} {a0 a1 a2 a3} (_ : f a0 a1 a2 a3) := a0.
Arguments get_arg_1_of_4 / _ _ _ _ _ _ _ _ _ _.
Definition get_arg_2_of_4 `{f : forall (a0 : A0) (a1 : A1 a0) (a2 : A2 a0 a1) (a3 : A3 a0 a1 a2), Type} {a0 a1 a2 a3} (_ : f a0 a1 a2 a3) := a1.
Arguments get_arg_2_of_4 / _ _ _ _ _ _ _ _ _ _.
Definition get_arg_3_of_4 `{f : forall (a0 : A0) (a1 : A1 a0) (a2 : A2 a0 a1) (a3 : A3 a0 a1 a2), Type} {a0 a1 a2 a3} (_ : f a0 a1 a2 a3) := a2.
Arguments get_arg_3_of_4 / _ _ _ _ _ _ _ _ _ _.
Definition get_arg_4_of_4 `{f : forall (a0 : A0) (a1 : A1 a0) (a2 : A2 a0 a1) (a3 : A3 a0 a1 a2), Type} {a0 a1 a2 a3} (_ : f a0 a1 a2 a3) := a3.
Arguments get_arg_4_of_4 / _ _ _ _ _ _ _ _ _ _.
Definition get_arg_0_of_5 `{f : forall (a0 : A0) (a1 : A1 a0) (a2 : A2 a0 a1) (a3 : A3 a0 a1 a2) (a4 : A4 a0 a1 a2 a3), Type} {a0 a1 a2 a3 a4} (_ : f a0 a1 a2 a3 a4) := f.
Arguments get_arg_0_of_5 / _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _.
Definition get_arg_1_of_5 `{f : forall (a0 : A0) (a1 : A1 a0) (a2 : A2 a0 a1) (a3 : A3 a0 a1 a2) (a4 : A4 a0 a1 a2 a3), Type} {a0 a1 a2 a3 a4} (_ : f a0 a1 a2 a3 a4) := a0.
Arguments get_arg_1_of_5 / _ _ _ _ _ _ _ _ _ _ _ _.
Definition get_arg_2_of_5 `{f : forall (a0 : A0) (a1 : A1 a0) (a2 : A2 a0 a1) (a3 : A3 a0 a1 a2) (a4 : A4 a0 a1 a2 a3), Type} {a0 a1 a2 a3 a4} (_ : f a0 a1 a2 a3 a4) := a1.
Arguments get_arg_2_of_5 / _ _ _ _ _ _ _ _ _ _ _ _.
Definition get_arg_3_of_5 `{f : forall (a0 : A0) (a1 : A1 a0) (a2 : A2 a0 a1) (a3 : A3 a0 a1 a2) (a4 : A4 a0 a1 a2 a3), Type} {a0 a1 a2 a3 a4} (_ : f a0 a1 a2 a3 a4) := a2.
Arguments get_arg_3_of_5 / _ _ _ _ _ _ _ _ _ _ _ _.
Definition get_arg_4_of_5 `{f : forall (a0 : A0) (a1 : A1 a0) (a2 : A2 a0 a1) (a3 : A3 a0 a1 a2) (a4 : A4 a0 a1 a2 a3), Type} {a0 a1 a2 a3 a4} (_ : f a0 a1 a2 a3 a4) := a3.
Arguments get_arg_4_of_5 / _ _ _ _ _ _ _ _ _ _ _ _.
Definition get_arg_5_of_5 `{f : forall (a0 : A0) (a1 : A1 a0) (a2 : A2 a0 a1) (a3 : A3 a0 a1 a2) (a4 : A4 a0 a1 a2 a3), Type} {a0 a1 a2 a3 a4} (_ : f a0 a1 a2 a3 a4) := a4.
Arguments get_arg_5_of_5 / _ _ _ _ _ _ _ _ _ _ _ _.
Definition get_arg_0_of_6 `{f : forall (a0 : A0) (a1 : A1 a0) (a2 : A2 a0 a1) (a3 : A3 a0 a1 a2) (a4 : A4 a0 a1 a2 a3) (a5 : A5 a0 a1 a2 a3 a4), Type} {a0 a1 a2 a3 a4 a5} (_ : f a0 a1 a2 a3 a4 a5) := f.
Arguments get_arg_0_of_6 / _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _.
Definition get_arg_1_of_6 `{f : forall (a0 : A0) (a1 : A1 a0) (a2 : A2 a0 a1) (a3 : A3 a0 a1 a2) (a4 : A4 a0 a1 a2 a3) (a5 : A5 a0 a1 a2 a3 a4), Type} {a0 a1 a2 a3 a4 a5} (_ : f a0 a1 a2 a3 a4 a5) := a0.
Arguments get_arg_1_of_6 / _ _ _ _ _ _ _ _ _ _ _ _ _ _.
Definition get_arg_2_of_6 `{f : forall (a0 : A0) (a1 : A1 a0) (a2 : A2 a0 a1) (a3 : A3 a0 a1 a2) (a4 : A4 a0 a1 a2 a3) (a5 : A5 a0 a1 a2 a3 a4), Type} {a0 a1 a2 a3 a4 a5} (_ : f a0 a1 a2 a3 a4 a5) := a1.
Arguments get_arg_2_of_6 / _ _ _ _ _ _ _ _ _ _ _ _ _ _.
Definition get_arg_3_of_6 `{f : forall (a0 : A0) (a1 : A1 a0) (a2 : A2 a0 a1) (a3 : A3 a0 a1 a2) (a4 : A4 a0 a1 a2 a3) (a5 : A5 a0 a1 a2 a3 a4), Type} {a0 a1 a2 a3 a4 a5} (_ : f a0 a1 a2 a3 a4 a5) := a2.
Arguments get_arg_3_of_6 / _ _ _ _ _ _ _ _ _ _ _ _ _ _.
Definition get_arg_4_of_6 `{f : forall (a0 : A0) (a1 : A1 a0) (a2 : A2 a0 a1) (a3 : A3 a0 a1 a2) (a4 : A4 a0 a1 a2 a3) (a5 : A5 a0 a1 a2 a3 a4), Type} {a0 a1 a2 a3 a4 a5} (_ : f a0 a1 a2 a3 a4 a5) := a3.
Arguments get_arg_4_of_6 / _ _ _ _ _ _ _ _ _ _ _ _ _ _.
Definition get_arg_5_of_6 `{f : forall (a0 : A0) (a1 : A1 a0) (a2 : A2 a0 a1) (a3 : A3 a0 a1 a2) (a4 : A4 a0 a1 a2 a3) (a5 : A5 a0 a1 a2 a3 a4), Type} {a0 a1 a2 a3 a4 a5} (_ : f a0 a1 a2 a3 a4 a5) := a4.
Arguments get_arg_5_of_6 / _ _ _ _ _ _ _ _ _ _ _ _ _ _.
Definition get_arg_6_of_6 `{f : forall (a0 : A0) (a1 : A1 a0) (a2 : A2 a0 a1) (a3 : A3 a0 a1 a2) (a4 : A4 a0 a1 a2 a3) (a5 : A5 a0 a1 a2 a3 a4), Type} {a0 a1 a2 a3 a4 a5} (_ : f a0 a1 a2 a3 a4 a5) := a5.
Arguments get_arg_6_of_6 / _ _ _ _ _ _ _ _ _ _ _ _ _ _.
Definition get_arg_0_of_7 `{f : forall (a0 : A0) (a1 : A1 a0) (a2 : A2 a0 a1) (a3 : A3 a0 a1 a2) (a4 : A4 a0 a1 a2 a3) (a5 : A5 a0 a1 a2 a3 a4) (a6 : A6 a0 a1 a2 a3 a4 a5), Type} {a0 a1 a2 a3 a4 a5 a6} (_ : f a0 a1 a2 a3 a4 a5 a6) := f.
Arguments get_arg_0_of_7 / _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _.
Definition get_arg_1_of_7 `{f : forall (a0 : A0) (a1 : A1 a0) (a2 : A2 a0 a1) (a3 : A3 a0 a1 a2) (a4 : A4 a0 a1 a2 a3) (a5 : A5 a0 a1 a2 a3 a4) (a6 : A6 a0 a1 a2 a3 a4 a5), Type} {a0 a1 a2 a3 a4 a5 a6} (_ : f a0 a1 a2 a3 a4 a5 a6) := a0.
Arguments get_arg_1_of_7 / _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _.
Definition get_arg_2_of_7 `{f : forall (a0 : A0) (a1 : A1 a0) (a2 : A2 a0 a1) (a3 : A3 a0 a1 a2) (a4 : A4 a0 a1 a2 a3) (a5 : A5 a0 a1 a2 a3 a4) (a6 : A6 a0 a1 a2 a3 a4 a5), Type} {a0 a1 a2 a3 a4 a5 a6} (_ : f a0 a1 a2 a3 a4 a5 a6) := a1.
Arguments get_arg_2_of_7 / _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _.
Definition get_arg_3_of_7 `{f : forall (a0 : A0) (a1 : A1 a0) (a2 : A2 a0 a1) (a3 : A3 a0 a1 a2) (a4 : A4 a0 a1 a2 a3) (a5 : A5 a0 a1 a2 a3 a4) (a6 : A6 a0 a1 a2 a3 a4 a5), Type} {a0 a1 a2 a3 a4 a5 a6} (_ : f a0 a1 a2 a3 a4 a5 a6) := a2.
Arguments get_arg_3_of_7 / _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _.
Definition get_arg_4_of_7 `{f : forall (a0 : A0) (a1 : A1 a0) (a2 : A2 a0 a1) (a3 : A3 a0 a1 a2) (a4 : A4 a0 a1 a2 a3) (a5 : A5 a0 a1 a2 a3 a4) (a6 : A6 a0 a1 a2 a3 a4 a5), Type} {a0 a1 a2 a3 a4 a5 a6} (_ : f a0 a1 a2 a3 a4 a5 a6) := a3.
Arguments get_arg_4_of_7 / _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _.
Definition get_arg_5_of_7 `{f : forall (a0 : A0) (a1 : A1 a0) (a2 : A2 a0 a1) (a3 : A3 a0 a1 a2) (a4 : A4 a0 a1 a2 a3) (a5 : A5 a0 a1 a2 a3 a4) (a6 : A6 a0 a1 a2 a3 a4 a5), Type} {a0 a1 a2 a3 a4 a5 a6} (_ : f a0 a1 a2 a3 a4 a5 a6) := a4.
Arguments get_arg_5_of_7 / _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _.
Definition get_arg_6_of_7 `{f : forall (a0 : A0) (a1 : A1 a0) (a2 : A2 a0 a1) (a3 : A3 a0 a1 a2) (a4 : A4 a0 a1 a2 a3) (a5 : A5 a0 a1 a2 a3 a4) (a6 : A6 a0 a1 a2 a3 a4 a5), Type} {a0 a1 a2 a3 a4 a5 a6} (_ : f a0 a1 a2 a3 a4 a5 a6) := a5.
Arguments get_arg_6_of_7 / _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _.
Definition get_arg_7_of_7 `{f : forall (a0 : A0) (a1 : A1 a0) (a2 : A2 a0 a1) (a3 : A3 a0 a1 a2) (a4 : A4 a0 a1 a2 a3) (a5 : A5 a0 a1 a2 a3 a4) (a6 : A6 a0 a1 a2 a3 a4 a5), Type} {a0 a1 a2 a3 a4 a5 a6} (_ : f a0 a1 a2 a3 a4 a5 a6) := a6.
Arguments get_arg_7_of_7 / _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _.
Definition get_arg_0_of_8 `{f : forall (a0 : A0) (a1 : A1 a0) (a2 : A2 a0 a1) (a3 : A3 a0 a1 a2) (a4 : A4 a0 a1 a2 a3) (a5 : A5 a0 a1 a2 a3 a4) (a6 : A6 a0 a1 a2 a3 a4 a5) (a7 : A7 a0 a1 a2 a3 a4 a5 a6), Type} {a0 a1 a2 a3 a4 a5 a6 a7} (_ : f a0 a1 a2 a3 a4 a5 a6 a7) := f.
Arguments get_arg_0_of_8 / _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _.
Definition get_arg_1_of_8 `{f : forall (a0 : A0) (a1 : A1 a0) (a2 : A2 a0 a1) (a3 : A3 a0 a1 a2) (a4 : A4 a0 a1 a2 a3) (a5 : A5 a0 a1 a2 a3 a4) (a6 : A6 a0 a1 a2 a3 a4 a5) (a7 : A7 a0 a1 a2 a3 a4 a5 a6), Type} {a0 a1 a2 a3 a4 a5 a6 a7} (_ : f a0 a1 a2 a3 a4 a5 a6 a7) := a0.
Arguments get_arg_1_of_8 / _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _.
Definition get_arg_2_of_8 `{f : forall (a0 : A0) (a1 : A1 a0) (a2 : A2 a0 a1) (a3 : A3 a0 a1 a2) (a4 : A4 a0 a1 a2 a3) (a5 : A5 a0 a1 a2 a3 a4) (a6 : A6 a0 a1 a2 a3 a4 a5) (a7 : A7 a0 a1 a2 a3 a4 a5 a6), Type} {a0 a1 a2 a3 a4 a5 a6 a7} (_ : f a0 a1 a2 a3 a4 a5 a6 a7) := a1.
Arguments get_arg_2_of_8 / _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _.
Definition get_arg_3_of_8 `{f : forall (a0 : A0) (a1 : A1 a0) (a2 : A2 a0 a1) (a3 : A3 a0 a1 a2) (a4 : A4 a0 a1 a2 a3) (a5 : A5 a0 a1 a2 a3 a4) (a6 : A6 a0 a1 a2 a3 a4 a5) (a7 : A7 a0 a1 a2 a3 a4 a5 a6), Type} {a0 a1 a2 a3 a4 a5 a6 a7} (_ : f a0 a1 a2 a3 a4 a5 a6 a7) := a2.
Arguments get_arg_3_of_8 / _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _.
Definition get_arg_4_of_8 `{f : forall (a0 : A0) (a1 : A1 a0) (a2 : A2 a0 a1) (a3 : A3 a0 a1 a2) (a4 : A4 a0 a1 a2 a3) (a5 : A5 a0 a1 a2 a3 a4) (a6 : A6 a0 a1 a2 a3 a4 a5) (a7 : A7 a0 a1 a2 a3 a4 a5 a6), Type} {a0 a1 a2 a3 a4 a5 a6 a7} (_ : f a0 a1 a2 a3 a4 a5 a6 a7) := a3.
Arguments get_arg_4_of_8 / _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _.
Definition get_arg_5_of_8 `{f : forall (a0 : A0) (a1 : A1 a0) (a2 : A2 a0 a1) (a3 : A3 a0 a1 a2) (a4 : A4 a0 a1 a2 a3) (a5 : A5 a0 a1 a2 a3 a4) (a6 : A6 a0 a1 a2 a3 a4 a5) (a7 : A7 a0 a1 a2 a3 a4 a5 a6), Type} {a0 a1 a2 a3 a4 a5 a6 a7} (_ : f a0 a1 a2 a3 a4 a5 a6 a7) := a4.
Arguments get_arg_5_of_8 / _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _.
Definition get_arg_6_of_8 `{f : forall (a0 : A0) (a1 : A1 a0) (a2 : A2 a0 a1) (a3 : A3 a0 a1 a2) (a4 : A4 a0 a1 a2 a3) (a5 : A5 a0 a1 a2 a3 a4) (a6 : A6 a0 a1 a2 a3 a4 a5) (a7 : A7 a0 a1 a2 a3 a4 a5 a6), Type} {a0 a1 a2 a3 a4 a5 a6 a7} (_ : f a0 a1 a2 a3 a4 a5 a6 a7) := a5.
Arguments get_arg_6_of_8 / _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _.
Definition get_arg_7_of_8 `{f : forall (a0 : A0) (a1 : A1 a0) (a2 : A2 a0 a1) (a3 : A3 a0 a1 a2) (a4 : A4 a0 a1 a2 a3) (a5 : A5 a0 a1 a2 a3 a4) (a6 : A6 a0 a1 a2 a3 a4 a5) (a7 : A7 a0 a1 a2 a3 a4 a5 a6), Type} {a0 a1 a2 a3 a4 a5 a6 a7} (_ : f a0 a1 a2 a3 a4 a5 a6 a7) := a6.
Arguments get_arg_7_of_8 / _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _.
Definition get_arg_8_of_8 `{f : forall (a0 : A0) (a1 : A1 a0) (a2 : A2 a0 a1) (a3 : A3 a0 a1 a2) (a4 : A4 a0 a1 a2 a3) (a5 : A5 a0 a1 a2 a3 a4) (a6 : A6 a0 a1 a2 a3 a4 a5) (a7 : A7 a0 a1 a2 a3 a4 a5 a6), Type} {a0 a1 a2 a3 a4 a5 a6 a7} (_ : f a0 a1 a2 a3 a4 a5 a6 a7) := a7.
Arguments get_arg_8_of_8 / _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _.
Definition get_arg_0_of_9 `{f : forall (a0 : A0) (a1 : A1 a0) (a2 : A2 a0 a1) (a3 : A3 a0 a1 a2) (a4 : A4 a0 a1 a2 a3) (a5 : A5 a0 a1 a2 a3 a4) (a6 : A6 a0 a1 a2 a3 a4 a5) (a7 : A7 a0 a1 a2 a3 a4 a5 a6) (a8 : A8 a0 a1 a2 a3 a4 a5 a6 a7), Type} {a0 a1 a2 a3 a4 a5 a6 a7 a8} (_ : f a0 a1 a2 a3 a4 a5 a6 a7 a8) := f.
Arguments get_arg_0_of_9 / _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _.
Definition get_arg_1_of_9 `{f : forall (a0 : A0) (a1 : A1 a0) (a2 : A2 a0 a1) (a3 : A3 a0 a1 a2) (a4 : A4 a0 a1 a2 a3) (a5 : A5 a0 a1 a2 a3 a4) (a6 : A6 a0 a1 a2 a3 a4 a5) (a7 : A7 a0 a1 a2 a3 a4 a5 a6) (a8 : A8 a0 a1 a2 a3 a4 a5 a6 a7), Type} {a0 a1 a2 a3 a4 a5 a6 a7 a8} (_ : f a0 a1 a2 a3 a4 a5 a6 a7 a8) := a0.
Arguments get_arg_1_of_9 / _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _.
Definition get_arg_2_of_9 `{f : forall (a0 : A0) (a1 : A1 a0) (a2 : A2 a0 a1) (a3 : A3 a0 a1 a2) (a4 : A4 a0 a1 a2 a3) (a5 : A5 a0 a1 a2 a3 a4) (a6 : A6 a0 a1 a2 a3 a4 a5) (a7 : A7 a0 a1 a2 a3 a4 a5 a6) (a8 : A8 a0 a1 a2 a3 a4 a5 a6 a7), Type} {a0 a1 a2 a3 a4 a5 a6 a7 a8} (_ : f a0 a1 a2 a3 a4 a5 a6 a7 a8) := a1.
Arguments get_arg_2_of_9 / _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _.
Definition get_arg_3_of_9 `{f : forall (a0 : A0) (a1 : A1 a0) (a2 : A2 a0 a1) (a3 : A3 a0 a1 a2) (a4 : A4 a0 a1 a2 a3) (a5 : A5 a0 a1 a2 a3 a4) (a6 : A6 a0 a1 a2 a3 a4 a5) (a7 : A7 a0 a1 a2 a3 a4 a5 a6) (a8 : A8 a0 a1 a2 a3 a4 a5 a6 a7), Type} {a0 a1 a2 a3 a4 a5 a6 a7 a8} (_ : f a0 a1 a2 a3 a4 a5 a6 a7 a8) := a2.
Arguments get_arg_3_of_9 / _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _.
Definition get_arg_4_of_9 `{f : forall (a0 : A0) (a1 : A1 a0) (a2 : A2 a0 a1) (a3 : A3 a0 a1 a2) (a4 : A4 a0 a1 a2 a3) (a5 : A5 a0 a1 a2 a3 a4) (a6 : A6 a0 a1 a2 a3 a4 a5) (a7 : A7 a0 a1 a2 a3 a4 a5 a6) (a8 : A8 a0 a1 a2 a3 a4 a5 a6 a7), Type} {a0 a1 a2 a3 a4 a5 a6 a7 a8} (_ : f a0 a1 a2 a3 a4 a5 a6 a7 a8) := a3.
Arguments get_arg_4_of_9 / _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _.
Definition get_arg_5_of_9 `{f : forall (a0 : A0) (a1 : A1 a0) (a2 : A2 a0 a1) (a3 : A3 a0 a1 a2) (a4 : A4 a0 a1 a2 a3) (a5 : A5 a0 a1 a2 a3 a4) (a6 : A6 a0 a1 a2 a3 a4 a5) (a7 : A7 a0 a1 a2 a3 a4 a5 a6) (a8 : A8 a0 a1 a2 a3 a4 a5 a6 a7), Type} {a0 a1 a2 a3 a4 a5 a6 a7 a8} (_ : f a0 a1 a2 a3 a4 a5 a6 a7 a8) := a4.
Arguments get_arg_5_of_9 / _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _.
Definition get_arg_6_of_9 `{f : forall (a0 : A0) (a1 : A1 a0) (a2 : A2 a0 a1) (a3 : A3 a0 a1 a2) (a4 : A4 a0 a1 a2 a3) (a5 : A5 a0 a1 a2 a3 a4) (a6 : A6 a0 a1 a2 a3 a4 a5) (a7 : A7 a0 a1 a2 a3 a4 a5 a6) (a8 : A8 a0 a1 a2 a3 a4 a5 a6 a7), Type} {a0 a1 a2 a3 a4 a5 a6 a7 a8} (_ : f a0 a1 a2 a3 a4 a5 a6 a7 a8) := a5.
Arguments get_arg_6_of_9 / _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _.
Definition get_arg_7_of_9 `{f : forall (a0 : A0) (a1 : A1 a0) (a2 : A2 a0 a1) (a3 : A3 a0 a1 a2) (a4 : A4 a0 a1 a2 a3) (a5 : A5 a0 a1 a2 a3 a4) (a6 : A6 a0 a1 a2 a3 a4 a5) (a7 : A7 a0 a1 a2 a3 a4 a5 a6) (a8 : A8 a0 a1 a2 a3 a4 a5 a6 a7), Type} {a0 a1 a2 a3 a4 a5 a6 a7 a8} (_ : f a0 a1 a2 a3 a4 a5 a6 a7 a8) := a6.
Arguments get_arg_7_of_9 / _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _.
Definition get_arg_8_of_9 `{f : forall (a0 : A0) (a1 : A1 a0) (a2 : A2 a0 a1) (a3 : A3 a0 a1 a2) (a4 : A4 a0 a1 a2 a3) (a5 : A5 a0 a1 a2 a3 a4) (a6 : A6 a0 a1 a2 a3 a4 a5) (a7 : A7 a0 a1 a2 a3 a4 a5 a6) (a8 : A8 a0 a1 a2 a3 a4 a5 a6 a7), Type} {a0 a1 a2 a3 a4 a5 a6 a7 a8} (_ : f a0 a1 a2 a3 a4 a5 a6 a7 a8) := a7.
Arguments get_arg_8_of_9 / _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _.
Definition get_arg_9_of_9 `{f : forall (a0 : A0) (a1 : A1 a0) (a2 : A2 a0 a1) (a3 : A3 a0 a1 a2) (a4 : A4 a0 a1 a2 a3) (a5 : A5 a0 a1 a2 a3 a4) (a6 : A6 a0 a1 a2 a3 a4 a5) (a7 : A7 a0 a1 a2 a3 a4 a5 a6) (a8 : A8 a0 a1 a2 a3 a4 a5 a6 a7), Type} {a0 a1 a2 a3 a4 a5 a6 a7 a8} (_ : f a0 a1 a2 a3 a4 a5 a6 a7 a8) := a8.
Arguments get_arg_9_of_9 / _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _.

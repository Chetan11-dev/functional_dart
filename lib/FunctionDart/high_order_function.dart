/// gives a no args function which return the argument given to giver
/// For eg.
/// var f = giver(Theme.of(context))
/// now f() gives us Theme.of(context)
/// Now no need to call Theme.of(context)  again and again
/// another simar function is [singleInvocation] which stores a every time copmutes function which is generally less effecient
A Function() giver<A>(A a) => () => a;

/// gives a no args function which return the argument given to singleInvocation
/// For eg.
/// var f = singleInvocation(context, (BuildContext context) => Theme.of(context));
/// now f() gives us ThemeData result of our computation
/// another simar function is [giver] which stores a computed result ang gives it back which is generally more effecient
/// Now no need to call Theme.of(context)  again and again
B Function() singleInvocation<A, B>(A a, B Function(A) f) => () => f(a);

///the result of first function becomes argument of second function
C Function(A) firstAndThen<A, B, C>(B Function(A) f, C Function(B) s) =>
    (A v) => s(f(v));

/// Applies given functions in sequence
/// you just need to call resultant function to get all functions computed
Function() sequence(List<Function()> fs) => () => fs.forEach((f) => f());

/// Applies Two argument function in one by one manner
C Function(B) partial1<A, B, C>(A a, C Function(A, B) f) => (B b) => f(a, b);

/// converts two argument function to single argument function
C Function(B) Function(A) curry<A, B, C>(C Function(A, B) f) =>
    (A a) => ((B b) => f(a, b));

/// reverse of [curry]
C Function(A, B) unCurry<A, B, C>(C Function(B) Function(A) f) =>
    (A a, B b) => f(a)(b);

**Shortcutting and lazy hints**
===============================

Let us have this expression:

*let \$f := function(\$arg1 as item()\*, \$arg2 as item()\*) as
function(item()\*) as item()\**

*return*

*\$f(\$x) (\$y)*

Evaluating \$f(\$x) produces a function. The **actual arity** of this resulting
function can be any number N \>= 0 :

-   If N \> 1 there would be arity mismatch error, as only one argument \$y is
    provided in the expression.

-   If N \<= 1 the final function call can be evaluated, and depending on the
    value of N, the argument \$y must be evaluated (N eq 1), or (if N eq 0)
    according to the updated “[Coercion Rules / Function
    Coercion](https://qt4cg.org/pr/279/xquery-40/xpath-40.html#id-coercion-rules)”
    in Xpath 4.0 this unneeded argument (\$y) can safely be ignored .  
    Because a possibility exists to be able to ignore the evaluation of \$y, it
    is logical to delay the evaluation of \$y until the actual arity
    of \$f(\$x) is known.

The current evaluation rules do not require such delay in deciding whether or
not to evaluate \$y.

This is where a *lazy* hint comes: it indicates to the XPath processor that it
is logical to make the decision about evaluation of \$y based on the arity of
the function returned by \$f(\$x).

Rewriting the above expression using a *lazy* hint:  
  
*let \$f := function(\$arg1 as item()\*, \$arg2 as item()\*) as
function(item()\*) as item()\**

*return*

*\$f(\$x) (lazy* *\$y)*

Here is one example of a function with short-cutting and its possible call:  
  
*let \$fAnd := function(\$x as xs:boolean, \$y as xs:boolean) as xs:boolean*

*{*

*let \$partial := function(\$x as xs:boolean) as function(xs:boolean) as
xs:boolean*

*{*

*if(not(\$x)) then -\>(){false()}*

*else -\>(\$t) {\$t}*

*}*

*return \$partial(\$x)(\$y)*

*}*

*return*

*\$fAnd(\$x (: with value false() :), lazy* *\$SomeVerySlowComputedExpression)*

The current evaluation rules do not explicitly say that when *\$fAnd(\$x, ?)* is
a 0-argument function then the argument *\$y* in *\$fAnd(\$x, \$y)* should not
be evaluated. Thus, without the *lazy* hint in the above example, it is
perfectly possible that an XPath implementation would evaluate
*\$SomeVerySlowComputedExpression* and do something that is unneeded and could
be avoided completely.

**The arity of a function is a guard for the evaluation of the arguments when calling it**
==========================================================================================

>   Let us have the function *\$f* defined as below:

>   *let \$f := function(item()\* \$arg1, item()\* \$arg2, …, item()\* argN)*

>   *as function(item()\* \$X1, item()\* \$X2, …, item()\* \$Xk,) as item()\**

>   *{*

>   *if(\$cond1(\$arg1)) then -\> () { 123 }*

>   *else if(\$cond2(\$arg1)) then -\> (item()\* \$Z1) {\$Z1}*

>   *else if(\$condK(\$arg1)) then -\> (item()\* \$Z1, item()\* \$Z2, …,
>   item()\* \$Zk)*

>   *{\$Z1 + \$Z2 + … + \$Zk}*

>   *else ()*

>   *}*

>   *return*

>   *\$f(\$y1, \$y2, …, \$yN) (\$z1, \$z2, …, \$zk)*

Thus, a function call to *\$f* returns a function whose arity may be 0, 1, …, K.  
  
Depending on the arity of the returned function (0, 1, …, K), the last (K, K-1,
K-2, …, 2, 1, 0) arguments of the function call:  
  
*\$f(\$y1, \$y2, …, \$yN) (\$z1, \$z2, …, \$zk)*

are unneeded and it is logical not to be evaluated.

-   Clearly, the arity of the result (returned function) of calling *\$f* is a
    guard for the arguments of a call to this function result.  
      
    Thus, we should add one more bullet (an established guard-type) to [2.4.5
    Guarded
    Expressions](https://qt4cg.org/specifications/xquery-40/xpath-40.html#id-guarded-expressions)*:*  
      
    *“*In an expression of the type *E(A1, A2, ..., AN)* any of the right-hand
    operands (arguments) AK is guarded by the condition *function-arity(E) ge
    K* being *true()*  
    This rule has the consequence that if the arity of *E()* is less
    than *K* then if any argument *Am* is evaluated, this must not raise a
    dynamic error unless *function-arity(E) ge K* is *true()* , and of course,
    there should be such an error to be raised. An implementation may delay the
    evaluation of the arguments until the actual arity of *E()* is dynamically
    known.*”*

% module for evaluating arithmetic expressions
% epressions are structured as trees construced from tuples
% int(N) = an integer, add(X Y) - addition, mul(X Y) - multiplication

declare
fun {Eval Expr}
   case Expr of
      nil then nil
   [] int(N) then N                       % int(N) evaluated to N
   [] mul(X Y) then {Eval X} * {Eval Y}   % mul(X Y) returns the product of evaluation of X and Y
   [] add(X Y) then {Eval X} + {Eval Y}   % add(X Y) returns the sum of evaluation of X and Y
   end
end

{Browse {Eval add(int(1) mul(int(3) int(4)))}}
{Browse {Eval add(int(1) int(2))}}
{Browse {Eval mul(int(2) add(int(1) int(1)))}}

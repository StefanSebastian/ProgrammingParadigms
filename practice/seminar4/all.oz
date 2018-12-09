% free variables
declare
fun {FreeSet Expr}
   {FreeSetAux Expr nil}
end

% checks if list L contains element El
fun {Contains L El}
   case L of
      nil then false
   [] H|T then if H==El then true else {Contains T El} end
   end
end

fun {FreeSetAux Expr Context}
   case Expr of
      nil then nil
   [] lam(Id LExpr) then {FreeSetAux LExpr Id|Context}
   [] let(Id#Expr1 Expr2) then {Append {FreeSetAux Expr1 Context} {FreeSetAux Expr2 Id|Context}}
   [] apply(Expr1 Expr2) then {Append {FreeSetAux Expr1 Context} {FreeSetAux Expr2 Context}} 
   [] Id then if {Bool.'not' {Contains Context Id}} then [Id] else nil end
   end
end

{Browse 'Free variables'}
{Browse {FreeSet apply(x let(x#y x))}}            % should be [x y]
{Browse {FreeSet apply(y apply(let(x#x x) y))}}   % should be [y y]

% environment mapping functions

% checks if a given identifier is present in the current environment
declare
fun {IsMember Env Id}
   case Env of
      nil then false
   [] PId#PExpr|T then if PId == Id then true else {IsMember T Id} end
   end
end

% returns the expression of the present identifier from the environment
fun {Fetch Env Id}
   case Env of
      nil then Id
   [] PId#PExpr|T then if PId == Id then PExpr else {Fetch T Id} end
   end
end

% adds a new pair into the environment that overrides a previous mapping if exits
fun {Adjoin Env Id#Expr}
   Id#Expr|{RemoveId Env Id}
end

% removes a pair from the environment
fun {RemoveId Env Id}
   case Env of
      nil then nil
   [] PId#PExpr|T then if PId == Id then
			{RemoveId T Id}
		     else
			PId#PExpr|{RemoveId T Id}
		     end
   end
end

{Browse 'Environment/Mapping'}
local E1='E1' E3='E3' E4='E4' in
   {Browse {IsMember [a#E1 b#y c#E3] c}} % true
   {Browse {IsMember [a#E1 b#y c#E3] y}} % false
   {Browse {Fetch [a#E1 b#y c#E3] c}} % returns E3
   {Browse {Fetch [a#E1 b#y c#E3] d}} % returns d
   {Browse {Adjoin [a#E1 b#y c#E3] c#E4}}
   {Browse {Adjoin [a#E1 b#y c#E3] d#E4}}
end

% new id generator
declare
Cnt={NewCell 0}
fun {NewId}
   Cnt := @Cnt + 1
   {String.toAtom {Append "id<" {Append {Int.toString @Cnt} ">"}}}
end

% renaming of bound variables
fun {Rename Expr}
   {RenameAux Expr nil nil}
end

% RenameAux auxiliary function for rename functionality
% Context ; all variables which are currently bound
% Mapping ; mapping between old ids and new ids
fun {RenameAux Expr Context Mapping}
   case Expr of
      nil then nil
   [] lam(Id LExpr) then local GenId={NewId} NewMapping={Adjoin Mapping Id#GenId}            % On lambda structures : generate new id and add to mapping
			 in lam(GenId {RenameAux LExpr Id|Context NewMapping}) end           % change the old id, and rename the expression in the fc body
                                                                                             % the old id is added to bound variables list
   [] let(Id#Expr1 Expr2) then local GenId={NewId} NewMapping={Adjoin Mapping Id#GenId}                                     % let structure ; gen new id and mapping
			       in let(GenId#{RenameAux Expr1 Context Mapping} {RenameAux Expr2 Id|Context NewMapping}) end  % change old id, rename expression
                                                                                                                            % in body with the added id as context
   [] apply(Expr1 Expr2) then apply({RenameAux Expr1 Context Mapping} {RenameAux Expr2 Context Mapping}) % in case of apply, do rename on both members
   [] Id then if {And {Contains Context Id} {IsMember Mapping Id}} then % if we find an identifier, if the identifier is part of bound vars and has a mapping
		 {Fetch Mapping Id}                                     % identifier becomes the value from the mapping
	      else Id end                                               % otherwise, unchanged
   end   
end

{Browse 'Renaming'}
{Browse {Rename lam(z lam(x z))}} % lam(id<1> lam(id<2> id<1>)
{Browse {Rename let(id#lam(z z) apply(id y))}} % let(id<3>#lam(id<4> id<4>) apply(id<3> y))

% substitution for lambda terms
% Subs :: {<Id>#<Expr> <Expr>} -> <Expr>
fun {Subs Id#Expr1 Expr2}
   {ReplaceId Id Expr1 Expr2} 
end

% auxiliary function ; replaces Old, which is an id; with New which is an Expresion in Expr, also an Expression
fun {ReplaceId Old New Expr}
   case Expr of
      nil then nil
   [] lam(Id LExpr) then
      if Id \= Old    % if Id of subexpression is not the same as the one to be replaced, means Old is not bound in subexpression
      then if {Contains {FreeSet New} Id} % checks if the set of free variables of the nex expression contains the id of the considered expression, if needs rename
	   then local lam(NId NExpr) = {Rename lam(Id LExpr)} in lam(NId {ReplaceId Old New NExpr}) end % positive case, rename the id of the considered expr
	   else lam(Id {ReplaceId Old New LExpr}) end % don't need to rename id, apply replaceId function on the subexpression
      else lam(Id LExpr) end % If Id of lam subexpression is equal to the Id which is to be replaced, we can ignore this; because 'Old' is bound inside the expr
   [] let(Id#Expr1 Expr2) then
      if Id \= Old  % if Id is the same as the one to be replaced, Old is not bound
      then if {Contains {FreeSet New} Id} % check if needs to rename id
	   then local let(NId#NExpr1 NExpr2) = {Rename let(Id#Expr1 Expr2)} in let(NId#{ReplaceId Old New NExpr1} {ReplaceId Old New NExpr2}) end
	   else let(Id#{ReplaceId Old New Expr1} {ReplaceId Old New Expr2}) end % case of no rename, apply replace to Expr1 and Expr2
      else let(Id#{ReplaceId Old New Expr1} Expr2) end % Old was bound, replace is only applied to Expr1
   [] apply(Expr1 Expr2) then apply({ReplaceId Old New Expr1} {ReplaceId Old New Expr2})
   [] Id then if Id == Old then New else Id end
   end
end

{Browse 'Substitution'}
{Browse {Subs x#lam(x x) apply(x y)}} % simple example ; should be apply(lam(x x) y)
{Browse {Subs x#lam(z z) apply(x lam(x apply(x z)))}} % should only substitute free occurences ; should be apply(lam(z z) lam(x apply(x z)))
{Browse {Subs x#lam(y z) apply(x lam(z apply(x z)))}} % clash between free vars with bound vars; should be apply(lam(y z) lam(id<1> apply(lam(y z) id<1>)))
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

fun {RenameAux Expr Context Mapping}
   case Expr of
      nil then nil
   [] lam(Id LExpr) then local GenId={NewId} NewMapping={Adjoin Mapping Id#GenId}
			 in lam(GenId {RenameAux LExpr Id|Context NewMapping}) end
      
   [] let(Id#Expr1 Expr2) then local GenId={NewId} NewMapping={Adjoin Mapping Id#GenId}
			       in let(GenId#{RenameAux Expr1 Context Mapping} {RenameAux Expr2 Id|Context NewMapping}) end
      
   [] apply(Expr1 Expr2) then apply({RenameAux Expr1 Context Mapping} {RenameAux Expr2 Context Mapping}) 
   [] Id then if {And {Contains Context Id} {IsMember Mapping Id}} then
		 {Fetch Mapping Id}
	      else Id end
   end   
end

{Browse {Rename lam(z lam(x z))}}
{Browse {Rename let(id#lam(z z) apply(id y))}}
      
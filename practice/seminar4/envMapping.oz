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


local E1='E1' E3='E3' E4='E4' in
   {Browse {IsMember [a#E1 b#y c#E3] c}}
   {Browse {IsMember [a#E1 b#y c#E3] y}}
   {Browse {Fetch [a#E1 b#y c#E3] c}}
   {Browse {Fetch [a#E1 b#y c#E3] d}}
   {Browse {Adjoin [a#E1 b#y c#E3] c#E4}}
   {Browse {Adjoin [a#E1 b#y c#E3] d#E4}}
end
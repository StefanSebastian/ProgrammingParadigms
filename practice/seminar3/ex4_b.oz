declare
fun {Position Xs Y}
   % returns the position of Y in Xs ; does not assume that Y is part of Xs; positions start from 1

   case Xs of
      nil then 0                               % empty list means Y not found => 0
   [] H|T then   
      if H == Y then 1                         % if we found Y on the first position then we return 1
      else                                     % else we analyse the rest of the list
	 local
	    R = {Position T Y}                 % R is bound to the position of Y in the tail of the list
	 in
	    if R == 0 then 0                   % if Y is not in the tail of the list then we return 0
	    else 1 + {Position T Y} end	       % if Y is in the tail of the list then we add 1 to its current position
	 end
      end
   end
end
{Browse {Position [a b c] c}}
{Browse {Position [a b c b] b}}
{Browse {Position [a b c] f}}



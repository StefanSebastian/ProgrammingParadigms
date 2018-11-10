declare
fun {Position Xs Y}
   % returns the position of Y in Xs ; assumes that Y is part of Xs; positions start from 1
   case Xs of H|T then if H == Y then 1 else 1 + {Position T Y} end
   end
end
{Browse {Position [a b c] c}}
{Browse {Position [a b c b] b}}




% tests whether Y is element of Xs
declare
fun {Member Xs Y}
   case Xs of
      nil then false                                            % we reach the end without finding Y
   [] H|T then if Y == H then true else {Member T Y} end        % compares each head 
   end
end
{Browse {Member [a b c] b}}
{Browse {Member [a b c] d}}
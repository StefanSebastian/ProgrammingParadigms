declare
fun {Take Xs N}
   % returns a sublist of the first N elements of Xs ; or Xs if N > len(Xs)
   if N == 0 then                           
      nil
   else
      case Xs of
	 nil then nil
      [] H|T then H|{Take T N - 1}     % while N > 0 add the head to result and decrement N
      end
   end
end

declare
fun {Drop Xs N}
   % returns a sublist of Xs without the first N elements ; or nil if N > len(Xs)
   case Xs of
      nil then nil
   [] H|T then if N == 0 then H|{Drop T 0} else {Drop T N - 1} end       % while N > 0 dont add the head, decrement N
   end
end

{Browse {Take [1 4 3 6 2] 3}}
{Browse {Take [1 2] 3}}
{Browse {Take [1 2] 0}}

{Browse {Drop [1 4 3 6 2] 3}}
{Browse {Drop [1 2] 3}}
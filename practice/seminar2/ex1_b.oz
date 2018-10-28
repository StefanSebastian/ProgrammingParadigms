declare
fun {Comb N K}
   case K 
   of 0.0 then 1.0
   [] 1.0 then N
   else ((N-K+1.0) / K) * {Comb N K-1.0}
   end
end
{Browse {Comb 10.0 3.0}}
{Browse {Comb 10.0 0.0}}

declare
fun {RangeProd N M}
   % product of all numbers in range N-M
   if N == M then
      N
   else
      M * {RangeProd N M-1}
   end
end

declare
fun {Comb N K}
   % Calculates N choose K
   if K == 0 then
      1
   else
      {RangeProd N-K+1 N} div {RangeProd 1 K} 
   end
end

{Browse {Comb 10 3}}
{Browse {Comb 10 0}}
   
declare
fun {Max N M}
   % Returns the maximum out of N, M
   if N == 0 then
      M
   elseif M == 0 then
      N
   else
      1 + {Max N-1 M-1}
   end
end
{Browse {Max 3 8}}
{Browse {Max 60 4}}
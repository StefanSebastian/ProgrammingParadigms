declare
fun {Pow N M}
   % Calculates N to the power of M
   if M == 0 then           % any number at power 0 is 1
      1
   else
      N * {Pow N M-1}       % multiply N and decrease power index
   end
end
{Browse {Pow 2 3}}
{Browse {Pow 3 2}}
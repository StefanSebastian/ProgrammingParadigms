declare
fun {Abs N}
   % Returns the absolute value of N ; handle both ints and floats
   if {Float.is N} then
      if N >= {IntToFloat 0} then N else ~N end
   else
      if N >= 0 then N else ~N end
   end
end
{Browse {Abs 2}}
{Browse {Abs ~3}}
{Browse {Abs 12.34}}
{Browse {Abs ~7.4}}
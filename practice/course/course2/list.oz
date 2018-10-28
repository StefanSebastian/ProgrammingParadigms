declare
fun {Head L}
   L.1
end

declare
fun {Tail L}
   L.2
end


declare
fun {Sum L}
   if L==nil
   then 0
   else {Head L} + {Sum {Tail L}}
   end
end
X = [1 2 3]
{Browse {Sum X}}
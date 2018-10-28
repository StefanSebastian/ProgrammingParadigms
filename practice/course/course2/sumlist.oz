declare
fun {Sum L}
   case L
   of nil then 0
   [] H|T then H + {Sum T}
   end
end
{Browse {Sum [1 2 3]}}
declare
fun {Sieve L}
   case L of
      nil then nil
   [] H|T then H|{Sieve {Filter T H}}
   end
end
fun {Filter L H}
   case L of
      nil then nil
   [] A|As then if (A mod H) == 0 then {Filter As H}
		else A|{Filter As H} end
   end
end
fun {Prime} {Sieve {Gen 2}} end
fun {Gen N} N|{Gen N+1} end
{Browse {Prime}}
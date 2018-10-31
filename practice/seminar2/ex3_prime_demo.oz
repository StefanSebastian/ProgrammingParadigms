% demo of prime number generator ; prints prime nr < 50
declare
fun {Sieve L}
   case L of
      nil then nil
   [] H|T then if H < 50 then {Browse H} H|{Sieve {Filter T H}} end
   end
end
fun lazy {Filter L H}
   case L of
      nil then nil
   [] A|As then if (A mod H) == 0 then {Filter As H}
		else A|{Filter As H} end
   end
end
fun {Prime} {Sieve {Gen 2}} end
fun lazy {Gen N} N|{Gen N+1} end
{Browse {Prime}}

% gets first prime bigger than max
declare
fun {Sieve L N}
   case L of
      nil then nil
   [] H|T then if H > N then H else {Sieve {Filter T H} N} end    % head elements are always primes
   end
end
fun lazy {Filter L H}
   % filters all numbers from list L that are divisible by H
   % should be lazy because L can be infinite
   case L of
      nil then nil
   [] A|As then if (A mod H) == 0 then {Filter As H}
		else A|{Filter As H} end
   end
end

% generates an infinite number of ints starting from N
fun lazy {Gen N} N|{Gen N+1} end

% get the first prime number bigger than N
fun {GetAfter N} {Sieve {Gen 2} N} end

{Browse {GetAfter 10}}
{Browse {GetAfter 4}}
{Browse {GetAfter 100}}
{Browse {GetAfter 32}}

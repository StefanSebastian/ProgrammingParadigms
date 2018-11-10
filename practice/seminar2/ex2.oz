declare
fun {Reverse L Acc}
   % Reverse list L using the accumulator pattern
   case L
   of nil then Acc
   [] H|T then {Reverse T H|Acc}
   end
end
{Browse {Reverse ['I' 'want' 2 go 'there'] nil}}



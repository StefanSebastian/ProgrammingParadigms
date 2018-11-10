declare
fun {Zip P}
   % converts a pair of lists to a list of pairs
   case P
   of nil#nil then nil                          % pair of empty lists to empty list
   [] (Hl|Tl)#(Hr|Tr) then Hl#Hr|{Zip Tl#Tr}    % at each step build a pair from the head of each list
   end
end

fun {UnZip Lp}
   % converts a list of pairs to a pair of lists
   case Lp
   of nil then nil#nil                          % emtpy list to pair of empty lists
   [] (Hl#Hr)|T then                            % extract a pair from head
      local
	 Rrest = {UnZip T}                      % pairs for tail of list
	 R = (Hl|Rrest.1)#(Hr|Rrest.2)          % add the head to each pair
      in R
      end
   end
end

{Browse {Zip [a b c]#[1 2 3]}}
{Browse {UnZip [a#1 b#2 c#3]}}
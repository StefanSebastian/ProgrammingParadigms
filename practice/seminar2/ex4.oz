% node(value, left, right)

declare
fun {Insert BTree N}
   if BTree == nil then
      node(value:N left:nil right:nil) % add root
   elseif BTree.value < N then
      node(value:BTree.value left:BTree.left right:{Insert BTree.right N})
   else
      node(value:BTree.value left:{Insert BTree.left N} right:BTree.right)
   end
end
fun {Smallest BTree}
   if BTree == nil then nil
   elseif BTree.left == nil then BTree.value
   else
      {Smallest BTree.left}
   end
end


R = {Insert nil 100}
X1 = {Insert R 20}
X2 = {Insert X1 10}
X3 = {Insert X2 40}
X4 = {Insert X3 300}
X5 = {Insert X4 11}
{Browse X5}
{Browse {Smallest X5}}
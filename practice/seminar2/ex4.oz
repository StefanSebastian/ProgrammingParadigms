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
   else {Smallest BTree.left} end
end
fun {Biggest BTree}
   if BTree == nil then nil
   elseif BTree.right == nil then BTree.value
   else {Biggest BTree.right} end
end
fun {IsSortedBST BTree}
   if BTree == nil then true
   elseif BTree.left \= nil andthen {Biggest BTree.left} > BTree.value then false
   elseif BTree.right \= nil andthen {Smallest BTree.right} < BTree.value then false
   else {And {IsSortedBST BTree.left} {IsSortedBST BTree.right}} end
 end

R = {Insert nil 100}
X1 = {Insert R 20}
X2 = {Insert X1 10}
X3 = {Insert X2 40}
X4 = {Insert X3 300}
X5 = {Insert X4 11}
{Browse X5}
{Browse {Smallest X5}}
{Browse {Biggest X5}}
{Browse {IsSortedBST X5}}


C1 = node(value:1 left:nil right:nil)
C4 = node(value:4 left:nil right:nil)
C5 = node(value:5 left:nil right:nil)
C2 = node(value:2 left:C1 right:C4)
C3 = node(value:3 left:C2 right:C5)
{Browse {IsSortedBST C3}}
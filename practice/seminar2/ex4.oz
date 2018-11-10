% node(value, left, right)

declare
fun {Insert BTree N}
   % Insert the value N inside the binary tree : BTree
   if BTree == nil then
      node(value:N left:nil right:nil) % add root
   elseif BTree.value < N then
      node(value:BTree.value left:BTree.left right:{Insert BTree.right N})
   else
      node(value:BTree.value left:{Insert BTree.left N} right:BTree.right)
   end
end
fun {Smallest BTree}
   % Returns the smallest value in BTree
   % always choose the left node until nil 
   if BTree == nil then nil
   elseif BTree.left == nil then BTree.value
   else {Smallest BTree.left} end
end
fun {Biggest BTree}
   % Returns the biggest value in BTree
   % always choose the right node until nil
   if BTree == nil then nil
   elseif BTree.right == nil then BTree.value
   else {Biggest BTree.right} end
end
fun {IsSortedBST BTree}
   % Returns true if the given tree is a sorted binary search tree, false otherwise
   if BTree == nil then true
   elseif BTree.left \= nil andthen {Biggest BTree.left} > BTree.value then false    % biggest value on leftside should not be larger than parent value
   elseif BTree.right \= nil andthen {Smallest BTree.right} < BTree.value then false % smalles value on rightside should not be smaller than parent value
   else {And {IsSortedBST BTree.left} {IsSortedBST BTree.right}} end                 % repeat above at all nodes
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
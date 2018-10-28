declare
Root=node(left:X1 right:X2 value:0)
X1=node(left:X3 right:X4 value:1)
X2=node(left:X5 right:X6 value:2)
X3=node(left:nil right:nil value:3)
X4=node(left:nil right:nil value:4)
X5=node(left:nil right:nil value:5)
X6=node(left:nil right:nil value:6)
{Browse Root}
proc {Preorder X}
   if X \= nil then {Browse X.value}
      if X.left \= nil then {Preorder X.left} end
      if X.right \= nil then {Preorder X.right} end
   end
end
{Preorder Root}
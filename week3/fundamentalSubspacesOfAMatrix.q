/ FUNCTIONS ==============================================
/ The null space of A is all 5-by-1 vectors vecX such that rA mmu vecX = 0
/ From the pivot columns, x1 and x3 are basic variables
/ From the non-pivot columns, x2, x4, and x5 are free variables

/ Solve the basic variables in terms of the free variables
/ x1 = 2*x2 + x4 - 3*x5
/ x3 = -2*x4 + 2*x5
/ ========================================================
/ Example reduced row echelon form of A from the notes
rA:(1 -2 0 -1 3f;0 0 1 2 -2;0 0 0 0 0);

/ Build a general null-space vector from free-variable values x2Val, x4Val, x5Val
nullVec:{[x2Val;x4Val;x5Val]
  (2f*x2Val)+x4Val-(3f*x5Val);
  x2Val;
  (-2f*x4Val)+(2f*x5Val);
  x4Val;
  x5Val
 };

/ Basis vector for the x2 free-variable direction
basis1:nullVec[1f;0f;0f];

/ Basis vector for the x4 free-variable direction
basis2:nullVec[0f;1f;0f];

/ Basis vector for the x5 free-variable direction
basis3:nullVec[0f;0f;1f];

/ Basis for the null space
nullBasis:(basis1;basis2;basis3);

/ Basic-variable column indices from the rref
basicCols:1 3;

/ Free-variable column indices from the rref
freeCols:2 4 5;

/ Any null-space vector is a linear combination of the basis vectors
/ vecX = x2Val*basis1 + x4Val*basis2 + x5Val*basis3
nullLinComb:{[x2Val;x4Val;x5Val]
  (x2Val*basis1)+(x4Val*basis2)+(x5Val*basis3)
 };

/ Example null-space vector
vecX:nullLinComb[4f;-1f;2f]

/ TESTS ===================================================
/ Example outputs
/ q)rA
/ 1 -2 0 -1 3
/ 0 0 1 2 -2
/ 0 0 0 0 0
/
/ q)basis1
/ 2 1 0 0 0
/
/ q)basis2
/ 1 0 -2 1 0
/
/ q)basis3
/ -3 0 2 0 1
/
/ q)nullBasis
/ 2 1 0 0 0
/ 1 0 -2 1 0
/ -3 0 2 0 1
/
/ q)basicCols
/ 1 3
/
/ q)freeCols
/ 2 4 5
/
/ q)vecX
/ 1 4 6 -1 2
/ ========================================================

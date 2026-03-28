/ FUNCTIONS ==============================================
/ Example 2x2 matrix A = (a b; c d)
amat2:(2 3f;1 4f);

/ Compute the determinant of a 2x2 matrix as ad - bc
det2:{[matVal] (matVal[0;0]*matVal[1;1]) - (matVal[0;1]*matVal[1;0])};

/ Compute the inverse of a 2x2 matrix using 1/det(A) * (d -b; -c a)
inv2:{[matVal]
  detVal:det2 matVal;
  (( matVal[1;1]%detVal; neg (matVal[0;1])%detVal);
   ((neg (matVal[1;0]))%detVal;  matVal[0;0]%detVal))
 };

/ Check whether a 2x2 matrix is invertible by testing det(A) <> 0
isInvertible2:{[matVal] 0f<>det2 matVal};

/ Example 3x3 matrix A = (a b c; d e f; g h i)
amat3:(1 2 3f;4 5 6f;7 8 10f);

/ Compute the determinant of a 3x3 matrix using the six-term diagonal rule
/ det(A)=aei+bfg+cdh-ceg-bdi-afh
/ NEEDS WORK
det3:{[matVal]
  row0:first matVal;
  row1:matVal 1;
  row2:matVal 2;
  a00:row0 0;
  a01:row0 1;
  a02:row0 2;
  a10:row1 0;
  a11:row1 1;
  a12:row1 2;
  a20:row2 0;
  a21:row2 1;
  a22:row2 2;
  ((a00*((a11*a22)-(a12*a21))) - (a01*((a10*a22)-(a12*a20))) + (a02*((a10*a21)-(a11*a20))))
 };

/ Check whether a 3x3 matrix is invertible by testing det(A) <> 0
isInvertible3:{[matVal] 0f<>det3 matVal};

/ Summarize the determinant result: if det(A) <> 0 then A is invertible
/ and the system A x = b has a unique solution
hasUniqueSolution2:{[matVal] isInvertible2 matVal};
hasUniqueSolution3:{[matVal] isInvertible3 matVal};
/ ========================================================


/ TESTS ==================================================
/ amat2
/ 2 3
/ 1 4

/ det2 amat2
/ 5

/ isInvertible2 amat2
/ 1b

/ inv2 amat2
/ 0.8 -0.6
/ -0.2 0.4

/ amat3
/ 1 2 3
/ 4 5 6
/ 7 8 10

/ det3 amat3
/ -3

/ isInvertible3 amat3
/ 1b
/ ========================================================
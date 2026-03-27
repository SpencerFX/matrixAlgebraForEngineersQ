/ FUNCTIONS ==============================================
/ Example matrix A from the notes
amat:(-3 6 -1 1 0f;1 -2 2 0 3f;2 -4 5 4 -1f);

/ Reduced row echelon form of A from the notes
rrefA:(1 -2 0 -1 3f;0 0 1 2 -2f;0 0 0 0 0f);

/ Return the columns of a matrix as a list of column vectors
colsOf:{[matVal] flip matVal};

/ Return the pivot column indices (1-based) from an RREF matrix
pivotCols:{[rrefVal]
  piv:();
  rowCt:count rrefVal;
  i:0;
  while[i<rowCt;
    rowVal:rrefVal[i];
    nz:where rowVal<>0f;
    if[count nz>0;
      piv,:enlist 1+first nz
    ];
    i+:1
  ];
  piv
 }

/ Return the basis columns for the column space of the original matrix using pivot columns from the RREF
colBasis:{[origMat;rrefVal]
  (colsOf origMat)[(pivotCols[rrefVal])-1]
 }

/ Return the dimension of the column space, equal to the number of pivot columns
colDim:{[rrefVal] count pivotCols rrefVal};
/ ========================================================


/ TESTS ==================================================
/ amat
/ -3  6 -1 1  0
/  1 -2  2 0  3
/  2 -4  5 4 -1
/
/ rrefA
/ 1 -2 0 -1  3
/ 0  0 1  2 -2
/ 0  0 0  0  0
/
/ pivotCols rrefA
/ 1 3
/
/ colBasis[amat;rrefA]
/ -3 1 2
/ -1 2 5
/
/ colDim rrefA
/ 2
/ ========================================================

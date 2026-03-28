/ FUNCTIONS ==============================================
/ Example 3x3 matrix from the lecture
amat3:(1 2 3f;4 5 6f;7 8 10f);

/ Compute the 3x3 determinant using the six-term Leibniz pattern from the lecture
det3:{[matVal]
  row0:first matVal;
  row1:matVal 1;
  row2:matVal 2;
  (row0 0)*(row1 1)*(row2 2)
  + (row0 1)*(row1 2)*(row2 0)
  + (row0 2)*(row1 0)*(row2 1)
  - (row0 2)*(row1 1)*(row2 0)
  - (row0 1)*(row1 0)*(row2 2)
  - (row0 0)*(row1 2)*(row2 1)
 };

/ Generate all permutations of a vector of indices
permuteVals:{[vecVal]
  $[1=count vecVal;
    enlist vecVal;
    raze {
      headVal:x;
      tailVec:vecVal except enlist headVal;
      (enlist headVal),/: .z.s tailVec
    } each vecVal
  ]
 };

/ Count inversions in a permutation to determine whether it is even or odd
invCount:{[permVal]
  invCt:0;
  i:0;
  n:count permVal;
  while[i<n-1;
    j:i+1;
    while[j<n;
      if[permVal[i]>permVal[j]; invCt+:1];
      j+:1
    ];
    i+:1
  ];
  invCt
 };

/ Return +1 for an even permutation and -1 for an odd permutation
permSign:{[permVal] $[0=(invCount permVal) mod 2; 1f; -1f]};

/ Compute the product for one Leibniz term using one entry from each row and the columns in permVal
permTerm:{[matVal;permVal]
  */ {(matVal[x]) permVal[x]} each til count matVal
 };

/ Compute the determinant of an n x n matrix using the Leibniz formula
/ det(A) = sum over all permutations sigma of sign(sigma) * product_i a[i, sigma(i)]
detLeibniz:{[matVal]
  permVals:permuteVals til count matVal;
  sum {permSign[x] * permTerm[matVal;x]} each permVals
 };

/ Return a simple table of the 3x3 Leibniz terms, their column orders, inversion counts, and signs
termTable3:{[matVal]
  permVals:permuteVals til 3;
  ([] columnOrder:permVals; flips:invCount each permVals; sign:permSign each permVals; termValue:permTerm[matVal;] each permVals)
 };
/ ========================================================


/ TESTS ==================================================
/ det3 amat3
/ -3f

/ detLeibniz amat3
/ -3f

/ termTable3 amat3
/ ========================================================
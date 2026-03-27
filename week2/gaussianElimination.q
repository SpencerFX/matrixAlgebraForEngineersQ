// =================================================
/ Represent a linear system as A x = b, where A is the coefficient matrix and b is the right-hand side vector
A:(-3 2 -1;6 -6 7;3 -4 4); b:-1 -7 -6

/ Form the augmented matrix by attaching b as the last column of A
augment:{[A;b] A,'enlist each b}

/ Swap two rows i and j of matrix M
swapRows:{[M;i;j] @[M;i j;:;M[j],M[i]]}

/ Multiply row i of matrix M by scalar c
scaleRow:{[M;i;c] @[M;i;:;c*M[i]]}

/ Replace row dst with row dst + c * row src
addRows:{[M;src;dst;c] @[M;dst;:;M[dst]+c*M[src]]}

/ Perform Gaussian elimination on augmented matrix M and return upper-triangular form
forwardElim:{
  [M]
  n:count M;
  i:0;
  while[i<n-1;
    p:M[i;i];
    j:i+1;
    while[j<n;
      if[M[j;i]<>0;
        M:addRows[M;i;j;neg M[j;i]%p]
      ];
      j+:1
    ];
    i+:1
  ];
  M
 };

/ Solve an upper-triangular augmented matrix by back substitution
backSub:{
  [U]
  n:count U;
  x:n#0f;
  i:n-1;
  while[i>=0;
    / Start from the augmented right-hand side
    rhs:last U[i];
    / Subtract the known terms to the right of the diagonal
    if[i<n-1;
      rhs-:sum ((i+1) _ -1 _ U[i]) * ((i+1) _ x)
    ];
    / Divide by the diagonal entry
    x[i]:rhs % U[i;i];
    i-:1
  ];
  x
 };

/ Solve A x = b by forming the augmented matrix, reducing to upper triangular form, and back substituting
gaussSolve:{[A;b] backSub forwardElim augment[A;b]}

/ Multiply matrix A by vector x
matVec:{[A;x] {sum y*x}[x] each A}

/ Check that x solves A x = b
checkSolution:{[A;x;b] matVec[A;x]~"f"$b}

/ TESTS
forwardElim augment[A;b]
x:gaussSolve[A;b]
checkSolution[A;x;b]
// =============================================

/ Swap rows i and j
swapRows:{[M;i;j] @[M;i j;:;M[j],M[i]]}

/ Multiply row i by scalar c
scaleRow:{[M;i;c] @[M;i;:;c*M[i]]}

/ Replace row dst with row dst + c * row src
addRows:{[M;src;dst;c] @[M;dst;:;M[dst]+c*M[src]]}

/ Compute reduced row echelon form
rref:{
  [M]
  M:"f"$M;
  rows:count M;
  colz:count first M;
  r:0;
  c:0;
  while[(r<rows) & (c<colz);
    / Find a pivot row at or below row r in column c
    piv:r;
    while[(piv<rows) & (M[piv;c]=0f); piv+:1];
    if[piv=rows;
      c+:1;
      :()
    ];
    / Move pivot row into place if needed
    if[piv<>r; M:swapRows[M;r;piv]];
    / Scale pivot row so pivot becomes 1
    M:scaleRow[M;r;1f%M[r;c]];
    / Eliminate all other entries in the pivot column
    i:0;
    while[i<rows;
      if[i<>r;
        if[M[i;c]<>0f;
          M:addRows[M;r;i;neg M[i;c]]
        ]
      ];
      i+:1
    ];
    r+:1;
    c+:1
  ];
  M
 };

/ Return pivot column indices (1-based) from an RREF matrix
pivotCols:{
  [R]
  rows:count R;
  colz:count first R;
  piv:();
  i:0;
  while[i<rows;
    j:0;
    found:0b;
    while[(j<colz) & not found;
      if[R[i;j]=1f;
        if[(sum abs R[;j])=1f;
          piv,:enlist 1+j;
          found:1b
        ]
      ];
      j+:1
    ];
    i+:1
  ];
  piv
 };

/ TESTS ==============================================
/ Tests
/ A1:(3 -7 -2 -7;-3 5 1 5;6 -4 0 2)
/ R1:rref A1
/ P1:pivotCols R1
// =================================================
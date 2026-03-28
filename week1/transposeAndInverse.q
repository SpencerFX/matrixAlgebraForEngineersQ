// =================================================
/ Transpose a matrix by flipping rows and columns
tr:{flip x}

/ Build an n x n identity matrix
eye:{[n] "f"$til[n]=/:til[n]}

/ Attach matrix B to the right side of matrix A to form an augmented matrix
augment:{[A;B] A,'B}

/ Swap rows i and j of matrix M
swapRows:{[M;i;j] @[M;i j;:;M[j],M[i]]}

/ Multiply row i of matrix M by scalar c
scaleRow:{[M;i;c] @[M;i;:;c*M[i]]}

/ Replace row dst with row dst + c * row src
addRows:{[M;src;dst;c] @[M;dst;:;M[dst]+c*M[src]]}

/ Reduce a matrix to reduced row echelon form
rref:{[M]
  M:"f"$M;
  rows:count M;
  colz:count first M;
  r:0;
  c:0;
  while[(r<rows)&(c<colz);
    piv:r;
    while[(piv<rows)&(M[piv;c]=0f); piv+:1];
    if[piv=rows;
      c+:1;
      :()
    ];
    if[piv<>r; M:swapRows[M;r;piv]];
    M:scaleRow[M;r;1f%M[r;c]];
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

/ Compute the inverse of an invertible square matrix A by reducing [A|I] to [I|A^{-1}]
inverseByRref:{[A]
  n:count A;
  R:rref augment["f"$A;eye n];
  n _' R
 };

/ Multiply two matrices A and B using row-by-column dot products
mm:{[A;B]
  BT:tr B;
  {sum x*y}/:\:[A;BT]
 };

/ Check whether Ainv is the inverse of A by verifying A*Ainv = I
checkInverse:{[A;Ainv] mm["f"$A;"f"$Ainv]~eye[count A]}

/ Example matrix from the notes
A:(-3 2 -1;6 -6 7;3 -4 4)

/ Form the augmented matrix [A|I]
AI:augment["f"$A;eye count A]

/ Reduce [A|I] to [I|A^{-1}]
R:rref AI

/ Extract the inverse from the right half
Ainv:inverseByRref A

/ TESTS ==============================================
/ AI
/ -3  2 -1 1 0 0
/  6 -6  7 0 1 0
/  3 -4  4 0 0 1
/
/ R
/ 1 0 0 -0.3333333  0.3333333 -0.6666667
/ 0 1 0  0.25       0.75      -1.25
/ 0 0 1  0.5        0.5       -0.5
/
/ Ainv
/ -0.3333333  0.3333333 -0.6666667
/  0.25       0.75      -1.25
/  0.5        0.5       -0.5
/
/ checkInverse[A;Ainv]
/ 1b
// =================================================
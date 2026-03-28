// =================================================
/ Transpose a matrix by flipping rows and columns
tr:{flip x}

/ Build an n x n identity matrix
eye:{[n] "f"$til[n]=/:til[n]}

/ Multiply two matrices A and B using row-by-column dot products
mm:{[A;B] {sum x*y}/:\:[A;tr B]}

/ Replace row i of matrix M with a new row value
setRow:{[M;i;row] @[M;i;:;row]}

/ Build an elementary matrix by starting from the identity and replacing one off-diagonal zero with value c
/ This corresponds to the row operation: row dst <- row dst + c * row src
elem:{[n;dst;src;c] @[eye n;(dst;src);:;c]}

/ Example matrix A from the notes
A:(-3 2 -1f;6 -6 7f;3 -4 4f)

/ First elementary matrix: multiply row 1 by 2 and add it to row 2
M1:elem[3;1;0;2f]

/ Second elementary matrix: multiply row 1 by 1 and add it to row 3
M2:elem[3;2;0;1f]

/ Third elementary matrix: multiply row 2 by -1 and add it to row 3
M3:elem[3;2;1;-1f]

/ After the first Gaussian elimination step
A1:mm[M1;A]

/ After the second Gaussian elimination step
A2:mm[M2;A1]

/ After the third Gaussian elimination step
U:mm[M3;A2]

/ Equivalent one-shot upper-triangular result
U1:mm[M3;mm[M2;mm[M1;A]]]

/ Collect the total elimination matrix
M:mm[M3;mm[M2;M1]]

/ Check that applying all elementary matrices to A gives U
checkElim:{[A;M;U] mm[M;A]~U}
// =================================================
tr:{flip x}

/ Build an n x n identity matrix
eye:{[n] "f"$til[n]=/:til[n]}

/ Multiply two matrices A and B using row-by-column dot products
mm:{[A;B] {sum x*y}/:\:[A;tr B]}

/ Build an elementary matrix from the identity by placing c in position (dst;src)
/ This represents the row operation: row dst <- row dst + c * row src
elem:{[n;dst;src;c] @[eye n;(dst;src);:;c]}

/ Invert one of these elementary matrices by changing the sign of the off-diagonal entry
elemInv:{[n;dst;src;c] elem[n;dst;src;neg c]}

/ Example matrix A from the notes
A:(-3 2 -1f;6 -6 7f;3 -4 4f)

/ Elementary matrices that perform the Gaussian elimination steps
M1:elem[3;1;0;2f]
M2:elem[3;2;0;1f]
M3:elem[3;2;1;-1f]

/ Apply the elementary matrices to A to obtain the upper-triangular matrix U
U:mm[M3;mm[M2;mm[M1;A]]]

/ Inverses of the elementary matrices are obtained by changing the sign of the added multiple
M1inv:elemInv[3;1;0;2f]
M2inv:elemInv[3;2;0;1f]
M3inv:elemInv[3;2;1;-1f]

/ The lower-triangular matrix L is the product of the inverse elementary matrices in reverse elimination order
L:mm[M1inv;mm[M2inv;M3inv]]

/ Check the LU decomposition by verifying A = L*U
checkLU:{[A;L;U] A~mm[L;U]}

/ Transpose a matrix
tr:{flip x}

/ Matrix multiply
mm:{[A;B] {sum x*y}[;] each[flip B] each A}

/ Compare two matrices with a tolerance
/ Compare two matrices entry-by-entry within tolerance eps
approxEq:{[X;Y;eps] all raze ((abs each X-Y) < enlist eps)}

/ Check A ≈ L*U
checkLU:{[A;L;U] approxEq["f"$A;mm["f"$L;"f"$U];1e-6]}

/ TESTS ==============================================
/ q)A
/ -3  2 -1
/  6 -6  7
/  3 -4  4

/ M1
/ 1 0 0
/ 2 1 0
/ 0 0 1
/
/ M2
/ 1 0 0
/ 0 1 0
/ 1 0 1
/
/ M3
/ 1  0 0
/ 0  1 0
/ 0 -1 1
/
/ U
/ -3  2 -1
/  0 -2  5
/  0  0 -2
/
/ M1inv
/  1 0 0
/ -2 1 0
/  0 0 1
/
/ M2inv
/  1 0 0
/  0 1 0
/ -1 0 1
/
/ M3inv
/ 1 0 0
/ 0 1 0
/ 0 1 1
/
/ L
/  1 0 0
/ -2 1 0
/ -1 1 1
/
/ mm[L;U]
/ -3  2 -1
/  6 -6  7
/  3 -4  4
/
/ checkLU[A;L;U]
/ 1b
// =================================================
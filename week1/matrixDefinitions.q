// =================================================
// Identity matrix showing boolean
eyeB:{[n] til[n]=/:til[n]}

// Identity matrix for numbers
eye:{[n] "j"$til[n]=/:til[n]}

// Matrix transpose
tr:{flip x}; 

// Dot product
dot:{sum x*y}; 

// Dot normal
norm2:{dot[x;x]}; 

/ Compute the dot product of row vector r against every row in matrix M
rowDots:{[r;M] {[a;b] sum a*b}[r;] each M}

/ Build the Gram matrix of M by taking dot products between every pair of rows
gram:{[M] rowDots[;M] each M}

/ Check whether the rows of Q are orthonormal by verifying Q * Q^T = I
rowsOrthonormal:{[Q] gram[Q]~eye[count Q]}

/ Check whether the columns of Q are orthonormal by verifying Q^T * Q = I
colsOrthonormal:{[Q] gram[tr[Q]]~eye[count first Q]}

/ Check whether Q is orthogonal by requiring both row and column orthonormality
isOrthogonal:{[Q] rowsOrthonormal[Q] and colsOrthonormal[Q]}

/ Compute squared norm of a vector
norm2:{sum x*x}

/ Multiply matrix Q by vector x
mv:{[Q;x] {sum x*y}/[;x] each Q}

/ Check whether multiplying x by Q preserves squared norm
preservesNorm:{[Q;x] norm2[mv[Q;x]]~norm2[x]}

/ TESTS ==============================================
/ Tests
/ Q:(0 -1;1 0)
/ x:3 4
/ rowsOrthonormal[Q]
/ colsOrthonormal[Q]
/ isOrthogonal[Q]
/ preservesNorm[Q;x]
// =================================================
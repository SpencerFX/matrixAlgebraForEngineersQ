/ FUNCTIONS ==============================================
/ These are functions for the math equations described in the 
/ week4 module 
/ NOTES:
/ Gram–Schmidt is used to take a set of linearly independent vectors and turn them into an orthogonal or orthonormal basis that spans the same subspace.
/ ========================================================
/ Compute the dot product of two vectors
dot:{[u;v] sum u*v};

/ Compute the squared norm of a vector
norm2:{[u] dot[u;u]};

/ Compute the norm of a vector
norm:{[u]sqrt norm2 u};

/ Project vector v onto vector u
proj:{[u;v] ((dot[u;v]) % norm2[u]) * u};

/ Perform the Gram-Schmidt step to create the next orthogonal vector from v and previous orthogonal vectors us
orthStep:{[v;us] v - sum proj[;v] each us};

/ Build an orthogonal basis from an input basis using the Gram-Schmidt process
gramSchmidtOrth:{[vectorSpace]
  us:enlist first vectorSpace;
  i:1;
  while[i<count vectorSpace;
    us,:enlist orthStep[vectorSpace[i];us];
    i+:1
  ];
  us
 };

/ Normalize a vector to unit length
normalize:{[u] u % norm u}

/ Build an orthonormal basis from an input basis using the Gram-Schmidt process
gramSchmidt:{[vectorSpace]
  normalize each gramSchmidtOrth vectorSpace
 };

/ Return the first k vectors of a basis
prefix:{[vectorSpace;k] k#vectorSpace};

/ Example basis vectors
v1:1 1 0f;
v2:1 0 1f;
v3:0 1 1f;
vectorSpace:(v1;v2;v3);

/ Orthogonal basis
usOrth:gramSchmidtOrth vectorSpace;

/ Orthonormal basis
us:gramSchmidt vectorSpace;

/ TESTS ===================================================
/ usOrth
/ 1 1 0
/ 0.5 -0.5 1
/ -0.6666667 0.6666667 0.6666667
/
/ us
/ 0.7071068 0.7071068 0
/ 0.4082483 -0.4082483 0.8164966
/ -0.5773503 0.5773503 0.5773503
/ ========================================================
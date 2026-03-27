/ FUNCTIONS ==============================================
/ Compute the dot product of two vectors
dotProd:{[vecA;vecB] sum vecA*vecB};

/ Compute the squared norm of a vector
sqNorm:{[vecVal] dotProd[vecVal;vecVal];}

/ Compute the norm of a vector
vecNorm:{[vecVal] sqrt sqNorm[vecVal]};

/ Normalize a vector to unit length
unitVec:{[vecVal] vecVal % vecNorm[vecVal]};

/ Project vecVal onto one orthonormal basis vector basisVec
projOnBasis:{[vecVal;basisVec] (dotProd[vecVal;basisVec]) * basisVec};

/ Orthogonally project vecVal onto subspace W with orthonormal basis basisSet
projOntoSubspace:{[vecVal;basisSet] sum projOnBasis[vecVal;] each basisSet};

/ Return the coefficients of vecVal along the orthonormal basis vectors of W
projCoeffs:{[vecVal;basisSet] dotProd[vecVal;] each basisSet};

/ Reconstruct the projection from coefficients and orthonormal basis vectors
rebuildProj:{[coeffVals;basisSet] sum coeffVals *' basisSet};

/ Split vecVal into its component in W and its orthogonal remainder
projSplit:{[vecVal;basisSet] projVal:projOntoSubspace[vecVal;basisSet]; (projVal; vecVal-projVal)}

/ Check whether a basis set is orthonormal
isOrthonormalBasis:{[basisSet] all raze {abs[dotProd[x;y]-z]<1e-6}[;basisSet] each/[basisSet;1f=(til count basisSet)=/:til count basisSet]};
/ ========================================================


/ TESTS ==================================================
/ Example orthonormal basis for a 2-dimensional subspace W in R^3
basisW:(1 0 0f;0 1 0f);

/ Example vector v in the bigger vector space V
vecV:2 3 4f;

/ Orthogonal projection of v onto W
projV:projOntoSubspace[vecV;basisW];

/ Coefficients a1,a2,...,ap of v along the basis vectors s1,s2,...,sp
coeffV:projCoeffs[vecV;basisW];

/ Projection and orthogonal remainder
splitV:projSplit[vecV;basisW];
/ ========================================================

/ Questions ==============================================
/ Q1. Solve with an orthoganal projection
dotProd:{[vecA;vecB] sum vecA*vecB};
projGen:{[aVal;bVal;cVal] aVal,((bVal+cVal)%2),((bVal+cVal)%2)};
projW:{[vecVal] (vecVal[0]; avg vecVal[1 2]; avg vecVal[1 2])};
v1:1 0 0f;
v2:0 1 0f;
p1:projW v1;
p2:projW v2;

/ Q2. Setting Up the Least-Squares Problem

/ Q3. Line of Best Fit
/ ========================================================
/ FUNCTIONS ==============================================
/ Coefficient matrix A for the underdetermined system
coefMat:(2 2 1f;2 -2 -1f);

/ Right-hand side vector b
rhsVec:0 1f;

/ Reduced row echelon form of the augmented matrix [A|b] from the notes
rrefAug:(1 0 0 0.25f;0 1 0.5 -0.25f);

/ Reduced row echelon form of A alone, used to find the null space
rrefA:2 3#raze -1 _' rrefAug;

/ Basis vector for Null(A), using x3 as the free variable
/ From rrefA:
/ x1 = 0
/ x2 = -0.5*x3
/ x3 = x3
nullBasis:enlist 0 -0.5 1f;

/ Return a general vector in Null(A): alpha * basisVector
nullVector:{[alphaVal] alphaVal * first nullBasis};

/ Particular solution v to A x = b
/ From the augmented rref:
/ x1 = 0.25
/ x2 + 0.5*x3 = -0.25
/ choose x3 = 0, then x2 = -0.25
particularVec:0.25 -0.25 0f;

/ General solution to A x = b is x = u + v
/ where u is any vector in Null(A) and v is one particular solution
generalSolution:{[alphaVal] nullVector[alphaVal] + particularVec};

/ Matrix-vector product
matVec:{[matVal;vecVal] {sum x*y}[;vecVal] each matVal};

/ Check that a vector lies in Null(A)
inNull:{[vecVal] 0 0f ~ matVec[coefMat;vecVal]};

/ Check that a vector solves A x = b
solvesSystem:{[vecVal] rhsVec ~ matVec[coefMat;vecVal]};

/ Example null-space vector with alpha = 3
uEx:nullVector 3f;

/ Example general solution with alpha = 3
xEx:generalSolution 3f;
/ ========================================================


/ TESTS ==================================================
/ rrefAug
/ 1 0 0    0.25
/ 0 1 0.5 -0.25

/ nullBasis
/ 0 -0.5 1

/ particularVec
/ 0.25 -0.25 0

/ uEx
/ 0 -1.5 3

/ inNull uEx
/ 1b

/ xEx
/ 0.25 -1.75 3

/ solvesSystem xEx
/ 1b
/ ========================================================
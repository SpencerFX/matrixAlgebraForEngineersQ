/ FUNCTIONS ==============================================
/ Independent variable values x1,...,xn
xVals:1 2 3 4 5f;

/ Observed noisy dependent values y1,...,yn
yVals:1.2 1.9 3.2 3.9 5.1f;

/ Build the least-squares design matrix A for a line y = beta0 + beta1*x
designMat:{[xVals] flip ((count xVals)#1f;xVals)};

/ Transpose a matrix
tr:{flip x};

/ Multiply a matrix by a vector
matVec:{[matVal;vecVal] {sum x*vecVal} each matVal};

/ Compute A^T A directly
/ Compute A^T A directly for the 2-column design matrix
ata:{[matVal]
  col0:(tr matVal)[0];
  col1:(tr matVal)[1];
  (dotProd[col0;col0] dotProd[col0;col1];
   dotProd[col1;col0] dotProd[col1;col1])
 };

/ Compute A^T b directly
atb:{
  [matVal;rhsVals]
  col0:(tr matVal)[0];
  col1:(tr matVal)[1];
  (dotProd[col0;rhsVals];dotProd[col1;rhsVals])
 }

/ Dot product of two vectors
dot:{[vecA;vecB] sum vecA*vecB}

/ Solve a 2x2 linear system M z = rhsVals
solve2x2:{[matVal;rhsVals]
  a00:matVal[0;0];
  a01:matVal[0;1];
  a10:matVal[1;0];
  a11:matVal[1;1];
  detVal:(a00*a11)-(a01*a10);
  (
    (( a11*rhsVals[0])-(a01*rhsVals[1]))%detVal;
    (((neg a10)*rhsVals[0])+(a00*rhsVals[1]))%detVal
  )
 };

/ Compute the least-squares coefficients beta0,beta1 from the normal equations
leastSquaresLine:{[xVals;yVals]
  n:count xVals;
  sx:sum xVals;
  sy:sum yVals;
  sxx:sum xVals*xVals;
  sxy:sum xVals*yVals;
  detVal:(n*sxx)-(sx*sx);
  beta0:((sxx*sy)-(sx*sxy))%detVal;
  beta1:((n*sxy)-(sx*sy))%detVal;
  (beta0;beta1)
 };

/ Return fitted y values for beta0,beta1
fitLine:{[betaVals;xVals] betaVals[0] + betaVals[1]*xVals};

/ Return residual vector b - A x
residuals:{[xVals;yVals;betaVals] yVals - fitLine[betaVals;xVals]};

/ Return squared-error objective
sqErr:{[xVals;yVals;betaVals]
  resVals:residuals[xVals;yVals;betaVals];
  sum resVals*resVals
 };

/ Build the column space basis vectors of the design matrix
/ For a line fit, Col(A) is spanned by the all-ones vector and the x vector
colBasisLS:{[xVals] ((count xVals)#1f;xVals)};

/ Example least-squares solution
betaVals:leastSquaresLine[xVals;yVals];

/ Example fitted values
yFit:fitLine[betaVals;xVals];

/ Example residuals
resVals:residuals[xVals;yVals;;betaVals];

/ Example sum of squared residuals
errVal:sqErr[xVals;yVals;betaVals];
/ ========================================================

/ Tests =======================================
/ Example outputs
/ q)designMat xVals
/ 1 1
/ 1 2
/ 1 3
/ 1 4
/ 1 5
/
/ q)colBasisLS xVals
/ 1 1 1 1 1
/ 1 2 3 4 5
/
/ q)betaVals
/ 0.11 0.99
/
/ q)yFit
/ 1.1 2.09 3.08 4.07 5.06
/
/ q)resVals
/ 0.1 -0.19 0.12 -0.17 0.04
/
/ q)errVal
/ 0.091
/ Tests =======================================

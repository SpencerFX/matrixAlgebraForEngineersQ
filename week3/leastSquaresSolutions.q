/ FUNCTIONS ==============================================
/ Example x-data and y-data from the notes
xVals:1 2 3f;
yVals:1 3 2f;

/ Build the design matrix A for the line y = beta0 + beta1*x
designMat:{[xVals] flip ((count xVals)#1f;xVals)};

/ Compute the transpose of a matrix
trMat:{flip x};

/ Compute the dot product of two vectors
dotProd:{[vecA;vecB] sum vecA*vecB};

/ Compute A^T A for the 2-column least-squares design matrix
normalMat:{[matVal]
  colSet:trMat matVal;
  col0:colSet[0];
  col1:colSet[1];
  row0:(dotProd[col0;col0];dotProd[col0;col1]);
  row1:(dotProd[col1;col0];dotProd[col1;col1]);
  (row0;row1)
 };

/ Compute A^T b for the least-squares problem
normalRhs:{[matVal;rhsVal]
  colSet:trMat matVal;
  col0:colSet[0];
  col1:colSet[1];
  (dotProd[col0;rhsVal];dotProd[col1;rhsVal])
 };

/ Solve a 2x2 linear system M z = rhsVal
solve2x2:{[matVal;rhsVal]
  a00:matVal[0;0];
  a01:matVal[0;1];
  a10:matVal[1;0];
  a11:matVal[1;1];
  detVal:(a00*a11)-(a01*a10);
  (((a11*rhsVal[0])-(a01*rhsVal[1]))%detVal;
   (((neg a10)*rhsVal[0])+(a00*rhsVal[1]))%detVal)
 };

/ Compute the least-squares coefficients beta0 and beta1
leastSquaresLine:{[xVals;yVals]
  aMat:designMat xVals;
  nMat:normalMat aMat;
  rhsVal:normalRhs[aMat;yVals];
  solve2x2[nMat;rhsVal]
 };

/ Compute fitted y values from beta0 and beta1
fitLine:{[betaVal;xVals] betaVal[0] + betaVal[1]*xVals};

/ Compute residuals y - yhat
residualVals:{[xVals;yVals;betaVal] yVals - fitLine[betaVal;xVals]};

/ Compute the sum of squared residuals
sqErr:{[xVals;yVals;betaVal]
  residVal:residualVals[xVals;yVals;betaVal];
  sum residVal*residVal
 };

/ Projection-matrix formula P = A (A^T A)^(-1) A^T applied to b
/ For this 2-column example we compute the projected right-hand side directly
projectedB:{[xVals;yVals]
  betaVal:leastSquaresLine[xVals;yVals];
  fitLine[betaVal;xVals]
 };
/ ========================================================

/ Tests =======================================
/ Example outputs from the lecture
aMat:designMat xVals;
nMat:normalMat aMat;
rhsVal:normalRhs[aMat;yVals];
betaVal:leastSquaresLine[xVals;yVals];
yHat:fitLine[betaVal;xVals];
residVal:residualVals[xVals;yVals;betaVal];
errVal:sqErr[xVals;yVals;betaVal];

/ aMat
/ 1 1
/ 1 2
/ 1 3

/ nMat
/ 3 6
/ 6 14

/ rhsVal
/ 6 13

/ betaVal
/ 1 0.5

/ yHat
/ 1.5 2 2.5
/
/ residVal
/ -0.5 1 -0.5

/ errVal
/ 1.5
/ Tests =======================================
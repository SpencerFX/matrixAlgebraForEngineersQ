/ W4-Q1 ==================================================
/ Show that the three-by-three determinant changes sign 
/ when the first two rows are interchanged.
/ ========================================================

/ W4-A1 ==================================================
/ determinant of a 3x3 matrix
det3:{[m]
  a00:m[0;0]; a01:m[0;1]; a02:m[0;2];
  a10:m[1;0]; a11:m[1;1]; a12:m[1;2];
  a20:m[2;0]; a21:m[2;1]; a22:m[2;2];
  (a00*a11*a22)+(a01*a12*a20)+(a02*a10*a21)
  -(a02*a11*a20)-(a01*a10*a22)-(a00*a12*a21)
 };

/ swap first two rows
swapRows:{[matrix] (matrix 1; matrix 0; matrix 2)};

m:(1 2 3f;4 5 6f;7 8 10f);

(det3 m; det3 swapRows m)
/ =======================================================
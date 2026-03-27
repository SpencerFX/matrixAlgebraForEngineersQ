// =============================================
/ Scalars in this course are real numbers, represented in q as numeric atoms such as floats
/ Vectors in this course are column vectors, represented here as lists of numbers
/ Multiply a scalar by a vector
smul:{[a;v] a*v}

/ Add two vectors
vadd:{[u;v] u+v}

/ Form w = a*u + b*v
lincomb:{[a;u;b;v] vadd[smul[a;u];smul[b;v]]}

/ Check whether a value is a 3-by-1 vector in this simplified q representation
is3Vector:{[v] 3=count v}

/ Check closure of the set of all 3-by-1 vectors under a*u + b*v
closed3VectorSpace:{[a;u;b;v] is3Vector u and is3Vector v and is3Vector lincomb[a;u;b;v]}
// ============================================


/ Tests =======================================
/ Example 3-by-1 vectors u and v
 u:1 2 3f
v:4 5 6f

/ Example scalars a and b
a:2f
b:-1f

/ Compute w = a*u + b*v
w:lincomb[a;u;b;v]

/ u
/ 1 2 3
/ v
/ 4 5 6
/ w
/ -2 -1 0
/ is3Vector w
/ 1b
/ closed3VectorSpace[a;u;b;v]
/ 1b
/ 
/ Show the component form from the notes:
/ if u=(x1,x2,x3) and v=(y1,y2,y3), then
/ w=a*u+b*v=(a*x1+b*y1, a*x2+b*y2, a*x3+b*y3)
/ Extract the four key vector spaces associated with a matrix A
/ 1) column space: the columns of A
colSpace:{[A] flip A}

/ 2) row space: the rows of A
rowSpace:{[A] A}

/ 3) null space placeholder: vectors x such that A x = 0
/ 4) left null space placeholder: vectors y such that y^T A = 0
/ In later topics these would be computed from elimination/rref

/ Example matrix
A:(1 2 3f;4 5 6f;7 8 9f)

/ Example outputs
colSpace A
/ 1 4 7
/ 2 5 8
/ 3 6 9

rowSpace A
/ 1 2 3
/ 4 5 6
/ 7 8 9
// =================================================
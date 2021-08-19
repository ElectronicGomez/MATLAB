A=[0 1 0 0
   0 0 1 0
   0 0 0 0
   0 1 0 1]; 
C=[1 0 1 1];
OO=obsv(A,C)
disp("rango de observabilidad")
observabilidad=rank(OO)
%es observable ya que el orden de la matriz A es igual al rango de la
%matriz de observabilidad
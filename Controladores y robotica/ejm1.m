clear all
close all
clc

syms s

v=0.2;
f=2.3;
q=2;

A=[0 1 0;
   0 0 1;
   -v/q -f/q 0];
B=[0 0;
   0 1;
   1/q 0];
C=[0 1 0;
   0 0 1];
D=[0 0;
   0 0];

%Estabilidad
polos=eig(A)

%Controlabilidad
%n es el orden de la matriz A
%si CC no pierde rango, el sistema es controlable
%si CC es cuadrada y su determinante es =! 0 entonces el sistema es controlable
CC=[B A*B A*A*B];
Cont=rank(CC)

%Observabilidad
%n es el orden de la matriz A
%si OO no pierde rango, el sistema es observable
%si OO es cuadrada y su determinante es =! 0 entonces el sistema es observable
OO=[C;
    C*A;
    C*A*A];
Obs=rank(OO)

%Matriz de transferencia
% I=[1 0 0;
%    0 1 0;
%    0 0 1];
% Gs1=C*((s*I-A)^-1)*B+D;
% pretty(Gs1);
Gs2=C*inv(s*eye(3)-A)*B+D;
pretty(Gs2)
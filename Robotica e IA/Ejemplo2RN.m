% Ejmplo 2 de Redes Neuronales
clear all; clc; close all
%Matrices

A = [   0    1    0    0 
        0    0    1    0
        0    0    0    1 
      -100 -100 -100 -10 ];
B = [ 0 0 0 1 ]';
C = [ 1 0 0 0];
D = [ 0 ];

%Propiedades
polos = eig(A)

CC = [ B A*B A*A*B A*A*A*B]
Cont = rank(CC)

OO = [C; C*A; C*A*A; C*A*A*A]
Obse = rank(OO)

%Condiciones Iniciales
ti = 0; dt = 0.001; tf = 15;
u = 5;
x = [ 0 0 0 0 ]';
k = 1;

%Simulacion

for t = ti:dt:tf
    X1(k,1) = x(1,1);
    X2(k,1) = x(2,1);
    X3(k,1) = x(3,1);
    X4(k,1) = x(4,1);
    TI(k,1) = t;
    
    %Sistema
    xp = A*x + B*u;
    y = C*x + D*u;
    
    x = x + xp*dt;
    k = k+1;
    
end

figure(1)
subplot(221)
plot(TI,X1); ylabel('X1'); grid on
subplot(222)
plot(TI,X2); ylabel('X2'); grid on
subplot(223)
plot(TI,X3); ylabel('X3'); grid on
subplot(224)
plot(TI,X4); ylabel('X4'); grid on

%________________

clear all

%Matrices
A = [   0    1    0    0 
        0    0    1    0
        0    0    0    1 
      -100 -100 -100 -10 ];
B = [ 0 0 0 1 ]';
C = [ 1 0 0 0];
D = [ 0 ];
dt = 0.001;

%Elaborando los patrones de entrenamiento

x1 = randn(1,10000);
x2 = randn(1,10000);
x3 = randn(1,10000);
x4 = randn(1,10000);
u  = randn(1,10000);

input_data = [x1; x2; x3; x4; u ];
x = [x1; x2; x3; x4 ];

%Sistema

xp = A*x + B*u;
x = x + xp*dt;

target_data = x;

save training_data input_data target_data












    
    
    
    
    
    
    
    
    
    
    
    
    
    




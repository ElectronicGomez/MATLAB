clear all; close all; clc;
load PesosMotorDc

%Matrices del sistema
A = [ -2  0  -0.02
       0  0    1
       1  1   -10];
   
B = [2
     0
     0];
 
C = [0 1 0];

D =[0];
   
%Definicion de tiempos
ti = 0; dt = 0.001; tf =2;

%Condificones iniciales
x = [0 0 0]';
u = 1;

%Simulacion
k = 1;

for t = ti:dt:tf
    X1(k,1) = x(1,1);
    X2(k,1) = x(2,1);
    X3(k,1) = x(3,1);
    T(k,1)  = t;
    
    %Sistema
    xp = A*x + B*u;
    y = C*x + D*u;
    
    Y(k,1) = y;
    
    %Sistema Neuronal
    YNN(:,k) = purelin(W2*(logsig(W1*[u;x] + b1)) + b2);
    
    x = x + xp*dt;
    
    k = k + 1;
end

figure(1)
plot(T, Y, 'k+', T, YNN(2,:)','r')
grid on


%--------------------------










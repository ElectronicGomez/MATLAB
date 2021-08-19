clear all; close all; clc; 
load Pesos_PC3;
% Matrices del Sistema.
A = [   0    1    0 
        0    0    1
      -100  -50  -10];
       
B = [ 0 0 1]';
C = [ 1 0 0];
D = [ 0 ];
K= [25900 2750 20];

%Definicion de tiempos
ti = 0; dt = 0.001; tf =2;

%Condificones iniciales
x = [15 15 15]';
u = 5;

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
    
    u= -K*x
    Y(k,1) = y;
    
    %Sistema Neuronal
    YNN(:,k) = purelin(W2*(logsig(W1*[u;x] + b1)) + b2);
    YNN(:,k)=purelin(W2*logsig(W1*[r;x]+b1)+b2);
    x = x + xp*dt;
    
    k = k + 1;
end

figure(1)
plot(T, Y, 'k+', T, YNN(2,:)','b')
grid on





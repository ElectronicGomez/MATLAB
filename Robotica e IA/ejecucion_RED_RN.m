clear all; clc; close all
% Ejmplo 2 de Redes Neuronales

%Condiciones Iniciales
load PesosRED_RN
A = [   0    1    0    0 
        0    0    1    0
        0    0    0    1 
      -100 -100 -100 -10 ];
B = [ 0 0 0 1 ]';
C = [ 1 0 0 0];
D = [ 0 ];


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
    
    %Red neuronal
    YNN(:,k) = purelin(W2*logsig(W1*[ x; u ]+b1)+b2);
    
    x = x + xp*dt;
    k = k+1;
    
end

figure(1)
subplot(221)
plot(TI,X1,'b', TI,YNN(1,:),'r'); ylabel('X1'); grid on
subplot(222)
plot(TI,X2,'b', TI,YNN(2,:),'r'); ylabel('X2'); grid on
subplot(223)
plot(TI,X3,'b', TI,YNN(3,:),'r'); ylabel('X3'); grid on
subplot(224)
plot(TI,X4,'b', TI,YNN(4,:),'r'); ylabel('X4'); grid on













    
    
    
    
    
    
    
    
    
    
    
    
    
    




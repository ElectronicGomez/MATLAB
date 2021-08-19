clear all; clc; close all
load DatosMotorDC
load PesosMotorDC
%Matrices del Sistema
A = [ -0.2 0 -0.02
       0 0  1 
       1 0 -10 ]
B = [ 2 
      0
      0]
C = [ 0 1 0 ]
D = [ 0 ]

%Definimos los tiempos
ti = 0;
dt = 0.001; 
tf = 3;

%Condiciones iniciales
x = [ 0 0 0 ]';
u = 1;

%Simulacion
k = 1;

for t = ti:dt:tf    
    TI(k,1) = t;
    x1(k,1) = x(1,1);
    x2(k,1) = x(2,1);
    x3(k,1) = x(3,1);
    %Sistema
    xp = A*x + B*u;
    y = C*x + D*u;
    
    Y(k,1) = y;
    
    %Sistema Neuronal
    YNN(:,k) = purelin(W2*logsig(W1*[x;u]+b1)+b2);
    
    
    x = x + xp*dt;
     
    k = k+1;
end
 figure(1)
 plot(TI,Y,'k+',TI,YNN(2,:)','r')
 grid on
 legend('Real', 'Neuronal')
 figure(2)
 plot(TI,YNN(2,:)'-Y,'r')
 figure(3)
 plot(YNN(2,:)'-Y)
 


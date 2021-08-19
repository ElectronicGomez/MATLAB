clear all; close all; clc
%datos sistema
load pesos
A=[0 1 0
   0 0 1
   -100 -50 -10];

B=[0 0 1]';
C=[1 0 0];
D=[0];



% %Propiedades
K=[25900 2750 20];
% %Condiciones iniciales
ti=0; dt=0.001; tf=1.5;
u=0;
x=[1 0 0]';
xo=[1 0 0]';
k=1;
r=20;
% 
% %Simulacion
for t=ti:dt:tf
    X1(k,1)=x(1,1);
    X2(k,1)=x(2,1);
    X3(k,1)=x(3,1);
    
    Xo1(k,1)=xo(1,1);
    Xo2(k,1)=xo(2,1);
    Xo3(k,1)=xo(3,1);
    T(k,1)=t; 
    %sistema
    xp= A*x+B*u;
    y= C*x + D*u;
    
    Y(k,1) = y;
    %Red Neuronal
    YNN(:,k)=purelin(W2*logsig(W1*[r;x]+b1)+b2);
    
    %Controlador
    u = -K*x + K(1,1)*r;
    % integral
    x=x+xp*dt;
    
    %contador
    k=k+1;
end
% 
figure(1)
plot(T, Y, 'k+', T, YNN(1,:)','b')
grid on

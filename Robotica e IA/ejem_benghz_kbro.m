clear all;close all;clc


load PesosRED_RN

%Matrices
A = [ 0     1    0   0
      0     0    1   0
      0     0    0   1
     -100 -100 -100 -10];

B = [0 0 0 1]';
C=[1 0 0 0];
D=[0];

%Propiedades:
polos = eig(A)
%Controlabilidad
CC = [B A*B A^2*B A^3*B]
cont=rank(CC)
%Observabilidad
OO = [C;C*A;C*A^2;C*A^3]
obse=rank(OO)

%Condiciones iniciales
ti=0;dt=0.001;tf=20;
u=5;
x=[0 0 0 0]';
k=1;
%Simulacion
for t = ti:dt:tf
    X1(k,1)=x(1,1);
    X2(k,1)=x(2,1);
    X3(k,1)=x(3,1);
    X4(k,1)=x(4,1);
    T(k,1)=t;
    
    %Sistema
    xp = A*x + B*u;
    y = C*x + D*u;
   
    %Red Neuronal
    YNN(:,k)= purelin(W2*logsig(W1*[x;u]+b1)+b2);
    
    %integral euler
    x = x+xp*dt;
    k=k+1;
end

figure(1)
subplot(221)
plot(T,X1,'b',T,YNN(1,:),'r');ylabel('X1');grid on
subplot(222)
plot(T,X2,T,YNN(2,:),'r');ylabel('X2');grid on 
subplot(223)
plot(T,X3,T,YNN(3,:),'r');ylabel('X3');grid on 
subplot(224)
plot(T,X4,T,YNN(4,:),'r');ylabel('X4');grid on
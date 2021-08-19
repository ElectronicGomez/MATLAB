clear all; close all; clc
%datos sistema
% A=[0 1 0
%    0 0 1
%    -100 -50 -10];
% 
% B=[0 0 1]';
% C=[1 0 0];
% D=[0];
% 
% % %Propiedades
% % polos=eig(A);
% % CC=[B A*B A*A*B A*A*A*B]
% % cont=rank(CC)
% % 
% % OO=[C; C*A; C*A*A; C*A*A*A]
% % obs=rank(OO)

% % %Condiciones iniciales
% ti=0; dt=0.001; tf=1.5;
% u=0;
% xo=[1 0 0]';
% k=1;
% r=20;
% % 
% % %Simulacion
% for t=ti:dt:tf
%     X1(k,1)=x(1,1);
%     X2(k,1)=x(2,1);
%     X3(k,1)=x(3,1);
%     T(k,1)=t; 
%     %sistema
%     xp = A*x + B*u;
%     y  = C*x + D*u;
%     %Observador
%     yo = C*xo + D*u;
%     xop = A*xo + B*u + L*(y-yo);
%     %Controlador
%     u = -K*xo + K(1,1)*r;
%     % integral
%     x=x+xp*dt;
%     %contador
%     k=k+1;
% end
% % 
% figure(1)
% subplot(221)
% plot(T,X1); ylabel('X1'); grid
% 
% subplot(222)
% plot(T,X2); ylabel('X2'); grid
% 
% subplot(223)
% plot(T,X3); ylabel('X3'); grid
% 
% subplot(224)
% plot(T,X4); ylabel('X4'); grid



clear all
% Matrices
A=[0 1 0
   0 0 1
   -100 -50 -10];

B=[0 0 1]';
C=[1 0 0];
D=[0];
K=[25900 2750 20];
dt=0.001;
% Elaborando patrones de entranamiento

x1=randn(1,10000);
x2=randn(1,10000);
x3=randn(1,10000); 
r=20*randn(1,10000);

input_data=[r;x1;x2;x3];
x=[x1;x2;x3];

%Controlador
u = -K*x + K(1,1)*r;

target_data=u;
save data input_data target_data
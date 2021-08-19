clear all; close all; clc

%Sistema
A = [ 0 1 0
    0 0 1
    -2 -1 2];
B = [0 0 1]';
C = [1 0 0];
D = [0];

%Propiedades del Sistema
%Estabilidad

polos = eig(A);
%Controlabilidad 
CC = [B A*B A*A*B];
controlabilidad = rank(CC);

%Observabilidad
OO = [C; C*A; C*A*A];
observabilidad = rank(OO);

%Redimencionar el sistema
Am = [A zeros(3,1)
       -C zeros(1,1)];
Bm = [ B 
      zeros(1,1)];
Wm = [zeros(3,1)
    eye(1,1)] ;
Cm = [C zeros(1,1)];
Dm = [D];

%Diseño el Controlador de Estados
pdc = -5*ones(4,1); %pdc = -10*ones(4,1);
Km = acker(Am,Bm,pdc)
K = Km(1,1:3);
kI= -Km(1,4)

%Diseño del Observador de Estados
pdo = -50*ones(3,1)
L = acker(A',C',pdo)'
%Tiempos

ti = 0;
dt = 0.001;
tf = 6;
%tf = 5;

%Condiciones Iniciales
x = [1 0 0 0]';
xo = [0.95 0 0]';
r=2; %referencia
u=2;
k=1;%Contador

%Simulación

for t = ti:dt:tf
    %Almacenamiento
    X1(k,1)=x(1,1);
    X2(k,1)=x(2,1);
    X3(k,1)=x(3,1);
    X4(k,1)=x(4,1);
    %Estados estimados
    Xo1(k,1)=xo(1,1);
    Xo2(k,1)=xo(2,1);
    Xo3(k,1)=xo(3,1); %la variable 4 es la accion integral
    T(k,1)=t;
    % Sistema Modificado
    xp = Am*x + Bm*u + Wm*r;            % Ecuación del Sistema.
    y = Cm*x + Dm*u + 0.05*randn(1,1);  % Ecuación de Salida + ruido.
    Y(k,1) = y;
    % Sistema Estimado u observado
    yo = C*xo + D*u;        %No tiene ruido
    xop = A*xo + B*u + L*(y-yo);
    
    %Ley de Control
    u = -K*x(1:3,1) + kI*x(4,1);
    %u = -K*xo + kI*x(4,1);
    
    %Integracion
    x = x+xp*dt;
    xo = xo + xop*dt;
    
    %Contador
    k = k+1;
    
end
figure(1)
subplot(311)
plot(T,X1-Xo1,'b');grid on;ylabel('Error X1')
subplot(312)
plot(T,X2-Xo2,'b');grid on;ylabel('Error X2')
subplot(313)
plot(T,X3-Xo3,'b');grid on;ylabel('Error X3')
    
figure(2)
subplot(311)
plot(T,Y,'g',T,Xo1,'r:',T,X1,'b');grid on;ylabel('X1')
legend('Y','Xo1','X1')
subplot(312)
plot(T,Xo2,'-r');grid on;ylabel('X2')
subplot(313)
plot(T,Xo3,'-r');grid on;ylabel('X3')

% figure(1)
% subplot(311) %matriz 3x1
% plot(T,X1-Xo1,'b');grid on; ylabel('Error X1')
% subplot(312)
% plot(T,X2-Xo2,'b');grid on; ylabel('Error X2')
% subplot(313)
% plot(T,X3-Xo3,'b');grid on; ylabel('Error X3')
% 
% figure(2)
% subplot(311)
% plot(T,Xo1,'r:',T,X1,'b');grid on; ylabel('X1')
% subplot(312)
% plot(T,Xo2,'r:',T,X2,'b');grid on; ylabel('X2')
% subplot(313)
% plot(T,Xo3,'r:',T,X3,'b');grid on; ylabel('X3')




    






clear all; close all; clc

%constantes

J= 0.01;
b=0.1;
K=0.01;
R=1;
L=0.5;

%matrices del sistema

A= [-R/L -K/L 0
     K/J -b/J 0
      0 1 0];
B=[1/L
    0
    0];
C= [0 0 1]  %sensor de posicion
    %K 0 0]; %ensor de torque
D=[0];
%Estabilidad
polos=eig(A)

%Controlabilidad
CC=[B A*B A*A*B]
%Dise?o del Controlador de Estados
pdc=[-10 -45 -27];
ak=acker(A,B,pdc);
%Observabilidad
OO= [ C; C*A; C*A*A]

%Dise?o del Observador de Estados
pdo=[-10 -10 -10];
L=acker(A',C',pdo)'

%tiempos
ti=0;
dt=0.001;  % tiempo de la se?al (frecuencia=1/T)
tf=5; %tiempo final

%Condiciones Iniciales
x=[0; 0; 1];
xo = [0;0;0.9];
u=1; %entrada del motor
k=1; %contador
%Simulacion
%Creamos un lazo
for t= ti:dt:tf
    %almacenar las variables
    X1(k,1)=x(1,1); %Intensidad
    X2(k,1)=x(2,1); %Velocidad Angular
    X3(k,1)=x(3,1); %Posicion Angular
    Xo1(k,1) = xo(1,1); 
    Xo2(k,1) = xo(2,1);
    Xo3(k,1) = xo(3,1);
    T(k,1) = t;       %Tiempo
    %u=sin(k/pi);
    
    
    %Sistema
    xp = A*x + B*u; %Ecuacion del Sistema
    y  = C*x + D*u;%Ecuacion de Salida
    
    %sistema estimado
    yo = C*xo + D*u;
    xop = A*xo + B*u + L*(y-yo);
    
    %Ley de Control
    u = -ak*xo; % u = -ak*[y(2,1)/K no_hay y(1,1)]'
    
    %Integracion
    x = x + xp*dt;
    xo = xo + xop*dt;
    %Contador
    k = k + 1;
    
end

figure(1);
subplot(211)
plot(T,X3,'b',T,Xo3,'r:');grid on
ylabel('Posicion Angular')

subplot(223);
plot(T,X2,'b',T,Xo2,'r:');grid on
ylabel('Velocidad Angular')

subplot(224)
plot(T,X1,'b',T,Xo1,'r:');grid on
ylabel('Intensidad')

figure(2)
subplot(211)
plot(T,X3-Xo3,'r');grid on
ylabel('Error Posicion Angular')

subplot(223)
plot(T,X2-Xo2,'r');grid on
ylabel('Error Velocidad Angular')

subplot(224)
plot(T,X1-Xo1,'r');grid on
ylabel('Error Intensidad')





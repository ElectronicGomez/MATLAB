clear all; clc; close all;
% Matrices del Sistema
A = [0  1
    -2 -3];
B = [ 0
      1];
 C = [1 0];
      
 D = [0]; 
 % Estabilidad
 polos = eig(A)
 % Controlabilidad: Rango de la matriz debe ser igual a la cantidad de las variables de estado(orden de la matriz A).
 CC = [B A*B];
 
 %observabilidad
 OO = [C;C*A]
 
 %Redimensionamiento del Sistema
 Am = [A zeros(2,1)
       -C zeros(1,1)];
 Bm = [ B 
      zeros(1,1)];
 Wm = [zeros(2,1)
     eye(1,1)] ;
 Cm = [C zeros(1,1)];
 Dm = [D];
 
 %Diseño del Controlador de Estados
 pdc = [-1 -1 -2];
 Km = acker(Am,Bm,pdc)
 K = Km(1,1:2);
 kI= -Km(1,3)
 
 %Diseño del observador de estado
 pdo = [-4 -4];
 L = acker(A',C',pdo)'
 
 
 
 
 %rank(CC)
 % Observabilidad: Permite ver si mediante las salidas, puedo estimar todas las variables de estado.
%  OO = [C
%        C*A
%        C*A*A];
%  rank(OO)
%  % Diseño de Controlador de Estados
%  pdc = [-1+sqrt(-2) -1-sqrt(-2) -8];
%  K = acker(A,B,pdc)
%  % Diseño del Observador de Estados
%  pdo = [-5 -5 -5];
%  L = acker(A',C',pdo)'
%  
 % Tiempos
 ti = 0;
 dt = 0.001;
 tf = 10;
 % Condiciones Iniciales
 x = [5 0 0]';
 xo = [4.5 0]';
 u = 2;                     % Entrada del sistema.
 r = 30;
 k = 1;                     % Contador.
 % Simulación
 for t = ti:dt:tf
    % Almacenamiennto
    X1(k,1) = x(1,1);       % Intensidad de Corriente.
    X2(k,1) = x(2,1);       % Velocidad angular.
    X3(k,1) = x(3,1);       % Posición angular.
    Xo1(k,1) = xo(1,1);       % Intensidad de Corriente(estimado).
    Xo2(k,1) = xo(2,1);       % Velocidad angular(estimado).
%     Xo3(k,1) = xo(3,1);       % Posición angular(estimado).
    T(k,1)  = t;            % Tiempo.
    % Sistema modificado
    xp = Am*x + Bm*u + Wm*r;         % Ecuación del Sistema.
    y = Cm*x + Dm*u;          % Ecuación de Salida.
    % Sistema Estimado
    yo = C*xo + D*u;
    xop = A*xo + B*u + L*(y-yo);
    % Ley de Control de Seguimiento
    u = -K*xo + kI*x(3,1);
    % Intengración
    x = x+xp*dt;
    xo = xo + xop*dt;
    % Contador
    k = k+1;
 end
 % Gráficas
 figure(1)
 subplot(311)
 plot(T,X1,'b',T,Xo1,'r'); grid on
 ylabel('X1')
 
 subplot(312)
 plot(T,X2,'b',T,Xo2,'r'); grid on
 ylabel('X2')
 
 subplot(313)
 plot(T,X3,'b')%,T,Xo3,'r'); grid on
 ylabel('X3') 
 
 figure(2)
 subplot(311)
 plot(T,X1-Xo1,'b'); grid on
 ylabel('X1')
 
 subplot(312)
 plot(T,X2-Xo2,'b'); grid on
 ylabel('X2')
 
 subplot(313)
 plot(T,X3,'b'); grid on
 ylabel('X3')
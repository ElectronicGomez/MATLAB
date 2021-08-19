clear all; clc; close all;
% Matrices del Sistema
A = [0  1    0 
     0  0    1
     0  -6  -5];
 B = [0
      0
      1];
 C = [1 0 0];
      
  D = [0]; 
 % Estabilidad
 polos = eig(A)
 % Controlabilidad: Rango de la matriz debe ser igual a la cantidad de las variables de estado(orden de la matriz A).
 CC = [B A*B A*A*B];
 rank(CC)
 % Observabilidad: Permite ver si mediante las salidas, puedo estimar todas las variables de estado.
 OO = [C
       C*A
       C*A*A];
 rank(OO)
 % Diseño de Controlador de Estados
 pdc = [-1+sqrt(-2) -1-sqrt(-2) -8];
 K = acker(A,B,pdc)
 % Diseño del Observador de Estados
 pdo = [-5 -5 -5];
 L = acker(A',C',pdo)'
 
 % Tiempos
 ti = 0;
 dt = 0.001;
 tf = 10;
 % Condiciones Iniciales
 x = [5 0 1]';
 xo = [4.5 0 0.9]';
 u = 1;                     % Entrada del sistema.
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
    Xo3(k,1) = xo(3,1);       % Posición angular(estimado).
    T(k,1)  = t;            % Tiempo.
    % Sistema
    xp = A*x + B*u;         % Ecuación del Sistema.
    y = C*x + D*u;          % Ecuación de Salida.
    % Sistema Estimado
    yo = C*xo + D*u;
    xop = A*xo + B*u + L*(y-yo);
    % Ley de Control de Seguimiento
    u = -K*xo + K(1,1)*r;
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
 plot(T,X3,'b',T,Xo3,'r'); grid on
 ylabel('X3') 
 
 figure(2)
 subplot(311)
 plot(T,X1-Xo1,'b'); grid on
 ylabel('X1')
 
 subplot(312)
 plot(T,X2-Xo2,'b'); grid on
 ylabel('X2')
 
 subplot(313)
 plot(T,X3-Xo3,'b'); grid on
 ylabel('X3')
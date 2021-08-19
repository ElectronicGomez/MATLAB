clc; clear all; close all; 
syms s;
%---------- Variables del Motor ----------%
RA = 20.2; 
LA = 0.952e-3;
KT = 37.4e-3;
KB = 1/(255*(pi/30));
J = 4.11e-7;
B = 12.1e-3/(7450*(pi/30));
%---------- Matrices del Sistema ----------%
A = [0 1 0; 0 -B/J KT/J; 0 -KB/LA -RA/LA];  % X1 -> Posición / X2 -> Velocidad / X3 -> Corriente
B = [0; 0; 1/LA];
C = [1 0 0];
D = [0];
%--------- Matrices del Sistema con Integrador ----------%
Ai = [ A zeros(3,1); -C 0 ];
Bi = [ B; 0 ];
Ci = [ C 0 ];
Di = [ 0 ];
Wi = [ zeros(3,1); 1 ];
%-------- Cálculo del K óptimo ---------%
Q = [ 10000 0 0 0; 0 10000 0 0; 0 0 10000 0; 0 0 0 100000]*1;
R = [ 1 ];
[Km,PP,EE] = lqr(Ai,Bi,Q,R);
disp('K óptimo:')
K = Km(1,1:3)
Ki = -Km(1,4);
%---------- Simulación- ---------- 5
ti = 0; dt = 0.000001; tf = 10;         % Definición de Tiempos.
x = [ 0 0 0 0]'; u = 0; r = 157.080;    % Condiciones Iniciales, referencia.
k = 1;      
for t = ti:dt:tf
    TI(k,1) = t;
    X1(k,1) = x(1,1);
    X2(k,1) = x(2,1);
    X3(k,1) = x(3,1);
    X4(k,1) = x(4,1);
    U(k,1) = u;
    xp = Ai*x + Bi*u + Wi*r;
    y = Ci*x + Di*u;
    u = -K*x(1:3,1) + Ki*x(4,1);
    Y(k,1) = y;
    x = x + xp*dt;
    k = k + 1;
end
 
figure(1)
subplot(321)
plot(TI, X1,'b')
title('X1: POSICION'); grid on;%axis([0 1.5 0 2])
zoom on
subplot(322)
plot(TI,X2,'b')
title('X2: VELOCIDAD'); grid on; %axis([0 1.5 -0.1 2])
zoom on
subplot(323)
plot(TI,X3,'b')
title('X3: CORRIENTE'); grid on; %axis([0 1.5 -0.4 20]); zoom on
subplot(324)
plot(TI, X4,'b')
title('X4: ACCION INTEGRAL'); grid on;
zoom on
subplot(325)
plot(TI,U,'b')
title('u: ENTRADA');grid on; %axis([0 1.5 -3 40]);zoom on
figure(2)
plot(TI,Y,'b')
title('y: SALIDA'); hold on
plot(TI,r*ones(size(Y)),'r:')


%--------- Cálculo del L óptimo --------%
T = [ 100 0 0; 0 100 0;0 0 100]; S = [ 1 ];
[L,PPL,EEL] = lqr(A',C',T,S);
disp('L óptimo:')
L=L' 
% --------- Simulación ---------%
x = [ 0 0 0 0]'; xo = [ 0.0001 0.0001 0.0001]';  % Condiciones Iniciales.
u=0;
k = 1;
for t = ti:dt:tf
    TI(k,1) = t;
    X1(k,1) = x(1,1); XO1(k,1) = xo(1,1);
    X2(k,1) = x(2,1); XO2(k,1) = xo(2,1);
    X3(k,1) = x(3,1); XO3(k,1) = xo(3,1);
    X4(k,1) = x(4,1);
    U(k,1) = u;
    xp = Ai*x + Bi*u + Wi*r;
    y = Ci*x + Di*u;
    xop = A*xo + B*u + L*(y - C*xo);
    u = -K*xo + Ki*x(4,1);
    Y(k,1) = y;
    x = x + xp*dt;
    xo = xo + xop*dt;
    k = k + 1;
end
figure(3)
subplot(221)
plot(TI, X1,'b',TI, XO1,'r:')
title('POSCION- REAL/ESTIMADA'); grid on; %axis([0 1.5 0 2])
legend('X1','XO1')
zoom on
subplot(222)
plot(TI, X2,'b',TI, XO2,'r:')
title('VELOCIDAD - REAL/ESTIMADA'); grid on; %axis([0 1.5 0 2])
legend('X2','XO2')
zoom on
subplot(223)
plot(TI, X3,'b',TI, XO3,'r:')
title('CORRIENTE - REAL/ESTIMADA'); grid on; %axis([0 1.5 0 2])
zoom on
subplot(224)
plot(TI, U,'b')
title('u: ENTRADA'); grid on; %axis([0 1.5 0 2])
zoom on
figure(4)
plot(TI, Y,'b')
title('y: Salida'); hold on
plot(TI,r*ones(size(Y)),'r:')

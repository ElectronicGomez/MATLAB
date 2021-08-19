clear all; close all; clc; 
load Pesos_PC3;
% Matrices del Sistema.
A = [0   1   0
     0   0   1
     -1  -1  -1];
 B = [0
      0
      1];
  C = [1 0 0];
  D = [0];
% Definición de Tiempos.
ti = 0; dt = 0.001; tf = 3;
% Condiciones Iniciales.
x = [0 0 0]';
u = 1;
% Simulación.
k = 1;
for t = ti:dt:tf
   TI(k,1) = t;
   X1(k,1) = x(1,1);
   X2(k,1) = x(2,1);
   X3(k,1) = x(3,1);
   % Sistema.
   xp = A*x + B*u;
   y  = C*x + D*u;
   Y(k,1) = y;
   % Sistema Neuronal
   YNN(:,k) = purelin(W2*logsig(W1*[u;x]+b1)+b2);
   
   % Integración
   x = x + xp*dt;
   k = k + 1;
end    
% Gráficas Simulación.
figure(1)
plot(TI, Y,'k+', TI, YNN(1,:)','r'); grid on;
legend('Real','Neuronal')
close all; clear all; clc;
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
% Preparación de Entrenamiento.
% Entradas.
u  = randn(1,5000);
x1 = randn(1,5000);
x2 = randn(1,5000);
x3 = randn(1,5000);
xd = [x1;x2;x3];
entradas = [u;x1;x2;x3];
xdp = A*xd + B*u;
xd = xd + xdp*dt;
objetivos = xd;
save Datos entradas objetivos

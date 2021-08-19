%Matrices
clear all; clc;close all

A = [   0    1    0    0 
        0    0    1    0
        0    0    0    1 
      -100 -100 -100 -10 ];
B = [ 0 0 0 1 ]';
C = [ 1 0 0 0];
D = [ 0 ];
dt = 0.001;

%Elaborando los patrones de entrenamiento

x1 = randn(1,10000);
x2 = randn(1,10000);
x3 = randn(1,10000);
x4 = randn(1,10000);
u  = randn(1,10000);

input_data = [x1; x2; x3; x4; u ];
x = [x1; x2; x3; x4 ];

%Sistema

xp = A*x + B*u;
x = x + xp*dt;

target_data = x;

save training_data input_data target_data
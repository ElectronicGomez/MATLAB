
clear all; clc; close all

%Matrices
A = [   0    1    0 
        0    0    1
        0    0    -5];
       
B = [ 0 0 1]';
C = [ 1 0 0];
D = [ 0 ];

dt = 0.001;

%Elaborando los patrones de entrenamiento

x1 = randn(1,8000);
x2 = randn(1,8000);
x3 = randn(1,8000);
u  = randn(1,8000);

input_data = [x1; x2; x3; u ];
x = [x1; x2; x3];

%Sistema

xp = A*x + B*u;
x = x + xp*dt;

target_data = x;

save pregunta_6_pc3 input_data target_data

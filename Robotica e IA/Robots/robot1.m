clear all; close all; clc
% Armamos los links y los acoplamos
% th d a al
L1 = SerialLink([ 0 0 0.5 0 ]);
L2 = SerialLink([ 0 0 0.5 0 ]);
plotter = SerialLink([L1 L2])
figure(1)
plotter.plot([0 0]); pause
plotter.plot([pi/4 0]); pause
plotter.plot([pi/4 pi/4]); pause
plotter.plot([0 0
pi/8 pi/8
pi/6 pi/6
pi/4 pi/4
pi/2 pi/2])
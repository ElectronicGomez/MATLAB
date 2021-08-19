% probando demodulacion
clear all; clc
Ac = 1;
fb = 1;
tb = 1/fb;
Eb = (Ac^2)*tb/2;
k = Ac/Eb;
Vopt = 0;
fsen = 0:0.001:2-0.001;
f_sen = 0:0.001:4-0.002;
senal = Ac*cos(2*pi*fsen);
coseno = k*Ac*cos(2*pi*fsen);
seno = -k*Ac*sin(2*pi*fsen+pi/2);
demo = conv(senal,coseno)*0.001 - conv(senal,seno)*0.001;
plot(f_sen,demo); hold on
%plot(fsen,coseno); hold on
%plot([0 2 4 2 0],[0 10 0 -10 0])


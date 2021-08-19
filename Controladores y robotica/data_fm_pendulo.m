x1=-0.4:0.01:0.4;
x1_N=trapmf(x1,[-0.4 -0.4 -0.3 0]);
x1_Z=trimf(x1,[-0.3 0 0.3]);
x1_P=trapmf(x1,[0 0.3 0.4 0.4]);

figure(1)
subplot(311)
plot(x1,x1_N,'r',x1,x1_Z,'b',x1,x1_P,'g')
title('Funcionde Membresia x1=Posicion Angular(rad)')
legend('Positivo','Cero','Negativo');grid on


%Velocidad angular(Funcion de Membresia)
x2=-0.2:0.01:0.2;
x2_N=trapmf(x2,[-0.2 -0.2 -0.15 0]);
x2_Z=trimf(x2,[-0.15 0 0.15]);
x2_P=trapmf(x2,[0 0.15 0.2 0.2]);
subplot(312)
plot(x2,x2_N,'r',x2,x2_Z,'b',x2,x2_P,'g')
title('Funcion de Membresia x2=Velocidad Angular(rad/seg)')
legend('Positivo','Zero','Negativo');grid on


%Fuerza Expresada en VOltaje
u=-24:0.1:24;
u_GN = trapmf(u,[-24 -24 -16 -4 ]);
u_N = trimf(u,[-16 -4 -0.1]);%IMPORTANTE!!!!! POSITIVO Y NEGAITVO NO CHOQYEN
u_Z = trimf(u,[-4 0 4 ]);
u_P = trimf(u,[0.1 4 16 ]);%IMPORTANTE POSITIVO Y NEGATIVO NO CHQUEN
u_GP = trapmf(u,[4 16 24 24 ]);
subplot(313)
plot(u,u_GN,'r',u,u_N,'b',u,u_Z,'g',u,u_P,'m',u,u_GP,'k')
title('Funcion de Membresia u= Voltaje de Entrada')
legend('GN','N','Z','P','GP');grid on

save data_fm_pendulo
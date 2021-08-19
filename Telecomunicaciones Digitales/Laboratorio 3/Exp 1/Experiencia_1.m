clc; clear all; close all;

Eb = 1;
limite = 1e6;
Yub_dBs = 2:2:10;
Yub = 10.^(Yub_dBs/10);
n = Eb./Yub;
v = n/2;
Qk = sqrt(2*Yub);
Pub = qfunc(Qk);
bits = BitsAleatorios(limite);
sh = SH(bits);
Ber = [];
for i = 1:length(Yub_dBs)
    Ber = [Ber BER(Demodulacion(sh),Demodulacion(sh,normrnd(0,1,[1 limite])*sqrt(v(i))))];
end
figure
semilogy(Yub_dBs,Pub,'r'); hold on;
semilogy(Yub_dBs,Ber,'k*');
grid on;
%axis([-inf inf -inf inf])
title('Pub vs Yub y BER vs Yub')
legend('Pub', 'BER');
xlabel('dBs'); ylabel('Probabilidad')
function [modulacion t DEP_FSK f ts B] = FSK(M,bits,Ac,fb,fc,teta,N,pres)
tb = 1/fb;
n = log2(M);
ts = n*tb;
fs = 1/ts;
Nb = length(bits); 
%t = 0:pres:tb-pres;
t = 0:pres:tb*(Nb/n)-pres;
b = (-M+1):2:(M-1)
fd = fs*N/2;
%fk = fc+fd*b;
p = 1;
j = 0;
SumCos = [];
SumSen = [];
for i = ts:ts:length(t)*pres
    num = bits((1+n*j):(n+n*j));
    h = 1;
    nivel = 0;
    for ind = n-1:-1:0
        nivel = nivel + num(h)*(2^ind)
        h = h+1;
    end
    j=j+1;
    SumCos = [SumCos cos(pi*fb*t(p:i/pres)+teta)];
    SumSen = [SumSen b(nivel+1)*sin(pi*fb*t(p:i/pres)+teta)];
    p = 1+i/pres;
end
portadoraCos = cos(2*pi*fc*t+teta)*Ac;
portadoraSen = -sin(2*pi*fc*t+teta)*Ac;
% figure(10)
% plot(SumCos); hold on;
% plot(SumSen); hold on;
%plot(portadoraCos); hold on;
%plot(portadoraSen); hold on;
% legend('SumCos','SumSen')%,'portadoraCos','portadoraSen')
SumCosGr = SumCos.*portadoraCos;
SumSenGr = SumSen.*portadoraSen;
modulacion = SumCosGr + SumSenGr;

f = -3*fc:pres:3*fc;
DEP_FSK = [((Ac^2)./4).* ( (4./(pi*pi*fb)).*((cos(pi*(f+fc)./fb)./(((2*(f+fc)./fb).^2)-1)).^2) + (4./(pi*pi*fb)).*((cos(pi*(f-fc)./fb)./(((2*(f-fc)./fb).^2)-1)).^2) )];
ftm = (length(f)-1)/2;
f_con = [ftm+(-fc-fb/2)/pres+1 ftm+(-fc+fb/2)/pres+1 ftm+(fc-fb/2)/pres+1 ftm+(fc+fb/2)/pres+1];
ff = f(f_con);
DEP_FSK(f_con)=(DEP_FSK(f_con+1)+DEP_FSK(f_con-1))/2+Ac^2/16;
% figure(1)
% plot(f,DEP_FSK); xlabel('Hz'); ylabel('DEP'); grid on; hold on
%stem(ff,DEP_FSK); grid minor; axis tight
B = [fb fc-fb/2 fc+fb/2 3*fb fc-3*fb/2 fc+3*fb/2 (Ac^2)/(pi^2*fb)];
end
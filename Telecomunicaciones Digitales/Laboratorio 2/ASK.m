function [modulacion, tbits, DEP_ASK_Onoff, DEP_ASK_Polar, f, ts, B] = ASK(M,bits,Ac,fb,fc,teta,opcion,pres)
% M - ASK 
% MPSK    
% M - QAM 
% M - FSK 
n = log2(M);
if opcion == 0     % on-off
    ak = 0:1:M-1;
else               % formato polar
    ak = -M+1:2:M-1;
end
tb = 1/fb;
ts = n*tb;
fs = fb/n;
numbits = length(bits);
tbits = 0:pres:ts*(numbits/n)-pres;
tb_uno = 0:pres:ts-pres;
portadora = Ac*cos(2*pi*fc*tbits+teta);
niveles = [];
p=0;
for i = 1:n:numbits
    dec = [bits((1+n*p):1:(n+n*p))];
    h = 1;
    nivel = 0;
    for ind = n-1:-1:0
        nivel = nivel + dec(h)*(2^ind);
        h = h+1;
    end
    niveles = [niveles ones(1,length(tb_uno))*ak(nivel+1)];
    p = p+1;
end
modulacion = niveles.*portadora;
%plot(modulacion);
% DEP
f = -3*fc:pres:3*fc;
DEP_ASK_Onoff = ((Ac^2)/4)*((M^2-1)/(12.*fs)*sinc((f+fc)/fs).^2 + (M^2-1)/(12.*fs)*(sinc((f-fc)/fs)).^2);
DEP_ASK_Polar = ((Ac^2)/4)*((M^2-1)/(3.*fs)*sinc((f+fc)/fs).^2 + (M^2-1)/(3.*fs)*sinc((f-fc)/fs).^2);
f_con = fc/pres+1;
tam = (length(f)-1)/2;
prom = (DEP_ASK_Onoff(f_con+tam-1)+DEP_ASK_Onoff(f_con+tam+1))/2;
DEP_ASK_Onoff(f_con+tam) = prom+Ac^2*(M-1)^2/16;
DEP_ASK_Onoff(-f_con+tam) = prom+Ac^2*(M-1)^2/16;

B = [fs fc-fs/2 fc+fs/2 2*fs fc-fs fc+fs Ac^2*(M^2-1)/(48*fs) Ac^2*(M^2-1)/(12*fs)];

end
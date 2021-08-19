function [modulacion, tt, DEP_PSK, f, ts, B] = PSK(M,bits,Ac,fb,fc,teta,N,pres)
n = log2(M);
p=0;
niveles = [];
for i = 1:n:length(bits)
    dec = [bits((1+n*p):1:(n+n*p))];
    p = p+1;
    h = 1;
    nivel = 0;
    for ind = n-1:-1:0
        nivel = nivel + dec(h)*(2^ind);
        h = h+1;
    end
    niveles = [niveles nivel];
end
fik=(pi*2*niveles+N)/M; 
ik=cos(fik);
qk=sin(fik);
tb = 1/fb;
ts = n*tb;
Nb = length(bits); 
t = 0:pres:ts-pres;
length(t);
tt = 0:pres:ts*(Nb/n)-pres;
senalc=Ac*cos(2*pi*fc.*t+teta);
senals=-Ac*sin(2*pi*fc.*t+teta);
% Señal
xi=[];
for i=1:length(niveles)
    xi=[xi ik(i)*senalc];
end
xq=[];
for i=1:length(niveles)
    xq=[xq qk(i)*senals];
end
modulacion=xi+xq; 
f = -3*fc:pres:3*fc;
fs=fb/n;
DEP_PSK = (Ac^2./4)*( (1/fs)*(sinc((f+fc)./fs)).^2 + (1/fs)*(sinc((f-fc)./fs)).^2 );
B = [fs fc-fs/2 fc+fs/2 2*fs fc-fs fc+fs Ac^2/(4*fs)];

end
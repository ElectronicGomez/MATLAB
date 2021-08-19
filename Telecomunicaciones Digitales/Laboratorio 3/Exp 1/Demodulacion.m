function [Dem] = Demodulacion(SH,Ruido)
if nargin == 1
    Dem = zeros(1,length(SH));
    p = find(SH >= 0);
    Dem(p) = 1;
else
    SHRuido = SH+Ruido;
    Dem = zeros(1,length(SH));
    p = find(SHRuido >= 0);
    Dem(p) = 1;
end
end
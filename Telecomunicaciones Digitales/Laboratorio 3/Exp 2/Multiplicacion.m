function [r] = Multiplicacion(M,G)
r = [];
for i = 1:length(G(1,1:end));
    r =[r Xor(M.*G(1:end,i)')];
end
end
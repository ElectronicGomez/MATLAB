function [salida] = SH(bits) % simula el S/H
salida = -ones(1,length(bits));
posUno = find(bits > 0);
salida(posUno) = 1;
end
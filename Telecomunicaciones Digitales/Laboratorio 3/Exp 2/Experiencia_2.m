clc
clear all
close all

limite = 1e5; % numero de bits
Eb = 1;
Yub_dBs = 2:2:10;
Yub = 10.^(Yub_dBs/10);
n = Eb./Yub;
v = n/2; % Varianzas
Qk = sqrt(2*Yub);
Pub = qfunc(Qk);
M = BitsAleatorios(limite);
sh = SH(M);
Ber = [];
for i = 1:length(Yub_dBs)
    Ber = [Ber BER(Demodulacion(sh),Demodulacion(sh,normrnd(0,1,[1 limite])*sqrt(v(i))))];
end
%% Codificacion
% Codificacion
In = eye(4);
P =[1 0 1; 1 1 1; 1 1 0; 0 1 1];
G = [In P];
X = [];
Xc = [];
for i = 1:4:limite
    X = [X Multiplicacion(M(i:i+3),G)];
    Xc = [Xc ; Multiplicacion(M(i:i+3),G)];
end
%MARIO DE LA CRUZ 
% Transmision y Decodificacion
XMod = SH(X);
Beer = [];
b = [];
for i = 1:length(Yub_dBs)
    % Transmision
    Ruuu = normrnd(0,1,[1 length(XMod)])*sqrt(v(i)); % Ruido
    Y = Demodulacion(XMod,Ruuu);
    % Decodificacion;
    Iq = eye(3);
    Ht = [P;Iq];
    S = [];
    for i = 1:7:length(Y)
        S = [S ;Multiplicacion(Y(i:i+6),Ht)]; % Salida del DEMO
    end
    for i = 1:1:length(S(1:end,1))
        if Tabla(S(i,1:end)) ~= 10
            Y((i-1)*7+Tabla(S(i,1:end))) = not(Y((i-1)*7+Tabla(S(i,1:end)))); % Corrige bit errado
        end
    end
    Ms = [];
    for i = 1:7:length(Y)
        Ms = [Ms Y(i:i+3)];
    end
    Errores = length(find(M ~= Ms));
    Beer = [Beer Errores];
end
Beer = Beer/limite; % Probabilidad

n=7;
k=4;
dmin=3;
t=(dmin-1)/2;
Yub_dB2=2:2:10;
Yub2=10.^(Yub_dB2/10);
Ycb=(k/n)*Yub2;

pbbb=6*(qfunc(sqrt(2*Yub2))).^2;

figure(2);
semilogy(Yub_dB2,pbbb,'g-'); hold on;%PB
semilogy(Yub_dBs,Beer,'k*-');hold on%BER CODIFICADO
semilogy(Yub_dBs,Pub,'r-'); hold on;%PUB
semilogy(Yub_dBs,Ber,'b*-'); hold on;%BER UNCODIFICADO

grid on
legend('Pb','BER','Pub(unCoder)','BER unCoder');
title('Pb,BER Codificado,Pub y BER uncoder')

% figure(3);
% grid on
% plot(Ruuu)
% title('Relación Señal Ruido')

function [bits] = BitsAleatorios(n)
bits = round(rand(1,n));
% randi([0 1],1,1e6); digo alterno para crear valores aleatorios en un
% rando detremiando.
end

function [salida] = SH(bits) % simula el S/H
salida = -ones(1,length(bits));
posUno = find(bits > 0);
salida(posUno) = 1;
end

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

function [e] = BER(Inicial,Final)
diferencia = Final-Inicial;
Error = length(find(Final ~= Inicial));
e = Error/length(Inicial);
end

function [r] = Xor(x)
for i = 1:length(x)-1
    if x(i) == x(i+1)
        x(i+1) = 0;
    else
        x(i+1) = 1;
    end
end
r = x(end);
end

function [pos] = Tabla(Xs)
Es = [0 0 0 0 0 0 0; eye(7)];
Ss=[0 0 0;1 0 1;1 1 1; 1 1 0; 0 1 1; 1 0 0; 0 1 0;0 0 1];
pos = 10;
for i = 2:8
    if length(find(Xs == Ss(i,1:end))) == 3
        pos = find(Es(i,1:end) == 1);
        break;
    end
end
if pos == 0
    pos = 10;
end
end
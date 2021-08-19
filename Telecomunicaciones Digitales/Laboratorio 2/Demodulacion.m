function [bits, demo, bit] = Demodulacion(senal,t,M,Ac,fc,fb,teta,pres,opc,N,Ruido)

switch opc
    case 2 % 2-ASK
        n = log2(M);
        tb = 1/fb;
        ts=n*(tb);
        Eb = (Ac^2)*tb/4;
        k = Ac/Eb;
        portadora = k*Ac*cos(2*pi*fc*t+teta);
        Vopt = k*Eb;
        p=1;
        demo = [];
        bits = [];
        bit = [];
        for i = ts:ts:length(t)*pres
            dem = conv(senal(p:i/pres),portadora(p:i/pres))*pres;
            demo = [demo awgn(dem(1:ts/pres),Ruido)];
            p = 1+i/pres;
            if dem(ts/pres) > Vopt
                bits = [bits dem(ts/pres)*ones(1,ts/pres)];
                bit = [bit ones(1,ts/pres)];
            else
                bits = [bits dem(ts/pres)*ones(1,ts/pres)];
                bit = [bit zeros(1,ts/pres)];
            end
        end
    case 3  % 2-PSK
        n = log2(M);
        tb = 1/fb;
        ts = n*(tb);
        Eb = (Ac^2)*tb/2;
        k = Ac/Eb;
        portadora = 2*k*Ac*cos(2*pi*fc*t+teta);
        Vopt = 0;
        p=1;
        demo = [];
        bits = [];
        bit = [];
        for i = ts:ts:length(t)*pres
            dem = conv(senal(p:i/pres),portadora(p:i/pres))*pres;
            demo = [demo awgn(dem(1:ts/pres),Ruido)];
            p = 1+i/pres;
            if dem(ts/pres) > Vopt
                bits = [bits dem(ts/pres)*ones(1,ts/pres)];
                bit = [bit ones(1,ts/pres)];
            else
                bits = [bits dem(ts/pres)*ones(1,ts/pres)];
                bit = [bit zeros(1,ts/pres)];
            end
        end
    case 4  % 2-FSK
        n = log2(M);
        tb = 1/fb;
        ts = n*tb;
        fs = 1/ts;
        Eb = (Ac^2)*tb/2;
        k = Ac/Eb
        fd = fs*N/2;
        portcos = k*Ac*cos(2*pi*(fc+fd)*t+teta);
        portsen = -k*Ac*cos(2*pi*(fc-fd)*t+teta);
        Vopt = 0;
        p=1;
        demo = [];
        bits = [];
        bit = []; % senal(p:i/pres)
        for i = ts:ts:length(t)*pres
            %senRec = [senal(p:i/(pres*2)) senal(i/pres:-1:i/(pres*2)+1)];
            demCos = conv(senal(p:i/pres),portcos(p:i/pres))*pres;
            demSen = conv(senal(p:i/pres),portsen(p:i/pres))*pres;
%             figure(i)
%             plot(demCos,'g'); hold on;
%             plot(demSen,'b')
            dem = awgn(demCos-demSen,Ruido);
            demo = [demo dem(1:ts/pres)];
            p = 1+i/pres;
            if dem(ts/pres) > Vopt
                bits = [bits dem(ts/pres)*ones(1,ts/pres)];
                bit = [bit ones(1,ts/pres)];
            else
                bits = [bits dem(ts/pres)*ones(1,ts/pres)];
                bit = [bit zeros(1,ts/pres)];
            end
        end
end
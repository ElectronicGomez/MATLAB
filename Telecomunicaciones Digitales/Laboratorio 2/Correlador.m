function [bits, demo, bit] = Correlador(senal,t,M,Ac,fc,fb,teta,pres,opc,N,Ruido)
switch opc
    case 2 % 2-ASK
        n = log2(M);
        tb = 1/fb;
        ts=n*(tb);
        Eb = (Ac^2)*tb/4;
        k = Ac/Eb;
        Vopt = k*Eb;
        p=1;
        demo = [];
        bits = [];
        bit = [];
        for i = ts:ts:length(t)*pres
            portadora = k*Ac*cos(2*pi*fc*t(p:i/pres)+teta);
            dem = portadora.*senal(p:i/pres)*pres;
            demo = [demo awgn(cumtrapz(dem),Ruido)];
            p = 1+i/pres;
            if demo(i/pres) > Vopt
                bits = [bits demo(i/pres)*ones(1,ts/pres)];
                bit = [bit ones(1,ts/pres)];
            else
                bits = [bits demo(i/pres)*ones(1,ts/pres)];
                bit = [bit zeros(1,ts/pres)];
            end
        end
    case 3 % 2-PSK
        n = log2(M);
        tb = 1/fb;
        ts=n*(tb);
        Eb = (Ac^2)*tb/2;
        k = Ac/Eb;
        Vopt = 0;
        p=1;
        demo = [];
        bits = [];
        bit = [];
        for i = ts:ts:length(t)*pres
            portadora = -2*k*Ac*cos(2*pi*fc*t(p:i/pres)+teta);
            dem = portadora.*senal(p:i/pres)*pres;
            demo = [demo awgn(cumtrapz(dem),Ruido)];
            p = 1+i/pres;
            if demo(i/pres) > Vopt
                bits = [bits demo(i/pres)*ones(1,ts/pres)];
                bit = [bit ones(1,ts/pres)];
            else
                bits = [bits demo(i/pres)*ones(1,ts/pres)];
                bit = [bit zeros(1,ts/pres)];
            end
        end
     case 4 % 2-FSK
        n = log2(M);
        tb = 1/fb;
        ts=n*(tb);
        Eb = (Ac^2)*tb/2;
        k = Ac/Eb;
        fd = fb*N/2;
        Vopt = 0;
        p=1;
        demo = [];
        bits = [];
        bit = [];
        for i = ts:ts:length(t)*pres
            portadora1 = k*Ac*cos(2*pi*(fc+fd)*t(p:i/pres)+teta);
            portadora0 = k*Ac*cos(2*pi*(fc-fd)*t(p:i/pres)+teta);
            dem1 = portadora1.*senal(p:i/pres)*pres;
            dem0 = portadora0.*senal(p:i/pres)*pres;
            demo = [demo awgn(cumtrapz(dem1)-cumtrapz(dem0),Ruido)];
            p = 1+i/pres;
            if demo(i/pres) > Vopt
                bits = [bits demo(i/pres)*ones(1,ts/pres)];
                bit = [bit ones(1,ts/pres)];
            else
                bits = [bits demo(i/pres)*ones(1,ts/pres)];
                bit = [bit zeros(1,ts/pres)];
            end
        end
end
end
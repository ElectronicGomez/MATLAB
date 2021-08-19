function [senal_e,e,SNR] = Ruido(senal)
e = rand(1,length(senal));
SNR = e*e';
senal_e = e+senal;
end
function [e] = BER(Inicial,Final)
diferencia = Final-Inicial;
Error = length(find(Final ~= Inicial));
e = Error/length(Inicial);
end
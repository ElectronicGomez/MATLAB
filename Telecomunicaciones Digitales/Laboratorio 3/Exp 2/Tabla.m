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
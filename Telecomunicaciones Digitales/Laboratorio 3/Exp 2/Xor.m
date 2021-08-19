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
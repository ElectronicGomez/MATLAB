%Probando las singularidades
clear all; clc;

syms a1 a2 pi

k = 1;
for q1 = 0:0.01:2*pi
    kk = 1;
    for q2 = 0:0.01:2*pi
        J = [-a1*sin(q1)-a2*sin(q1+q2) -a2*sin(q1+q2)
              a1*cos(q1)+a2*sin(q1+q2)  a2*cos(q1+q2)
              0                             0
              0                             0
              0                             0
              1                             1           ];    
          if rank(J)<2
            Q(k,1) = [q1 q2];
            k = k+1;
          end
    end
end   
Q
    
    
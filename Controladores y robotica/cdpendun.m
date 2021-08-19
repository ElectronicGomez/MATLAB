
function [z] = cdpendun(x1o,x2o)
% x1o = 0.0175;
% x2o = -0.0698;
load data_fm_pendulo
%Fuzzificacion
x1_NI = interp1(x1,x1_N,x1o);
x1_ZI = interp1(x1,x1_Z,x1o);
x1_PI = interp1(x1,x1_P,x1o);
x2_NI = interp1(x2,x2_N,x2o);
x2_ZI = interp1(x2,x2_Z,x2o);
x2_PI = interp1(x2,x2_P,x2o);

X1F = [ x1_NI x1_ZI x1_PI ];
X2F = [ x2_NI x2_ZI x2_PI ];

r1 = min(x1_PI,x2_PI);
r2 = min(x1_PI,x2_ZI);
r3 = min(x1_PI,x2_NI);
r4 = min(x1_ZI,x2_PI);
r5 = min(x1_ZI,x2_ZI);
r6 = min(x1_ZI,x2_NI);
r7 = min(x1_NI,x2_PI);
r8 = min(x1_NI,x2_ZI);
r9 = min(x1_NI,x2_NI);

FAM = [ r1 r2 r3
        r3 r5 r6 
        r7 r8 r9 ]
%Operando las reglas difusas
%Valores de corte o alpha cust
GP = max([ r1 ])
P  = max([ r2 r4 ])
Z  = max([ r3 r5 r7 ])
N  = max([ r6 r8 ])
GN = max([ r9 ])
 
GP = GP*ones(size(u_GP));
P  = P*ones(size(u_P));
Z  = Z*ones(size(u_Z));
N  = N*ones(size(u_N));
GN = GN*ones(size(u_GN));

u_GP = min(GP,u_GP);
u_P  = min(P,u_P);
u_Z  = min(Z,u_Z);
u_N  = min(N,u_N);
u_GN = min(GN,u_GN);

%Uniendo los conjuntos
muZ = max([u_GN;u_N;u_Z;u_P;u_GP]);
z = defuzz(u,muZ,'centroid')
end











    
   












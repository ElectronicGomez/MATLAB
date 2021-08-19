clear all
close all
clc

syms s

A=[0 1 0;
   0 0 1;
   -0.1 -1.15 0]
B=[0;
   0;
   5]
C=[1 0 0]
D=[0]

%Estabilidad
polos=eig(A)

%Controlabilidad
%n es el orden de la matriz A
%si CC no pierde rango, el sistema es controlable
%si CC es cuadrada y su determinante es =! 0 entonces el sistema es controlable
CC=[B A*B A*A*B];
Cont=rank(CC)

%Observabilidad
%n es el orden de la matriz A
%si OO no pierde rango, el sistema es observable

%si OO es cuadrada y su determinante es =! 0 entonces el sistema es observable
OO=[C;
    C*A;
    C*A*A];
Obs=rank(OO)
 
%Matriz de transferencia
% I=[1 0 0;
%    0 1 0;
%    0 0 1];
% Gs1=C*((s*I-A)^-1)*B+D;
% pretty(Gs1);
Gs2=C*inv(s*eye(3)-A)*B+D;
pretty(Gs2)

%Diseño del controlador de seguimiento
Am=[A zeros(3,1);
    -C 0]
Bm=[B;
    0]
Wm=[zeros(3,1)
    1]
Cm=[C 0]
Dm=[D]

%Controlador
pdc=[-46+40j -46-40j -46+40j -46-340j];
Kt=acker(Am,Bm,pdc)
K=Kt(1,1:3)
KI=-Kt(1,4)

%Diseño del observador de Estados
%Del sistema no modificado
pdo=[-10 -10 -10]
L=acker(A',C',pdo)'

%Condiciones iniciales
x=[0 0 0 0]';
u=2;
r=10;
xo=[0.01 0 0]';  %porque la salida es x1

k=1;    %Contador
ti=0;
dt=0.001;
%tf=0.5;
tf=2;
%Simulación
for t=ti:dt:tf
    X1(k,1)=x(1,1);
    X2(k,1)=x(2,1);
    X3(k,1)=x(3,1);
    X4(k,1)=x(4,1);
    Xo1(k,1)=xo(1,1);
    Xo2(k,1)=xo(1,1);
    Xo3(k,1)=xo(1,1);
    TT(k,1)=t;
    
    %sistema
    xp=Am*x+Bm*u+Wm*r;
    y=Cm*x+Dm*u;
    
    %sistema estimado
    yo=C*xo+D*u;
    xop=A*xo+B*u+L*(y-yo);
    
    %Ley de control
    u=-K*xo+KI*x(4,1);
    
    %Integración
    x=x+xp*dt;
    xo=xo+xop*dt;
    
    k=k+1;
end
    
figure(1)
plot(TT,X1,'b',TT,Xo1,'r:')
grid on
hold on
plot(TT,r*1.02*ones(size(TT)),'m:',...
    TT,r*0.98*ones(size(TT)),'m:',...
    [0.2 0.2],[0 10],'m:')
    
    
    
    
    


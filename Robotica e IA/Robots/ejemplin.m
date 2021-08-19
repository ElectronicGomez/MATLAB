clear all;close all;clc
syms q1 q2 q1p q2p pi a m g
%----PASO 1----%
%Coordenadas de centro de masa

%Masa %Puede cmaibar
x = a*cos(q2)*sin(q1);%c1=cos(q1)
y = a*cos(q2)*cos(q1);%s1=sin(q1)
z = a*sin(q2);

% %-----PASO 2----%
%punto %Puede cambiar
xp=diff(x,q1)*q1p+diff(x,q2)*q2p;
xp_2=xp^2;

yp=diff(y,q1)*q1p+diff(y,q2)*q2p;
yp_2=yp^2;

zp=diff(z,q1)*q1p+diff(z,q2)*q2p;
zp_2=zp^2;

V_2=simplify(xp_2+yp_2+zp_2)

%Velocidad %Puede Cmabiar
K=simplify(1/2*m*V_2)

% Matriz de inercias
m11 = simplify(diff(diff(K,q1p),q1p));
m12 = simplify(diff(diff(K,q1p),q2p));
m21 = m12;
m22 = simplify(diff(diff(K,q2p),q2p));

M = [ m11 m12
      m21 m22 ]
%terminos de Christoffel
 
 c11=       1/2*(diff(m11,q1)+diff(m11,q1) - diff(m11,q1))*q1p;
 c11= c11 + 1/2*(diff(m11,q2)+diff(m12,q1) - diff(m21,q1))*q2p;
 
 c12=       1/2*(diff(m12,q1)+diff(m11,q2) - diff(m12,q1))*q1p;
 c12= c12 + 1/2*(diff(m12,q2)+diff(m12,q2) - diff(m22,q1))*q2p;
 
 c21=       1/2*(diff(m21,q1)+diff(m21,q1) - diff(m11,q2))*q1p;
 c21= c21 + 1/2*(diff(m21,q2)+diff(m22,q1) - diff(m21,q2))*q2p
 
 c22=       1/2*(diff(m22,q1)+diff(m21,q2) - diff(m12,q2))*q1p;
 c22= c22 + 1/2*(diff(m22,q2)+diff(m22,q2) - diff(m22,q2))*q2p
 
 C = [c11 c12
      c21 c22]
  
  
%Energia Potencial %Puede cambiar
 P = m*g*z
 
 
 %Vector gravedad
 g1 = diff(P,q1);
 g2 = diff(P,q2);

 G = [g1;g2] 
%  %q = [q1;q2]
%  %qp = [q1p;q2p]
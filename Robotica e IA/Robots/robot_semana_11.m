syms q1 q2 q1p q2p pi a1 a2

%coordenadas de centro de masa

%Masa 1

x1 = a1*cos(q1); %c1=cos(q1)
y1 = a1*sin(q1);%s1=cos(q1)

x2 = a1*cos(q1)+a2*cos(q1+q2);
y2 = a1*sin(q1)+a2*sin(q1+q2);

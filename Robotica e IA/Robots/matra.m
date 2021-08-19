function[A] = matra(a,d,al,th)
% Matriz de Transformación
A = [ cos(th) -cos(al)*sin(th) sin(al)*sin(th) a*cos(th)
sin(th) cos(al)*cos(th) -sin(al)*cos(th) a*sin(th)
0 sin(al) cos(al) d
0 0 0 1 ];
end
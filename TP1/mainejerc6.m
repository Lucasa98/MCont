%  Datos
%  =====
%     X0   : posiciones iniciales nodos 1 a nnod
%     mass : masas puntos 1 a nnod
%     conec: tabla de resortes y nodos conectados
%     rig  : constantes de resortes
clear all
global X0 mass conec rig Fext fixx fixy;
X0    = [0 0 1.5 0 1 2.5 2.5 2.5 2.5 5 4.5 5 4.5 7.5 6 7.5 6 5]';
mass  = [0.25 0.25 0.25 0.25 0.25 0.25 0.25 0.25 0.5]';
conec = [1 2;
         1 3;
         2 3;
         2 4;
         3 4;
         3 5;
         4 5;
         4 6;
         5 6;
         5 7;
         6 7;
         6 8;
         7 8;
         8 9];
rig   = [15 10 5 15 15 10 5 15 10 5 15 10 5 5]';
fixx  = [1];
fixy  = [1 2];
Fext  = [0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.1 0]';

nnod  = length(X0)/2;

Y0(1       :2*nnod,1) = X0(:,1);
Y0(2*nnod+1:4*nnod,1) = zeros(2*nnod,1);

t = 0:0.1:50-0.1;
[t,y] = ode23s(@odefunejer6,t,Y0);

X  = y(       1:2*nnod,:);
Xp = y(2*nnod+1:4*nnod,:);

% PLOT DE BARRAS:
% ANIMACIÓN:
for i = 1:length(y)
  pause(0.01)
  clf;
  % PLOT DE BARRAS:
  set(0, 'defaultfigurevisible', 'off');
  axis([-2 10 -2 10])
  hold on; grid on;
  title('Movimiento del reticulado')
  xlabel('Posición (x)');
  ylabel('Posición (y)');

  for j = 1:length(conec)
    n1 = conec(j,1);
    n2 = conec(j,2);
    plot([y(i,n1*2 - 1), y(i,n2*2-1)],[y(i,n1*2), y(i,n2*2)], "k");
  endfor

  filename=sprintf('gif/%05d.png',i);
  print(filename);
endfor

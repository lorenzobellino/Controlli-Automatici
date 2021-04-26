close all
clear all

 %PROGETTO DI UN OSSERVATORE DELLO STATO

 A = [[0,1];[-2400,-100]];
 B = [0;9];
 C = [600,0];
 D = [0];
%con autovalori:
lambda1 = -120;
lambda2 = -180;

%PARTE 1:
%si analizzino le proprieta di oervabilita del sistema

Mo = obsv(A,C)
rMo = rank(Mo)
%se rMo == 2 allora il sistema � osservabile

%%PARTE 2:
% assegnazione degli autovalori e generazione del vettore L

P = [lambda1,lambda2];
L = place(A',C',P)'
%verifico
eigAminLC = eig(A-L*C)

%%PARTE 3:
%definizione del sistema complessivo

Atot = [A,zeros(size(A));L*C,A-L*C]
Btot = [B;B]
Ctot = [C,zeros(size(C));zeros(size(C)),C]
Dtot = [D;D]

%PARTE 4:
%simulare evolutzione dello stato xtot(t) e della risposta ytot(t) ad un
%ingresso u(t) ad onda quadra di frequenza 0.5 Hz ed ampiezza 2 VPP,
%assumendo sempre nullo lo stato iniziale dell osdservatore ;
%si confrontino in particolare gli andamenti di x(t) rispetto alla sua
%stima nonche gli andamenti dell uscita y(t) e della sua stima, dati:

dx1 = [0,0]'
dx2 = [0.01,0]'
dx3 = [-0.01,0]'

t=0:.001:4;
r = sign(sin(2*pi*0.5*t));

sOsservatore = ss(Atot,Btot,Ctot,Dtot)

x0oss = [0;0]
x0tot1 = [dx1;x0oss]
x0tot2 = [dx2;x0oss]
x0tot3 = [dx3;x0oss]

%simulazione
[ytot1,T1,xtot1] = lsim(sOsservatore,r,t,x0tot1);
[ytot2,T2,xtot2] = lsim(sOsservatore,r,t,x0tot2);
[ytot3,T3,xtot3] = lsim(sOsservatore,r,t,x0tot3);

%plot dell uscita

figure, plot(t,r,'k',T1,ytot1(:,1),'r',T1,ytot1(:,2),'b--'),grid on,
title('risposta y1 e la sua stima yoss per xtot1')

figure, plot(t,r,'k',T2,ytot2(:,1),'r',T2,ytot2(:,2),'b--'),grid on,
title('risposta y2 e la sua stima yoss per xtot2')

figure, plot(t,r,'k',T3,ytot3(:,1),'r',T3,ytot3(:,2),'b--'),grid on,
title('risposta y3 e la sua stima yoss per xtot3')

%plot dello stato 
%x1 rispetto xoss1
figure, plot(T1,xtot1(:,1),'r',T1,xtot1(:,3),'g--'), grid on,
title('x1 rispetto ad x1oss per dx1')

figure, plot(T2,xtot2(:,1),'r',T2,xtot2(:,3),'g--'), grid on,
title('x1 rispetto ad x1oss per dx2')

figure, plot(T3,xtot3(:,1),'r',T3,xtot3(:,3),'g--'), grid on,
title('x1 rispetto ad x1oss per dx3')
%x2 rispetto a xoss2
figure, plot(T1,xtot1(:,2),'r',T1,xtot1(:,4),'g--'), grid on,
title('x2 rispetto ad x2oss per dx1')

figure, plot(T2,xtot2(:,2),'r',T2,xtot2(:,4),'g--'), grid on,
title('x2 rispetto ad x2oss per dx2')

figure, plot(T3,xtot3(:,2),'r',T3,xtot3(:,4),'g--'), grid on,
title('x2 rispetto ad x2oss per dx3')
   


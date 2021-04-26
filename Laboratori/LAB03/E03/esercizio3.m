close all
clear all

%POSIZIONAMENTO DEI POLI MEDIANTE REGOLATORE

A = [0,1;900,1];
B = [0;-9];
C = [600,0];
D = [0];

%autovalori dell osservatore:
lOss1 = -120;
lOss2 = -180;
%autovalori imposti dalla retroazione:
l1 = -40;
l2 = -60;

%%PARTE 1:
%si analizzino le proprieta di raggiungibilita e di osservabilita del sis
%A,B raggiungibile e A,C osservabile

Mr = ctrb(A,B)
Mo = obsv(A,C)

rMr = rank(Mr)
rMo = rank(Mo)

%se rMr == rMo --> il sistema e oss e ragg

%%PARTE 2 :
%progetto del vettore colonna L
Pl = [lOss1,lOss2];
L = place(A',C',Pl)';
%verifico
eigAminLC = eig(A-L*C)

%%PARTE 3:
%progetto del vettore riga K

Pk = [l1,l2];
K = place(A,B,Pk);
%verifico
eigAminBK = eig(A-B*K)

%%PARTE 4 :
%scelta del parametro alpha
alpha=-1;
% Per imporre la condizione di regolazione dell'uscita, basta scommentare:
% alpha=inv(-(C-D*K)*inv(A-B*K)*B+D)

%definizione del sistema controllato mediante regolatore dinamico
Areg = [A,-B*K;L*C,A-B*K-L*C];
Breg = [alpha*B; alpha*B];
Creg = [C,-D*K; zeros(size(C)),C-D*K];
Dreg = [alpha*D; alpha*D];

%%PARTE 5 :
%simulare evoluzione di dxtot e dytot ad un ingresso = onda quadra a freq
%0.5 Hz e 2VPP
%dati i seguenti valori dello stato iniziali:
dx01 = [0;0];
dx02 = [0.01;0];
dx03 = [-0.01;0];

%ingresso
t=0:.001:4;
r = sign(sin(2*pi*0.5*t));

%sistema 
sRegolato = ss(Areg,Breg,Creg,Dreg);

%xo osservato
dx0oss = [0;0];

%xtot
dx0tot1 = [dx01;dx0oss];
dx0tot2 = [dx02;dx0oss];
dx0tot3 = [dx03;dx0oss];

%simulazione
[yreg1,T1,xreg1] = lsim(sRegolato,r,t,dx0tot1);
[yreg2,T2,xreg2] = lsim(sRegolato,r,t,dx0tot2);
[yreg3,T3,xreg3] = lsim(sRegolato,r,t,dx0tot3);

%grafici
%plot dell uscita

figure, plot(t,r,'k',T1,yreg1(:,1),'r',T1,yreg1(:,2),'b--'),grid on,
title('risposta ytot e la sua stima yoss per dx0tot1')

figure, plot(t,r,'k',T2,yreg2(:,1),'r',T2,yreg2(:,2),'b--'),grid on,
title('risposta ytot e la sua stima yoss per dx0tot2')

figure, plot(t,r,'k',T3,yreg3(:,1),'r',T3,yreg3(:,2),'b--'),grid on,
title('risposta ytot e la sua stima yoss per dx0tot3')

%plot dello stato 
%xreg1 rispetto xoss1
figure, plot(T1,xreg1(:,1),'r',T1,xreg1(:,3),'g--'), grid on,
title('x1 rispetto ad x1oss per dx0tot1')

figure, plot(T2,xreg2(:,1),'r',T2,xreg2(:,3),'g--'), grid on,
title('x1 rispetto ad x1oss per dx0tot2')

figure, plot(T3,xreg3(:,1),'r',T3,xreg3(:,3),'g--'), grid on,
title('x1 rispetto ad x1oss per dx0tot3')

%xtot2 rispetto a xoss2
figure, plot(T1,xreg1(:,2),'r',T1,xreg1(:,4),'g--'), grid on,
title('x2 rispetto ad x2oss per dx0tot1')

figure, plot(T2,xreg2(:,2),'r',T2,xreg2(:,4),'g--'), grid on,
title('x2 rispetto ad x2oss per dx0tot2')

figure, plot(T3,xreg3(:,2),'r',T3,xreg3(:,4),'g--'), grid on,
title('x2 rispetto ad x2oss per dx0tot3')


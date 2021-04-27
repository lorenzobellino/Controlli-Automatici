close all
clear all

%posizionamento dei poli mediante retroazione degli stati
A = [[0,1];[900,1]];
B = [0;-9];
C = [600, 0];
D = 0;

%valuto se il modello e instabile
eigA = eig(A)
%peerche gli autovalori hanno parte reale > 0

%gli autovalori del sistema retroazionato sono:
lambda1 = -40;
lambda2 = -60;

%% PASSO 1:
% si analizzino le prop. di raggiungibilita del sistema linearizzato

Mr = ctrb(A,B) % matrice di raggiungibilita del sistema
rankMr = rank(Mr)
%rank = 2 ==> il sistema e completamente raggiungibile

%% PASSO 2:
%progettazione del vettore riga K tale che gli autovalori di A-BK = -40,-60

P = [lambda1,lambda2]
K = place(A,B,P)
%verifico
eigAminBK = eig(A-B*K)

%calcolo il valore di alpha
%alpha = inv(-(C-D*K)*inv(A-B*K)*B+D)
alpha = -1

%% PASSO 3:
%si applichi la retroazionedegli stati

Ars = A-B*K
Brs = alpha*B
Crs = C-D*K
Drs = alpha*D

%% PASSO 4:
%si simuli l'evolòuzione della risposta dy(t) del sistema retroazionato ad un
%ingresso r(t) = onda quadra di ampzza 0.5 Hz e ampiezza 2VPP si ponga alpha = -1

t=0:.001:4;
r = sign(sin(2*pi*0.5*t));

dx01 = [0;0];
dx02 = [0.01;0];
dx03 = [-0.01;0];

sRetroazionato = ss(Ars,Brs,Crs,Drs);

%simuliamo:

dy1 = lsim(sRetroazionato,r,t,dx01);
dy2 = lsim(sRetroazionato,r,t,dx02);
dy3 = lsim(sRetroazionato,r,t,dx03);

figure, plot(t,r,'k',t,dy1,'b',t,dy2,'r',t,dy3,'g'),grid on,
title(['Risposta \deltay(t) del sistema controllato mediante retroazione', ...
       ' dallo stato al variare di \deltax_0']),
legend('r(t)',' \deltay(t) per \deltax_0^{(1)}', ...
              '  \deltay(t) per \deltax_0^{(2)}','   \deltay(t) per \deltax_0^{(3)}')

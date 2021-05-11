close all
clear all
%% PASSO 0 : Definizione del sistema

s = tf('s');
F = (s+10)/(s^3+45*s^2-250*s)
Kr = 2

%% PASSO 1 : Determinare Kf, singolarit�, fase iniziale e finale del sistema

Kf = dcgain(s*F)
zeri = zero(F)
poli = pole(F)
damp(F)
figure, bode(F), grid on

%% PASSO 2 : Tracciare prima a mano e poi con matlab i dagrammi di bode di Ga
close all

Kc = 1
Ga1 = (Kc/Kr)*F
figure, bode(Ga1), grid on

%% PASSO 3 : Tracciare a mano e poi con matlab il diagramma di nyquist di Ga
close all
figure, nyquist(Ga1)
xlim([-7e-3,0])
ylim([-6e-3,6e-3])

%% PASSO 4 : Studiare la stabilit� del sistema in catena chiusa al variare di Kc
close all
%per il criterio di nyquist:
% nia = 1;
% nic = 2; per 0 < Kc < 642
% nic = 0; oer Kc > 642 -> asintotica stabilit�
% nic = 1; per qualsiasi Kc < 0

%verifico asintotica stabilit� per Kc = 800
Kc = 800
Ga = (Kc/Kr)*F
W = feedback(Kc*F, 1/Kr)
damp(W)

%% PASSO 5 : calcolare l'errore di inseguimento in regime permanente nei diversi casi

We = Kr*feedback(1,Ga)
Wd1 = feedback(F,Kc/Kr)
Wd2 = feedback(1,Ga)

es=menu('scegli il valore dei disturbi e di r(t)',...
        'caso A: r(t)=t, d1(t)=0.1, d2(t)=0.5',...
        'caso B: r(t)=2, d1(t)=0, d2(t)=0.01*t');
switch es,
    case 1,
        % errore intrinseco di inseguimento a r(t) = t pari a Kr/KGa = Kr/(Kc*Kf/Kr)
        % perch� il sistema � di tipo 1
        % effetto del disturbo d1 costante sull'uscita pari a d1/(Kc/Kr) perch� ci sono poli
        % nell'origine solo nel blocco a valle del disturbo
        % effetto del disturbo d2 costante sull'uscita NULLO perch� c'� almeno un
        % polo nell'origine nel blocco a monte del disturbo
        errore_r=dcgain(s*We*1/s^2)
        effetto_d1=dcgain(s*Wd1*0.1/s)
        effetto_d2=dcgain(s*Wd2*0.5/s)
        errore_tot=errore_r-(effetto_d1+effetto_d2)
        open_system('model_1')
        sim('model_1') 
    case 2,
        % errore intrinseco di inseguimento a r(t) = 2 NULLO perch� il sistema � di
        % tipo 1
        % effetto del disturbo d1 NULLO essendo nullo il disturbo
        % effetto del disturbo d2 = alfa_d2*t (rampa) sull'uscita pari ad alfa_d2/KGa = alfa_d2/(Kc*Kf/Kr)
        % perch� il sistema � di tipo 1
        errore_r=dcgain(s*We*2/s)
        effetto_d1=dcgain(s*Wd1*0)
        effetto_d2=dcgain(s*Wd2*0.01/s^2)
        errore_tot=errore_r-(effetto_d1+effetto_d2)
        open_system('model_2')
        sim('model_2')
end





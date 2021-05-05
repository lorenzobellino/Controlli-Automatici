clear all
close all

%% Passo 0 : Definizione del sistema:

s = tf('s');
F = (s^2+11*s+10)/(s^4+4*s^3+8*s^2)

%% Passo 1 : Determinare guadagno stazionario e singolarità 

Kr = 1
Kf = dcgain(s^2*F) %F ha 2 poli nell'origine
%singolarità
zero(F)
pole(F)
damp(F)
% 2 zeri in -10 e -1
% 2 poli in zero e 2 poli complessi coniugati

%% Passo 2: Traccio i diagrammi di Bode di Ga
Kc = 1
Ga = (Kc/Kr)*F
figure, bode(Ga), grid on

%% Passo 3: Traccio il diagramma di Nyquist di Ga 

figure, nyquist(Ga)
%ingrandimento in corrispondenza dell'attraversamento sull'asse reale
w=logspace(0,3,1000);
figure, nyquist(Ga,w)

%% Passo 4: Verifica la stabilità del sistema mediante il criterio di Nyquist
% calcolo i poli a parte reale positiva di Ga = 0
% calcolo N = 0 cioè le rotazioni attorno al punto (-1,0) del diagramma di
% Nyquist --> per essere asintoticamente stabile allora nic = -N cioè nic=0
% implica quindi che W(s) non deve avere poli a parte reale positiva,
% verifichiamo

W = feedback(Kc*F,1/Kr)
damp(W)
% tutti i poli sono a parte reale strettamente minore di zero, ok!

%% Passo 5: Calcolare l'errore di inseguimento in regime permanente nei vari casi:

We = Kr*feedback(1,Ga)
Wd1 = feedback(F,Kc/Kr)
Wd2 = feedback(1,Ga)

es=menu('scegli il valore dei disturbi e di r(t)',...
        'caso A: r(t)=t, d1(t)=0.1, d2(t)=0.5',...
        'caso B: r(t)=2t, d1(t)=0, d2(t)=0.01t',...
        'caso C: r(t)=t^2/2, d1(t)=0, d2(t)=0',...
        'caso D: r(t)=t^2/2, d1(t)=0.1, d2(t)=0.2');
switch es,
    case 1,
        % errore intrinseco di inseguimento a r(t) = t NULLO perché il sistema è di
        % tipo 2
        % effetto del disturbo d1 costante sull'uscita pari a d1/(Kc/Kr) perché ci sono poli
        % nell'origine solo nel blocco a valle del disturbo
        % effetto del disturbo d2 costante sull'uscita NULLO perché c'è almeno un
        % polo nell'origine nel blocco a monte del disturbo
        errore_r=dcgain(s*We*1/s^2)
        effetto_d1=dcgain(s*Wd1*0.1/s)
        effetto_d2=dcgain(s*Wd2*0.5/s)
        errore_tot=errore_r-(effetto_d1+effetto_d2)
        open_system('V1')
        sim('V1')
    case 2,
        % errore intrinseco di inseguimento a r(t) = 2t NULLO perché il sistema è di
        % tipo 2
        % effetto del disturbo d1 NULLO essendo nullo il disturbo
        % effetto del disturbo d2 a rampa sull'uscita NULLO perché il sistema è di
        % tipo 2
        errore_r=dcgain(s*We*2/s^2)
        effetto_d1=dcgain(s*Wd1*0)
        effetto_d2=dcgain(s*Wd2*0.01/s^2)
        errore_tot=errore_r-(effetto_d1+effetto_d2)
        open_system('V2')
        sim('V2')
    case 3,
        % errore intrinseco di inseguimento a r(t) = t^2/2 pari a Kr/KGa (con KGa = Kc*Kf/Kr)
        % perché il sistema è di tipo 2
        % effetto del disturbo d1 NULLO essendo nullo il disturbo
        % effetto del disturbo d2 NULLO essendo nullo il disturbo
        errore_r=dcgain(s*We*1/s^3)
        effetto_d1=dcgain(s*Wd1*0)
        effetto_d2=dcgain(s*Wd2*0)
        errore_tot=errore_r-(effetto_d1+effetto_d2)
        open_system('V3')
        sim('V3')
    case 4,
        % errore intrinseco di inseguimento a r(t) = t^2/2 pari a Kr/KGa (con KGa = Kc*Kf/Kr)
        % perché il sistema è di tipo 2
        % effetto del disturbo d1 costante sull'uscita pari a d1/(Kc/Kr) perché ci sono poli
        % nell'origine solo nel blocco a valle del disturbo
        % effetto del disturbo d2 costante sull'uscita NULLO perché c'è almeno un
        % polo nell'origine nel blocco a monte del disturbo
        errore_r=dcgain(s*We*1/s^3)
        effetto_d1=dcgain(s*Wd1*0.1/s)
        effetto_d2=dcgain(s*Wd2*0.2/s)
        errore_tot=errore_r-(effetto_d1+effetto_d2)
        open_system('V4')
        sim('V4')
end

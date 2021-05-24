close all
clear all

%% Passo 0 : Definizione del sistema e calcolo del guadagno stazionario
s = tf('s');
F=5*(s+20)/(s*(s^2+2.5*s+2)*(s^2+15*s+100));
Kf=dcgain(s*F)
Kr=2;

%% Passo 1 : Analisi delle specifiche
% a) errore di inseguimento a r(t) = t in regime permanente pari al massimo in modulo a 0.05;
% b) effetto del disturbo d(t) = 1 sull’uscita in regime permanente pari al massimo in modulo a 0.02;
% c) tempo di salita della risposta al gradino unitario pari a circa 1 s (la specifica `e ritenuta soddisfatta se l’errore commesso `e inferiore in modulo al 10%);
% d) sovraelongazione massima della risposta al gradino unitario minore (o uguale) a 0.3.

% specifica a) =>
% 1) non richiede inserimento di poli nell'origine (ce n'e' gia' uno in F(s))
% 2) |Kr/KGa| <= 0.05 => |Kc| >= 20*Kr^2/|KF| => |Kc| >= 160

% specifica b) =>
% 1) non richiede inserimento di poli nell'origine (il disturbo è costante)
% 2) |d/(Kc/Kr)|<= 0.02 => |Kr/Kc|<=0.02 => |Kc|>=100
% segno di Kc positivo: il sistema è a stabilità regolare
bode(F)

% specifica c) => ts = 1s => B3 ~=3/ts =3 =>
% wc < B3 < 2*wc => wc ~= 0.63*B3
wcdes=1.9

% specifica d) => s_hat=0.3 => Mr <= 1.44, Mr_dB=3.2dB
% (su Nichols) margine_di_fase >= 40deg => meglio 45deg

%% Passo 2 : Funzione d'anello di partenza e considerazioni iniziali
Kc=160 % minimo valore ammissibile
Ga1=Kc*F/Kr
figure, bode(Ga1)
[m_wc_des,f_wc_des]=bode(Ga1,wcdes)
% In wc_des il modulo vale circa 18.5 dB e la fase -209.8 deg
% Risulta necessario recuperare circa 80 deg prevedendo di dover inserire
% anche una rete attenuatrice per ridurre il modulo.
% Il recupero della fase dovrà essere ottenuto usando due reti derivative.

%% Passo 3 : Costruzione delle reti compensative
% Inserimento di due reti derivative uguali da 6 per recuperare 80deg in w=wc_des,
% progettate sul fronte di salita del recupero di fase in xd = 1.3 per limitare l'aumento di modulo
% ed evitare la successiva necessità di una rete attenuatrice molto forte
m_a=6
xd=1.3
taua=xd/wcdes
Rd=(1+s*taua)/(1+s*taua/m_a)
[m1_wc_des,f1_wc_des]=bode(Rd^2*Ga1,wcdes)
figure, bode(Rd^2*Ga1)

% Inserimento di una rete integrativa con m_i=m1_wc_des ~= 21.5 per avere wc_finale=wc_des
% e progettata in xi=230 per perdere circa 5 gradi di fase in w=wc_des
% (vedere i diagrammi di Bode normalizzati della rete tracciati in Matlab)
mi=21.5
figure,bode((1+s/mi)/(1+s))
xi=230
taui=xi/wcdes
Ri=(1+s*taui/mi)/(1+s*taui)

%% Passo 4 : Verifica dei requisiti di sistema e definizione del controllore

figure, margin(Rd^2*Ri*Ga1)
C=Kc*Rd^2*Ri
Ga=C*F/Kr;

%% Passo 5 :Verifica delle specifiche in catena chiusa

W=feedback(C*F,1/Kr);

% Verifica delle specifiche sulla risposta al gradino t_s e s_hat
% il tempo salita risulta pari a 0.94 s e s_hat pari a 26.3%

figure, step(W), grid on

% Verifica dell'errore di inseguimento alla rampa
% (si ottiene errore = 0.05 in regime permanente)
t=0:0.01:50;
r=t';
y_rampa=lsim(W,r,t);
figure, plot(t,Kr*r,t,y_rampa), title('Inseguimento alla rampa'), grid on
figure, plot(t,Kr*r-y_rampa), title('Errore di inseguimento alla rampa'), grid on

% Verifica dell'effetto del disturbo in regime permanente (pari a 0.0125)
Wd=feedback(F,1/Kr*C)
figure, step(Wd,50)

%% Passo 6 : Valutazione delle prestazioni in catena chiusa

% Attività sul comando:
% confrontare il valore iniziale del grafico con quanto ricavabile dal
% teorema del valore iniziale; si ottiene u(o)=Kc*m_a^2/m_i = 267.9...
Wu=feedback(C,F/Kr);
figure,step(Wu)

% Valutazione banda passante e picco di risonanza
% La divisione per Kr permette di valutare direttamente B3 e Mr
% Confrontare i risultati dai due grafici: Mr=2.3 dB, B3=3.65 rad/s
figure,bode(W)
figure, bode(W/Kr)
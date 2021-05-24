clear all
close all

%% PASSO 0 : DEFINIZIONE DEL SISTEMA
s = tf('s');
F = (13.5*(s+4)*(s+10))/((s+3)^3)
Kr = 1;

% specifiche di progetto:
% a) erroredi inseguimento a r(t)=t a regime uguale in modulo a 0.01
% b) effetto di d(t)=1 sull'uscita pari a 0.02 in modulo
% c) banda passante del sistema retroazionata pari a 6 rad/s (errore
% inferiore al 15% )
% d) picco di risonanza della risposta in frequenza minore o uguale a 2 dB

%% PASSO 1 : STUDIO E PROGETTO DEL SISTEMA

Kc = dcgain(F)

% specifica a) =>
% 1) C(s) con 1 polo nell'origine,
% 2) |Kr/KGa| <= 0.01 => |Kc| >= 100*Kr^2/|KF| => |Kc| >= 5
% quindi la specifica a ï¿½ sempre soddisfatta

% specifica b) e' soddisfatta se C(s) ha 1 polo nell'origine
% segno di Kc positivo: il sistema ï¿½ a stabilitï¿½ regolare
bode(F/s)

% specifica c) => wc < B3 < 2*wc => wc ~= 0.63 * B3
wcdes=3.8

% specifica d) => (su Nichols) margine_di_fase >= 45deg => meglio ~50deg

%% PASSO 2 : FUNZIONE D'ANELLO DI PARTENZA E VALUTAZIONI
Kc=5 % minimo valore ammissibile
Ga1=(Kc/s)*F/Kr
figure, bode(Ga1)
[m_wc_des,f_wc_des]=bode(Ga1,wcdes)

% In wc_des il modulo vale circa 19.3 dB e la fase -180.8 deg
% Risulta necessario recuperare circa 60 deg prevedendo di dover inserire
% anche una rete attenuatrice per ridurre il modulo.
% Il recupero della fase sarï¿½ ottenuto usando due reti derivative.

%% PASSO 3 : PROGETTO RETI DI COMPENSAZIONE

% Inserimento di due reti derivative uguali da 4 per recuperare 60deg in w=wc_des,
% progettate sul fronte di salita del recupero di fase in xd = 1 per limitare l'aumento di modulo
% ed evitare la successiva necessitï¿½ di una rete attenuatrice molto forte

ma=4
xd=1
taua=xd/wcdes
Rd=(1+taua*s)/(1+taua/ma*s)
[m1_wc_des,f1_wc_des]=bode(Rd^2*Ga1,wcdes)
figure, bode(Rd^2*Ga1)

% Inserimento di una rete integrativa con mi=m1_wc_des ~= 17.4 per avere wc_finale=wcdes
% e progettata in xi=150 per perdere meno di 10 gradi di fase in w=wcdes

mi=17.4
figure,bode((1+s/mi)/(1+s))
xi=150
taui=xi/wcdes
Ri=(1+taui/mi*s)/(1+taui*s)

%% PASSO 4 : VERIFICA DEL RAGGIUNGIMENTO DELLE SPECIFICHE

figure, margin(Rd^2*Ri*Ga1)
C=Kc/s*Rd^2*Ri
Ga=C*F/Kr;

% Verifica della banda passante e del picco di risonanza
% (si ottiene wB = 5.7 rad/s, Mr = 1.7 dB <2 dB)

W=feedback(C*F,1/Kr);
figure, bode(W)

%% PASSO 5 : VALUTARE LA FUNZIONE IN CATENA CHIUSA
% a) valutare la sovraelungazione massima
% b) valutare il tempo di salita
% c) valuta errore di inseguimento massimo in regime permanente a r(t)=sin(0.1*t)
% d) valuta lï¿½attenuazione con la quale vengono riportati in uscita disturbi sinusoidali entranti insieme
%al riferimento r(t) ed aventi pulsazione maggiore o uguale a 100 rad/s.

% sovraelungazione e tempo di salita
fugure, step(W)

% Verifica dell'errore di inseguimento alla rampa
% (si ottiene errore = 0.01 in regime permanente)
t=0:0.01:20;
r=t';
y_rampa=lsim(W,r,t);
figure, plot(t,r,t,y_rampa), title('Inseguimento alla rampa'), grid on
figure, plot(t,Kr*r-y_rampa), title('Errore di inseguimento alla rampa'), grid on

% Verifica dell'effetto (nullo) del disturbo (astaticità)
Wd=feedback(F,1/Kr*C);
figure, step(Wd,20)

% Calcolo dell'errore di inseguimento in regime permanente
% a riferimento sinusoidale sin(0.1*t)
w_r=0.1;
Sens=feedback(1,Ga);
errore_sin=bode(Sens,w_r)*Kr

% Verifica dell'errore di inseguimento in regime permanente
% a riferimento sinusoidale sin(0.1*t)
t=0:0.01:200;
r=sin(w_r*t)';
y=lsim(W,r,t);
figure, plot(t,r,t,y,'--'), title('Inseguimento ad un riferimento sinusoidale'), grid on
figure, plot(t,Kr*r-y), title('Errore di inseguimento ad un riferimento sinusoidale'), grid on

% Attenuazione di disturbi sinusoidali entranti sul riferimento,
% aventi pulsazione=100rad/s
w_disturbi_r=100;
attenuazione_disturbi_r=bode(W,w_disturbi_r)

% Verifica dell'attenuazione di disturbi sinusoidali entranti insieme
% al riferimento a gradino unitario, nel caso che tali disturbi abbiano
% ampiezza=0.1, pulsazione=100rad/s
% Nel grafico: in rosso la rispotsa del sistema, in verde il riferimento a
% soggetto al disturbo
t=0:0.001:20;
r_disturbato=ones(size(t))+0.1*sin(w_disturbi_r*t);
y_r_disturbato=lsim(W,r_disturbato,t);
figure, plot(t,r_disturbato,'g',t,y_r_disturbato,'r'), grid on,
title('Inseguimento di un riferimento a gradino con disturbo sinusoidale sovrapposto')

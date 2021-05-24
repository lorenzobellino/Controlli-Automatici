# LABORATORIO 7 ESERCIZIO 1: Progetto di Controllori analogici mediante sintesi per tentativi

## Passo 0 : Definizione del sistema

```Matlab
s = tf('s');
F = (13.5*(s+4)*(s+10))/((s+3)^3)
Kr = 1
```
![alt text](https://github.com/lorenzobellino/Controlli-Automatici/blob/master/Laboratori/LAB07/img/e1passo0.JPG)

### Specifiche di progetto :
1. erroredi inseguimento a r(t)=t a regime uguale in modulo a 0.01
2. effetto di d(t)=1 sull'uscita pari a 0.02 in modulo
3. banda passante del sistema retroazionata pari a 6 rad/s (errore
% inferiore al 15% )
4. picco di risonanza della risposta in frequenza minore o uguale a 2 dB

## Passo 1 : Studio e Progetto del sistema
### specifica 1:

```Matlab
% specifica a) =>
% 1) C(s) con 1 polo nell'origine,
% 2) |Kr/KGa| <= 0.01 => |Kc| >= 100*Kr^2/|KF| => |Kc| >= 5
% quindi la specifica a è sempre soddisfatta
Kc = dcgain(F)
```
![alt text](https://github.com/lorenzobellino/Controlli-Automatici/blob/master/Laboratori/LAB07/img/e1specificaA.JPG)

### Specifica 2:
```Matlab
% specifica b) e' soddisfatta se C(s) ha 1 polo nell'origine
% segno di Kc positivo: il sistema � a stabilit� regolare
bode(F/s)
```
![alt text](https://github.com/lorenzobellino/Controlli-Automatici/blob/master/Laboratori/LAB07/img/e1specificaB.JPG)

### Specifica 3:
```Matlab
% specifica c) => wc < B3 < 2*wc => wc ~= 0.63 * B3
wcdes=3.8
```
### Specifica 4:
```Matlab
% specifica d) => (su Nichols) margine_di_fase >= 45deg => meglio ~50deg
```

## Passo 2 : Funzione d'anello di partenza e velutazioni

```Matlab
Kc=5 % minimo valore ammissibile
Ga1=(Kc/s)*F/Kr
figure, bode(Ga1)
[m_wc_des,f_wc_des]=bode(Ga1,wcdes)

% In wc_des il modulo vale circa 19.3 dB e la fase -180.8 deg
% Risulta necessario recuperare circa 60 deg prevedendo di dover inserire
% anche una rete attenuatrice per ridurre il modulo.
% Il recupero della fase sarà ottenuto usando due reti derivative.
```
![alt text](https://github.com/lorenzobellino/Controlli-Automatici/blob/master/Laboratori/LAB07/img/e1passo2.JPG)
![alt text](https://github.com/lorenzobellino/Controlli-Automatici/blob/master/Laboratori/LAB07/img/e1passo2bode.JPG)

## Passo 3 : Progetto delle reti di compensazione
### Inserimento di due reti derivative per il recupero di fase
```Matlab
% Inserimento di due reti derivative uguali da 4 per recuperare 60deg in w=wcdes,
% progettate sul fronte di salita del recupero di fase in xd = 1 per limitare l'aumento di modulo
% ed evitare la successiva necessità di una rete attenuatrice molto forte

ma=4
xd=1
taua=xd/wcdes
Rd=(1+taua*s)/(1+taua/ma*s)
[m1_wc_des,f1_wc_des]=bode(Rd^2*Ga1,wcdes)
figure, bode(Rd^2*Ga1)
```
![alt text](https://github.com/lorenzobellino/Controlli-Automatici/blob/master/Laboratori/LAB07/img/e1passo3.JPG)
![alt text](https://github.com/lorenzobellino/Controlli-Automatici/blob/master/Laboratori/LAB07/img/e1passo3bode.JPG)

### Inserimento di una rete integrativa per far diminuire il modulo
```Matlab
% Inserimento di una rete integrativa con mi=m1_wc_des ~= 17.4 per avere wc_finale=wcdes
% e progettata in xi=150 per perdere meno di 10 gradi di fase in w=wcdes

mi=17.4
figure,bode((1+s/mi)/(1+s))
xi=150
taui=xi/wcdes
Ri=(1+taui/mi*s)/(1+taui*s)
```
![alt text](https://github.com/lorenzobellino/Controlli-Automatici/blob/master/Laboratori/LAB07/img/e1passo32.JPG)
![alt text](https://github.com/lorenzobellino/Controlli-Automatici/blob/master/Laboratori/LAB07/img/e1passo32bode.JPG)

## Passo 4 : Verifica del raggiungimento delle specifiche
```Matlab
figure, margin(Rd^2*Ri*Ga1)
C=Kc/s*Rd^2*Ri
Ga=C*F/Kr;

% Verifica della banda passante e del picco di risonanza
% (si ottiene wB = 5.7 rad/s, Mr = 1.7 dB <2 dB)

W=feedback(C*F,1/Kr);
figure, bode(W)
```
![alt text](https://github.com/lorenzobellino/Controlli-Automatici/blob/master/Laboratori/LAB07/img/e1passo4margin.JPG)
![alt text](https://github.com/lorenzobellino/Controlli-Automatici/blob/master/Laboratori/LAB07/img/e1passo4bode.JPG)

## Passo 5 : Valutare la funzione in catena chiusa
### elementi da osservare
1. valutare la sovraelungazione massima
2. valutare il tempo di salita
3. valuta errore di inseguimento massimo in regime permanente a r(t)=sin(0.1*t)
4. valuta l'attenuazione con la quale vengono riportati in uscita disturbi sinusoidali entranti insieme al riferimento r(t) ed aventi pulsazione maggiore o uguale a 100 rad/s.

### Sovraelungazione massima
```Matlab
step(W)
```
![alt text](https://github.com/lorenzobellino/Controlli-Automatici/blob/master/Laboratori/LAB07/img/e1passo5rise.JPG)
![alt text](https://github.com/lorenzobellino/Controlli-Automatici/blob/master/Laboratori/LAB07/img/e1passo5sovrael.JPG)

### Errore di inseguimento alla rampa
```Matlab

% Verifica dell'errore di inseguimento alla rampa
% (si ottiene errore = 0.01 in regime permanente)
t=0:0.01:20;
r=t';
y_rampa=lsim(W,r,t);
figure, plot(t,r,t,y_rampa), title('Inseguimento alla rampa'), grid on
figure, plot(t,Kr*r-y_rampa), title('Errore di inseguimento alla rampa'), grid on
```
![alt text](https://github.com/lorenzobellino/Controlli-Automatici/blob/master/Laboratori/LAB07/img/e1passo5inseguimento.JPG)
![alt text](https://github.com/lorenzobellino/Controlli-Automatici/blob/master/Laboratori/LAB07/img/e1passo5errorerampa.JPG)

### Effetto nullo disturbo
```Matlab
% Verifica dell'effetto (nullo) del disturbo (astaticit�)
Wd=feedback(F,1/Kr*C);
figure, step(Wd,20)
```
![alt text](https://github.com/lorenzobellino/Controlli-Automatici/blob/master/Laboratori/LAB07/img/e1passo5errorenullo.JPG)

### Calcolo errore di inseguimento in regime permanente a sin(0.1*t)
```Matlab
% Calcolo dell'errore di inseguimento in regime permanente
% a riferimento sinusoidale sin(0.1*t)
w_r=0.1;
Sens=feedback(1,Ga);
errore_sin=bode(Sens,w_r)*Kr
```
![alt text](https://github.com/lorenzobellino/Controlli-Automatici/blob/master/Laboratori/LAB07/img/e1passo5erroresin.JPG)

### Verifica inseguimento errore sinusoidale
```Matlab
t=0:0.01:200;
r=sin(w_r*t)';
y=lsim(W,r,t);
figure, plot(t,r,t,y,'--'), title('Inseguimento ad un riferimento sinusoidale'), grid on
figure, plot(t,Kr*r-y), title('Errore di inseguimento ad un riferimento sinusoidale'), grid on
```

![alt text](https://github.com/lorenzobellino/Controlli-Automatici/blob/master/Laboratori/LAB07/img/e1passo5inseguimentosinusoidale.JPG)
![alt text](https://github.com/lorenzobellino/Controlli-Automatici/blob/master/Laboratori/LAB07/img/e1passo5erroreinssin.JPG)

### Attenuazione disturbi sunusoidale
```Matlab
w_disturbi_r=100;
attenuazione_disturbi_r=bode(W,w_disturbi_r)
```
![alt text](https://github.com/lorenzobellino/Controlli-Automatici/blob/master/Laboratori/LAB07/img/e1passo5attenuazionesin.JPG)

### Verifica attenuazione disturbi sinusoidali
```Matlab
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
```
![alt text](https://github.com/lorenzobellino/Controlli-Automatici/blob/master/Laboratori/LAB07/img/e1passo5verifica.JPG)

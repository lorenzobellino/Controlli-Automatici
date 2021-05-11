# LABORATORIO 6 : Analisi della stabilità al variare del guadagno e del comportamento in regime permanente di sistemi retroazionati

## Passo 0 : Definizione del sistema

```Matlab
s=tf('s');
F=(s-1)/((s+0.2)*(s^3+2.5*s^2+4*s))
Kr = 0.5
```
![alt text](https://github.com/lorenzobellino/Controlli-Automatici/blob/master/Laboratori/LAB06/img/e2passo0.JPG)

## Passo 1 : Determinare Kf, singolarità, fase iniziale e finale del sistema

```Matlab
Kf = dcgain(s*F)
zeri = zero(F)
poli = pole(F)
damp(F)
figure, bode(F), grid on
```
![alt text](https://github.com/lorenzobellino/Controlli-Automatici/blob/master/Laboratori/LAB06/img/e2passo1.JPG)
![alt text](https://github.com/lorenzobellino/Controlli-Automatici/blob/master/Laboratori/LAB06/img/e2passo1-bode.JPG)

## PASSO 2 : Tracciare prima a mano e poi con matlab i dagrammi di bode di Ga
```Matlab
Kc = 1
Ga1 = (Kc/Kr)*F
figure, bode(Ga1), grid on
```
![alt text](https://github.com/lorenzobellino/Controlli-Automatici/blob/master/Laboratori/LAB06/img/e2passo2.JPG)

## PASSO 3 : Tracciare a mano e poi con matlab il diagramma di nyquist di Ga
```Matlab
figure, nyquist(Ga1)
w=logspace(-1,3,5000);
figure,nyquist(Ga1,w)
```
![alt text](https://github.com/lorenzobellino/Controlli-Automatici/blob/master/Laboratori/LAB06/img/e2passo3.JPG)
![alt text](https://github.com/lorenzobellino/Controlli-Automatici/blob/master/Laboratori/LAB06/img/e2passo3-size.JPG)

## PASSO 4 : Studiare la stabilità del sistema in catena chiusa al variare di Kc
```Matlab
% Dallo studio della stabilità in catena chiusa con il criterio di Nyquist:
% n_ia = 0
% n_ic = 1 per 0 < Kc < 9.17
% n_ic = 3 per Kc > 9.17
% n_ic = 0 (asintotica stabilità) per -0.25 < Kc < 0
% n_ic = 2 per Kc < -0.25
Kc=-0.1
Ga=Kc*F/Kr;
W=feedback(Kc*F,1/Kr)
damp(W)
```
![alt text](https://github.com/lorenzobellino/Controlli-Automatici/blob/master/Laboratori/LAB06/img/e2passo4.JPG)

## PASSO 5 : calcolare l'errore di inseguimento in regime permanente nei diversi casi

```Matlab
We = Kr*feedback(1,Ga)
Wd1 = feedback(F,Kc/Kr)
Wd2 = feedback(1,Ga)
```
![alt text](https://github.com/lorenzobellino/Controlli-Automatici/blob/master/Laboratori/LAB06/img/e2passo5-0.JPG)

### CASO A: r(t)=t, d1(t)=0.1, d2(t)=0.5
![alt text](https://github.com/lorenzobellino/Controlli-Automatici/blob/master/Laboratori/LAB06/img/e2model1.JPG)
```Matlab
% errore intrinseco di inseguimento a r(t) = t pari a Kr/KGa = Kr/(Kc*Kf/Kr)
% perché il sistema è di tipo 1
% effetto del disturbo d1 costante sull'uscita pari a d1/(Kc/Kr) perché ci sono poli
% nell'origine solo nel blocco a valle del disturbo
% effetto del disturbo d2 costante sull'uscita NULLO perché c'è almeno un
% polo nell'origine nel blocco a monte del disturbo
errore_r=dcgain(s*We*1/s^2)
effetto_d1=dcgain(s*Wd1*0.1/s)
effetto_d2=dcgain(s*Wd2*0.5/s)
errore_tot=errore_r-(effetto_d1+effetto_d2)
open_system('model_1')
sim('model_1')
```
![alt text](https://github.com/lorenzobellino/Controlli-Automatici/blob/master/Laboratori/LAB06/img/e2passo5-caso1-scope.JPG)
![alt text](https://github.com/lorenzobellino/Controlli-Automatici/blob/master/Laboratori/LAB06/img/e2passo5-caso1.JPG)

### CASO B: r(t)=2, d1(t)=0.1, d2(t)=0.01*t
![alt text](https://github.com/lorenzobellino/Controlli-Automatici/blob/master/Laboratori/LAB06/img/e2model2.JPG)
```Matlab
% errore intrinseco di inseguimento a r(t) = 2 NULLO perché il sistema è di
% tipo 1
% effetto del disturbo d1 costante sull'uscita pari a d1/(Kc/Kr) perché ci sono poli
% nell'origine solo nel blocco a valle del disturbo
% effetto del disturbo d2 = alfa_d2*t (rampa) sull'uscita pari ad alfa_d2/KGa = alfa_d2/(Kc*Kf/Kr)
% perché il sistema è di tipo 1
errore_r=dcgain(s*We*2/s)
effetto_d1=dcgain(s*Wd1*0.1/s)
effetto_d2=dcgain(s*Wd2*0.01/s^2)
errore_tot=errore_r-(effetto_d1+effetto_d2)
open_system('model_2')
sim('model_2')
```
![alt text](https://github.com/lorenzobellino/Controlli-Automatici/blob/master/Laboratori/LAB06/img/e2passo5-caso2-scope.JPG)
![alt text](https://github.com/lorenzobellino/Controlli-Automatici/blob/master/Laboratori/LAB06/img/e2passo5-caso2.JPG)

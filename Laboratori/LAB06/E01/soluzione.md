# LABORATORIO 6 : Analisi della stabilità al variare del guadagno e del comportamento in regime permanente di sistemi retroazionati

## Passo 0 : Definizione del sistema

```Matlab
s = tf('s');
F = (s+10)/(s^3+45*s^2-250*s)
Kr = 2
```
![alt text](https://github.com/lorenzobellino/Controlli-Automatici/blob/master/Laboratori/LAB06/img/e1passo0.JPG)

## Passo 1 : Determinare Kf, singolarità, fase iniziale e finale del sistema

```Matlab
Kf = dcgain(s*F)
zeri = zero(F)
poli = pole(F)
damp(F)
figure, bode(F), grid on
```
![alt text](https://github.com/lorenzobellino/Controlli-Automatici/blob/master/Laboratori/LAB06/img/e1passo1.JPG)
![alt text](https://github.com/lorenzobellino/Controlli-Automatici/blob/master/Laboratori/LAB06/img/e1passo1-bode.JPG)

## PASSO 2 : Tracciare prima a mano e poi con matlab i dagrammi di bode di Ga
```Matlab
close all
Kc = 1
Ga1 = (Kc/Kr)*F
figure, bode(Ga1), grid on
```
![alt text](https://github.com/lorenzobellino/Controlli-Automatici/blob/master/Laboratori/LAB06/img/e1passo2.JPG)

## PASSO 3 : Tracciare a mano e poi con matlab il diagramma di nyquist di Ga
```Matlab
close all
figure, nyquist(Ga1)
xlim([-7e-3,0])
ylim([-6e-3,6e-3])
```
![alt text](https://github.com/lorenzobellino/Controlli-Automatici/blob/master/Laboratori/LAB06/img/e1passo3-nosize.JPG)
![alt text](https://github.com/lorenzobellino/Controlli-Automatici/blob/master/Laboratori/LAB06/img/e1passo3-size.JPG)

## PASSO 4 : Studiare la stabilità del sistema in catena chiusa al variare di Kc
```Matlab
close all
%per il criterio di nyquist:
% nia = 1;
% nic = 2; per 0 < Kc < 642
% nic = 0; oer Kc > 642 -> asintotica stabilità
% nic = 1; per qualsiasi Kc < 0

%verifico asintotica stabilità per Kc = 800
Kc = 800
Ga = (Kc/Kr)*F
W = feedback(Kc*F, 1/Kr)
damp(W)
```
![alt text](https://github.com/lorenzobellino/Controlli-Automatici/blob/master/Laboratori/LAB06/img/e1passo4.JPG)

## PASSO 5 : calcolare l'errore di inseguimento in regime permanente nei diversi casi

```Matlab
We = Kr*feedback(1,Ga)
Wd1 = feedback(F,Kc/Kr)
Wd2 = feedback(1,Ga)
```
![alt text](https://github.com/lorenzobellino/Controlli-Automatici/blob/master/Laboratori/LAB06/img/e1passo5-0.JPG)

### CASO A: r(t)=t, d1(t)=0.1, d2(t)=0.5
![alt text](https://github.com/lorenzobellino/Controlli-Automatici/blob/master/Laboratori/LAB06/img/e1model1.JPG)
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
![alt text](https://github.com/lorenzobellino/Controlli-Automatici/blob/master/Laboratori/LAB06/img/e1passo5-caso1-scope.JPG)
![alt text](https://github.com/lorenzobellino/Controlli-Automatici/blob/master/Laboratori/LAB06/img/e1passo5-caso1.JPG)

### CASO B: r(t)=2, d1(t)=0, d2(t)=0.01*t
![alt text](https://github.com/lorenzobellino/Controlli-Automatici/blob/master/Laboratori/LAB06/img/e1model2.JPG)
```Matlab
% errore intrinseco di inseguimento a r(t) = 2 NULLO perché il sistema è di
% tipo 1
% effetto del disturbo d1 NULLO essendo nullo il disturbo
% effetto del disturbo d2 = alfa_d2*t (rampa) sull'uscita pari ad alfa_d2/KGa = alfa_d2/(Kc*Kf/Kr)
% perché il sistema è di tipo 1
errore_r=dcgain(s*We*2/s)
effetto_d1=dcgain(s*Wd1*0)
effetto_d2=dcgain(s*Wd2*0.01/s^2)
errore_tot=errore_r-(effetto_d1+effetto_d2)
open_system('model_2')
sim('model_2')
```
![alt text](https://github.com/lorenzobellino/Controlli-Automatici/blob/master/Laboratori/LAB06/img/e1passo5-caso2-scope.JPG)
![alt text](https://github.com/lorenzobellino/Controlli-Automatici/blob/master/Laboratori/LAB06/img/e1passo5-caso2.JPG)

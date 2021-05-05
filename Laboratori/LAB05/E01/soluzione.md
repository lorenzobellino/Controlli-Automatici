# LABORATORIO 5 : Analisi della stabilità e del comportamento in regime permanente di un sistema retroazionato

## Passo 0 : Definizione del sistema

```Matlab
s = tf('s');
F = (s^2+11*s+10)/(s^4+4*s^3+8*s^2)
```
![alt text](https://github.com/lorenzobellino/Controlli-Automatici/blob/master/Laboratori/LAB05/img/passo0.JPG)

## Passo 1 : Determinare il guadagno stazionario e singolarità
```Matlab
Kr = 1
Kf = dcgain(s^2*F) %F ha 2 poli nell'origine
%singolarità
zero(F)
pole(F)
damp(F)
% 2 zeri in -10 e -1
% 2 poli in zero e 2 poli complessi coniugati
```
![alt text](https://github.com/lorenzobellino/Controlli-Automatici/blob/master/Laboratori/LAB05/img/passo1.JPG)

## Passo 2 : Tracciare i diagrammi di Bode di Ga
```Matlab
Kc = 1
Ga = (Kc/Kr)*F
figure, bode(Ga), grid on
```
![alt text](https://github.com/lorenzobellino/Controlli-Automatici/blob/master/Laboratori/LAB05/img/Ga_passo2.JPG)
![alt text](https://github.com/lorenzobellino/Controlli-Automatici/blob/master/Laboratori/LAB05/img/passo2.JPG)

## Passo 3 : Tracciare i diagrammi di Nyquist
```Matlab
figure, nyquist(Ga)
%ingrandimento in corrispondenza dell'attraversamento sull'asse reale
w=logspace(0,3,1000);
figure, nyquist(Ga,w)
```
![alt text](https://github.com/lorenzobellino/Controlli-Automatici/blob/master/Laboratori/LAB05/img/passo3.JPG)
![alt text](https://github.com/lorenzobellino/Controlli-Automatici/blob/master/Laboratori/LAB05/img/passo3_ingrandito.JPG)

## Passo 4 : Verifica della stabilità del sistema mediante il criterio di Nyquist
```Matlab
% calcolo i poli a parte reale positiva di Ga = 0
% calcolo N = 0 cioè le rotazioni attorno al punto (-1,0) del diagramma di
% Nyquist --> per essere asintoticamente stabile allora nic = -N cioè nic=0
% implica quindi che W(s) non deve avere poli a parte reale positiva,
% verifichiamo

W = feedback(Kc*F,1/Kr)
damp(W)
% tutti i poli sono a parte reale strettamente minore di zero, ok!
```
![alt text](https://github.com/lorenzobellino/Controlli-Automatici/blob/master/Laboratori/LAB05/img/passo4.JPG)

## Passo 5 : Calcolare l'errore in regime permanente nei diversi casi
### We, Wd1, Wd2
```Matlab
We = Kr*feedback(1,Ga)
Wd1 = feedback(F,Kc/Kr)
Wd2 = feedback(1,Ga)
```
![alt text](https://github.com/lorenzobellino/Controlli-Automatici/blob/master/Laboratori/LAB05/img/passo4.JPG)
### Caso 1: r(t)=t, d1(t)=0.1, d2(t)=0.5
```Matlab
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
```
![alt text](https://github.com/lorenzobellino/Controlli-Automatici/blob/master/Laboratori/LAB05/img/V1.JPG)
![alt text](https://github.com/lorenzobellino/Controlli-Automatici/blob/master/Laboratori/LAB05/img/scopeV1.JPG)
![alt text](https://github.com/lorenzobellino/Controlli-Automatici/blob/master/Laboratori/LAB05/img/caso1.JPG)
### Caso 2: r(t)=2t, d1(t)=0, d2(t)=0.01t
```Matlab
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
```
![alt text](https://github.com/lorenzobellino/Controlli-Automatici/blob/master/Laboratori/LAB05/img/V2.JPG)
![alt text](https://github.com/lorenzobellino/Controlli-Automatici/blob/master/Laboratori/LAB05/img/scopeV2.JPG)
![alt text](https://github.com/lorenzobellino/Controlli-Automatici/blob/master/Laboratori/LAB05/img/caso2.JPG)
### Caso 3: r(t)=t^2/2, d1(t)=0, d2(t)=0
```Matlab
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
```
![alt text](https://github.com/lorenzobellino/Controlli-Automatici/blob/master/Laboratori/LAB05/img/V3.JPG)
![alt text](https://github.com/lorenzobellino/Controlli-Automatici/blob/master/Laboratori/LAB05/img/scopeV3.JPG)
![alt text](https://github.com/lorenzobellino/Controlli-Automatici/blob/master/Laboratori/LAB05/img/caso3.JPG)
### Caso 4: r(t)=t^2/2, d1(t)=0.1, d2(t)=0.2
```Matlab
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
```
![alt text](https://github.com/lorenzobellino/Controlli-Automatici/blob/master/Laboratori/LAB05/img/V4.JPG)
![alt text](https://github.com/lorenzobellino/Controlli-Automatici/blob/master/Laboratori/LAB05/img/scopeV4.JPG)
![alt text](https://github.com/lorenzobellino/Controlli-Automatici/blob/master/Laboratori/LAB05/img/caso4.JPG)

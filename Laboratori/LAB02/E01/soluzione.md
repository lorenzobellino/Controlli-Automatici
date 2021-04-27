# LABORATORIO 2 : Risposta di sistemi del primo ordine a ingressi canonici
## Passo 0 : definizione del sistema

```Matlab
close all
clear all

s = tf('s')

%% RISPOSTA DI SISTEMI DEL I ORDINE AD INGRESSI CANONICI

G1 = 10/(s-5)
G2 = 10/s
G3 = 10/(s+5)
G4 = 10/(s+20)

```
## Passo 1 : Tracciarne i grafici delle risposte all'impulso

```Matlab
%tracciarne i grafici delle risposte all'impulso unitario
%ltiview('impulse',G1,G2,G3,G4)
figure, impulse(G1,'r'), grid on
figure, impulse(G2,'b'), grid on
figure, impulse(G3,'g'), grid on
figure, impulse(G4,'y'), grid on

```
## Passo 1.2 : Ricavare le costanti di tempo e i valori finali, prima graficamente e poi confrontarli con i risultati predetti dalla teoria

```Matlab
%per ricavare le costanti di tempo per via grafica:
%dove possibile basta tracciare una tangente al grafico in t=0
%e andare a vedere l'ntersezione con l'asse temporale

%per G1:
%il polo e reale positivo => non possiamo ricavarlo graficamente in questo
%modo
p1 = 5
tau1 = inf
%per G2:
%il polo vale zero e quindi anche in questo caso non possiamo ricavarlo
%graficamente
p2 = 0
tau2 = inf
%per G��3:
%p = -5 => tau3 = -1/p = 0.2 => che � esattamente quanto possiamo trovare
%graficamente
p3 = -5
tau3 = -1/p3
%per G4:
%p = -20 => tau4 = -1/p = 0.05 => che � esattamente quanto possiamo
%ricavare graficamente
p4 = -20
tau4 = -1/p4

%Ricavare i valori finali delle risposte per via grafica e confrontarli con
%quelli predetti dal teorema del valore finale
close all
figure, impulse(G1,'r'), grid on
figure, impulse(G2,'b'), grid on
figure, impulse(G3,'g'), grid on
figure, impulse(G4,'y'), grid on

%graficamente troviamo che il valore finale di y �:
%G1 -> inf
%G2 -> 10
%G3 -> 0
%G4 -> 0

%per il teorema del valore finale sappiamo che:
%lim(t->inf){y(t)} = lim(s->0){s*Y(s)}
%ma abbiamo delle condizioni da imporre, cio� che entrambi i limiti
%esistano e siano finiti. Oltre al fatto che Y(s) abbia tutti i poli con
%parte reale negativa
%possiamo quindi applicare il teorema solo a G3 e G4 e troviamo che i
%valori combaciano con quelli trovati graficamente
```
### G1
![alt text](https://github.com/lorenzobellino/Controlli-Automatici/blob/master/Laboratori/LAB02/img/e1p1-1.JPG)
### G2
![alt text](https://github.com/lorenzobellino/Controlli-Automatici/blob/master/Laboratori/LAB02/img/e1p1-2.JPG)
### G3
![alt text](https://github.com/lorenzobellino/Controlli-Automatici/blob/master/Laboratori/LAB02/img/e1p1-3.JPG)
### G4
![alt text](https://github.com/lorenzobellino/Controlli-Automatici/blob/master/Laboratori/LAB02/img/e1p1-4.JPG)

## Passo 2 : Tracciarne i grafici delle risposte al gradino unitario

```Matlab
%tracciarne i grafici delle risposte all'impulso unitario
%ltiview('impulse',G1,G2,G3,G4)
figure, impulse(G1,'r'), grid on
figure, impulse(G2,'b'), grid on
figure, impulse(G3,'g'), grid on
figure, impulse(G4,'y'), grid on

```
## Passo 2.2 : Ricavare le costanti di tempo e i valori finali, prima graficamente e poi confrontarli con i risultati predetti dalla teoria, ricavare inoltre i valori dei tempi di salita

```Matlab

%per ricavare le costanti di tempo per via grafica:
%dove possibile basta tracciare una tangente al grafico in t=0
%e andare a vedere l'ntersezione con la tangente alla risposta finale

%per G1:
%il polo e reale positivo => non possiamo ricavarlo graficamente in questo
%modo
p1 = 5
tau1 = inf
%per G2:
%il polo vale zero e quindi anche in questo caso non possiamo ricavarlo
%graficamente (infatti il sistema non � BIBO stabile)
p2 = 0
tau2 = inf
%per G��3:
%p = -5 => tau3 = -1/p = 0.2 => che � esattamente quanto possiamo trovare
%graficamente (infatti il sistema non � BIBO stabile)
p3 = -5
tau3 = -1/p3
%per G4:
%p = -20 => tau4 = -1/p = 0.05 => che � esattamente quanto possiamo
%ricavare graficamente
p4 = -20
tau4 = -1/p4

%per il teorema del valore finale sappiamo che:
%lim(t->inf){y(t)} = lim(s->0){s*Y(s)u/s}
%ma abbiamo delle condizioni da imporre, cio� che entrambi i limiti
%esistano e siano finiti. Oltre al fatto che Y(s) abbia tutti i poli con
%parte reale negativa
%possiamo quindi applicare il teorema solo a G3 e G4 e troviamo che i
%valori combaciano con quelli trovati graficamente

%graficamente troviamo che il valore finale di y è:
%G1 -> inf (diverge perchè il sistema non è BIBO stabile)
%G2 -> inf (diverge perchè il sistema non è BIBO stabile)
%G3 -> 0
%G4 -> 0

%inoltre notare come all'istante t = tau (t=2tau, t=3tau, ...)
%la risposta ha raggiunto cira il 63%, 86% e 95%

%determinare per via grafica i tempi di salita (10%-90%) della risposta
close all
figure, step(G1,'r'), grid on
figure, step(G2,'b'), grid on
figure, step(G3,'g'), grid on
figure, step(G4,'y'), grid on
%possiamo farci aiutare da matlab nei grafici selezionare col tasto destro
%rising time (Notare che questa operazione ha sendo solamente nei sistemi
%G3 e G4 poichè gli altri due non sono BIBO stabili

```
### G1
![alt text](https://github.com/lorenzobellino/Controlli-Automatici/blob/master/Laboratori/LAB02/img/e1p2-1.JPG)
### G2
![alt text](https://github.com/lorenzobellino/Controlli-Automatici/blob/master/Laboratori/LAB02/img/e1p2-2.JPG)
### G3
![alt text](https://github.com/lorenzobellino/Controlli-Automatici/blob/master/Laboratori/LAB02/img/e1p2-3.JPG)
### G4
![alt text](https://github.com/lorenzobellino/Controlli-Automatici/blob/master/Laboratori/LAB02/img/e1p2-4.JPG)

# LABORATORIO 2 : SIMULAZIONE DELLA RISPOSTA DI UN SISTEMA MECCANICO
## Passo 1 : Simulare il comportamento del sistema nei diversi casi
```Matlab
clear all;
close all;
%u = [F]  x=[x1,x2]T = [v,pa]T  y=[v]

es=menu('simulazione della risposta del sistema',...
        'caso A: beta=0.1 Ns/m, K=2N/m, x(t=0)=[0,0], F(t)=1',...
        'caso B: beta=0.01 Ns/m, K=2N/m, x(t=0)=[0,0], F(t)=1',...
        'caso C: beta=10 Ns/m, K=20N/m, x(t=0)=[0,0], F(t)=1',...
        'caso D: beta=0.1 Ns/m, K=2N/m, x(t=0)=[0,0.2], F(t)=1');
switch es,
    case 1, beta=0.1; k=2; x0=[0;0]; w0=0;
    case 2, beta=0.01; k=2; x0=[0;0]; w0=0;
    case 3, beta=10; k=20; x0=[0;0]; w0=0;
    case 4, beta=0.1; k=2; x0=[0;0.2]; w0=0;
end
es=menu('selezionare ingresso',...
        'caso 1: ingresso unitario i0=1 A, w0 = 0 rad/s',...
        'caso 2: ingresso sinusoidale i0=1 A, w0 = 4 rad/s');
switch es,
    case 1, i0 = 1; w0 = 0;
    case 2, i0 = 1; w0 = 4;
end

%parametri globali per tutti gli esercizi
M=0.2;
F0=1;
tmax = 20;

%costruzione delle matrici A,B,C,D
A = [0,-k/M;1,-k/beta];
B = [1/M;0];
C = [1,0];
D = 0;

SYS = ss(A,B,C,D);

%calcolo numerico dell'evouluzione degli stati

t=0:0.1:tmax;
u = F0*cos(w0*t);

[Y,T,X] = lsim(SYS,u,t,x0);

```

## Passo 1.2 : tracciare i grafici dell'evooluzione degli stati e dell'uscita

```Matlab
%plottiamo l'evoluzione del sistema

figure(1),plot(T,X(:,1)),grid on, zoom on, title('evoluzione X1'),
xlabel('tempo'),ylabel('velocita')
figure(2),plot(T,X(:,2)),grid on, zoom on, title('evoluzione X2'),
xlabel('tempo'),ylabel('posizione')
figure(3),plot(T,Y),grid on, zoom on, title('evoluzione Y'),
xlabel('tempo'),ylabel('velocita')
```

## Passo 2 : Calcolo analitico di risposte nel tempo di sistemi dinamici mediante la trasformata di Laplace

```Matlab
%PARTE #3
%si calcolino analiticamente per condizioni iniziali nille, le risposte dei
%sistemi dinamici precedenti considerati ai seguenti ingressi:
% u(t) = u0 * eps(t) ==> gradino di ampiezza u0
% u(t) = t * eps(t) ==> rampa unitaria
% u(t) = u0 * cos(4t) * eps(t) ==> coseno di ampiezza u0 e di pulsazione 4

s=tf('s');

ingresso = menu('scelta dell ingresso:',...
                'caso 1: u(t) = u0 * eps(t)',...
                'caso 2: u(t) = t * eps(t)',...
                'caso 3: u(t) = u0 * cos(4t) * eps(t)');

switch ingresso,
    case 1, U=1/s;
    case 2, U=1/s^2;
    case 3, U=s/(s^2+4^2);
end

Y=G*U

[NUM,DEN] = tfdata(Y,'v');

[Residui,Poli,Resto] = residue(NUM,DEN)

```

## Passo 3 : Calcolare la funzione di trasferimento

```Matlab

[NUM,DEN] = ss2tf(A,B,C,D,1);

G=tf(SYS)
```

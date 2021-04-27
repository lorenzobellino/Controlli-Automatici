# LABORATORIO 4 : Simulazione di un DC motor comandato in armatura e controllato in velocità

## Passo 0 : definizione del sistema

```Matlab
close all
clear all

%% ESERCIZIO 1 : SIMULAZIONE DI UN MOTORE ELETTRICO CONTROLLATO IN VELOCITA
%assumo i seguenti valori numerici

 Ra = 1;
 La = 6e-3;
 Km = 0.5;
 J = 0.1;
 Beta = 0.02;
 Ka = 10;

%definisco il sistema
 s = tf('s');
 F1 = (Ka*Km)/((s^2)*J*La+s*(Beta*La+J*Ra)+Beta*Ra+Km^2)
 F2 = -(s*La+Ra)/((s^2)*J*La+s*(Beta*La+J*Ra)+Beta*Ra+Km^2)
```
![alt text](https://github.com/lorenzobellino/Controlli-Automatici/blob/master/Laboratori/LAB04/img/f1f2e1.JPG){: style="float: right"}

## Passo 1: Simulazione in catena aperta in assenza del disturbo Td

```Matlab
%% SIMULAZIONE DEL SISTEMA IN CATENA APERTA IN ASSENZA DEL DISTURBO Td
Td = 0;
u = 1/dcgain(F1);

open_system('DCmotor_parte1')
sim('DCmotor_parte1')
figure, plot(tout,vel_ang, tout,u*ones(size(tout))), grid on,
title('DC-motor in catena aperta in assenza del disturbo Td'),
legend('\omega(t)','u(t)')
close_system('DCmotor_parte1')
```

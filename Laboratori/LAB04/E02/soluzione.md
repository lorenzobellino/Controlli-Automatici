# LABORATORIO 4 : Simulazione di un DC motor comandato in armatura e controllato in posizione

## Passo 0 : definizione del sistema

```Matlab
close all
clear all

%% SIMULAZIONE DI UN MOTORE ELETTRICO CONTROLLATO IN POSIZIONE
% definizione dei parametri

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
![alt text](https://github.com/lorenzobellino/Controlli-Automatici/blob/master/Laboratori/LAB04/img/f1f2e1.JPG)

## Passo 1: Simulazione in catena aperta in assenza del disturbo Td

![alt text](https://github.com/lorenzobellino/Controlli-Automatici/blob/master/Laboratori/LAB04/img/dcmotorE2P1.JPG)

```Matlab
%% SIMULAZIONE DEL SISTEMA IN CATENA APERTA IN ASSENZA DEL DISTURBO Td

Td = 0;
open_system('DCmotor_parte1')
sim('DCmotor_parte1')
u = ones(size(tout));
figure, plot(tout,pos_ang, tout,u), grid on,
title('DC-motor in catena aperta in assenza del disturbo Td'),
legend('\theta(t)','u(t)')
close_system('DCmotor_parte1')
```

![alt text](https://github.com/lorenzobellino/Controlli-Automatici/blob/master/Laboratori/LAB04/img/passo1E2.JPG)

## Passo 2 : Simulazione in catena aperta in presenza del disturbo Td

![alt text](https://github.com/lorenzobellino/Controlli-Automatici/blob/master/Laboratori/LAB04/img/dcmotorE2P1.JPG)

```Matlab
%% SIMULAZIONE DEL SISTEMA IN CATENA APERTA IN PRESENZA DEL DISTURBO Td

Td = 0.05;
open_system('DCmotor_parte1')
sim('DCmotor_parte1')
u = ones(size(tout));
figure, plot(tout,pos_ang, tout,u), grid on,
title('DC-motor in catena aperta in assenza del disturbo Td'),
legend('\theta(t)','u(t)')
close_system('DCmotor_parte1')
```

![alt text](https://github.com/lorenzobellino/Controlli-Automatici/blob/master/Laboratori/LAB04/img/passo2e2.JPG)

## Passo 3 : Simulazione in catena chiusa in assenza del disturbo Td

![alt text](https://github.com/lorenzobellino/Controlli-Automatici/blob/master/Laboratori/LAB04/img/dcmotorP2.JPG)

```Matlab
%% SIMULAZIONE DEL SISTEMA IN CATENA CHIUSA IN ASSENZA DEL DISTURBO Td
Td=0;

es=menu('scelta del valore di Kc',...
        'caso A: Kc = 0.1',...
        'caso B: Kc = 1',...
        'caso C: Kc = 5');
switch es,
    case 1, Kc = 0.1;
    case 2, Kc = 1;
    case 3, Kc = 5;
end


open_system('DCmotor_parte2')
sim('DCmotor_parte2')
u = ones(size(tout));
errore = u - vel_ang;
figure, plot(tout,vel_ang, tout,u, tout,errore), grid on,
 title(['DC-motor controllato in velocita'' con Kc=', num2str(Kc), ...
' in assenza del disturbo Td']),
 legend('\omega(t)','\omega_{rif}(t)','e(t)=\omega_{rif}(t)-\omega(t)',4)
close_system('DCmotor_parte2')

```
### Kc = 0.1
![alt text](https://github.com/lorenzobellino/Controlli-Automatici/blob/master/Laboratori/LAB04/img/kc01e2p1.JPG)
### Kc = 1
![alt text](https://github.com/lorenzobellino/Controlli-Automatici/blob/master/Laboratori/LAB04/img/kc1e2p1.JPG)
### Kc = 5
![alt text](https://github.com/lorenzobellino/Controlli-Automatici/blob/master/Laboratori/LAB04/img/kc5e2p1.JPG)

## Passo 4 : Simulazione in catena chiusa in assenza del disturbo Td

![alt text](https://github.com/lorenzobellino/Controlli-Automatici/blob/master/Laboratori/LAB04/img/dcmotorP2.JPG)

```Matlab
%% SIMULAZIONE DEL SISTEMA IN CATENA CHIUSA IN PRESENZA DEL DISTURBO Td

Td=0.05;

es=menu('scelta del valore di Kc',...
        'caso A: Kc = 0.1',...
        'caso B: Kc = 1',...
        'caso C: Kc = 5');
switch es,
    case 1, Kc = 0.1;
    case 2, Kc = 1;
    case 3, Kc = 5;
end

open_system('DCmotor_parte2')
sim('DCmotor_parte2')
u = ones(size(tout));
errore = u - pos_ang;
figure, plot(tout,pos_ang, tout,u, tout,errore), grid on,
 title(['DC-motor controllato in velocita'' con Kc=', num2str(Kc), ...
' in assenza del disturbo Td']),
 legend('\theta(t)','\theta_{rif}(t)','e(t)=\theta_{rif}(t)-\theta(t)',4)
close_system('DCmotor_parte2')

```
### Kc = 0.1
![alt text](https://github.com/lorenzobellino/Controlli-Automatici/blob/master/Laboratori/LAB04/img/kc01e2p2.JPG)
### Kc = 1
![alt text](https://github.com/lorenzobellino/Controlli-Automatici/blob/master/Laboratori/LAB04/img/kc1e2p2.JPG)
### Kc = 5
![alt text](https://github.com/lorenzobellino/Controlli-Automatici/blob/master/Laboratori/LAB04/img/kc5e2p2.JPG)

## Passo 5 : Calcolo della f.d.t. in catena chiusa e dei diagrammi di Bode


```Matlab
%% PARTE 5 CALCOLO DELLA FDT IN CATENA CHIUSA E DEI DIAGRAMMI DI BODE
Kc_max=(Beta*La+Ra*J)*(Ra*Beta+Km^2)/(J*La*Km*Ka)
figure
for Kc=[0.1,1,5],
 Kc
 W=feedback(Kc*F1/s,1)
 z_W=zero(W)
 p_W=pole(W)
 damp(W)
 bode (W), grid on, xlim([1e-1, 1e4]), hold on,
 title('DC-motor controllato in posizione')
end
legend(['Kc=',num2str(0.1)],['Kc=',num2str(1)],['Kc=',num2str(5)])



```
### Kc = 0.1
![alt text](https://github.com/lorenzobellino/Controlli-Automatici/blob/master/Laboratori/LAB04/img/kc01e2p5.JPG)
### Kc = 1
![alt text](https://github.com/lorenzobellino/Controlli-Automatici/blob/master/Laboratori/LAB04/img/kc1e2p5.JPG)
### Kc = 5
![alt text](https://github.com/lorenzobellino/Controlli-Automatici/blob/master/Laboratori/LAB04/img/kc5e2p5.JPG)
### Diagramma di Bode
![alt text](https://github.com/lorenzobellino/Controlli-Automatici/blob/master/Laboratori/LAB04/img/bodeE2.JPG)

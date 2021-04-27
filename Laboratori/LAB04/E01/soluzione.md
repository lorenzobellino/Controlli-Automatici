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
![alt text](https://github.com/lorenzobellino/Controlli-Automatici/blob/master/Laboratori/LAB04/img/f1f2e1.JPG)

## Passo 1: Simulazione in catena aperta in assenza del disturbo Td

![alt text](https://github.com/lorenzobellino/Controlli-Automatici/blob/master/Laboratori/LAB04/img/dcmotorE1.JPG)

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

![alt text](https://github.com/lorenzobellino/Controlli-Automatici/blob/master/Laboratori/LAB04/img/passo1E1.JPG)

## Passo 2 : Simulazione in catena aperta in presenza del disturbo Td

![alt text](https://github.com/lorenzobellino/Controlli-Automatici/blob/master/Laboratori/LAB04/img/dcmotorE1.JPG)

```Matlab
%% SIMULAZIONE DEL SISTEMA IN CATENA APERTA IN PRESENZA DEL DISTURBO Td
Td = 0.05;
u = 1/dcgain(F1);

open_system('DCmotor_parte1')
sim('DCmotor_parte1')
figure, plot(tout,vel_ang, tout,u*ones(size(tout))), grid on,
title('DC-motor in catena aperta in assenza del disturbo Td'),
legend('\omega(t)','u(t)')
close_system('DCmotor_parte1')
```

![alt text](https://github.com/lorenzobellino/Controlli-Automatici/blob/master/Laboratori/LAB04/img/passo2.JPG)

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
![alt text](https://github.com/lorenzobellino/Controlli-Automatici/blob/master/Laboratori/LAB04/img/kc01.JPG)
### Kc = 1
![alt text](https://github.com/lorenzobellino/Controlli-Automatici/blob/master/Laboratori/LAB04/img/kc1.JPG)
### Kc = 5
![alt text](https://github.com/lorenzobellino/Controlli-Automatici/blob/master/Laboratori/LAB04/img/kc5.JPG)

## Passo 4 : Simulazione in catena chiusa in assenza del disturbo Td

![alt text](https://github.com/lorenzobellino/Controlli-Automatici/blob/master/Laboratori/LAB04/img/dcmotorP2.JPG)

```Matlab
%% SIMULAZIONE DEL SISTEMA IN CATENA CHIUSA IN ASSENZA DEL DISTURBO Td
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
errore = u - vel_ang;
figure, plot(tout,vel_ang, tout,u, tout,errore), grid on,
 title(['DC-motor controllato in velocita'' con Kc=', num2str(Kc), ...
' in assenza del disturbo Td']),
 legend('\omega(t)','\omega_{rif}(t)','e(t)=\omega_{rif}(t)-\omega(t)',4)
close_system('DCmotor_parte2')

```
### Kc = 0.1
![alt text](https://github.com/lorenzobellino/Controlli-Automatici/blob/master/Laboratori/LAB04/img/kc01td.JPG)
### Kc = 1
![alt text](https://github.com/lorenzobellino/Controlli-Automatici/blob/master/Laboratori/LAB04/img/kc1td.JPG)
### Kc = 5
![alt text](https://github.com/lorenzobellino/Controlli-Automatici/blob/master/Laboratori/LAB04/img/kc5td.JPG)

## Passo 5 : Calcolo della f.d.t. in catena chiusa e dei diagrammi di Bode


```Matlab
%% PARTE 5 CALCOLO DELLA FDT IN CATENA CHIUSA E DEI DIAGRAMMI DI BODE

figure
for Kc=[0.1,1,5],
 Kc
 W=feedback(Kc*F1/s,1)
 z_W=zero(W)
 p_W=pole(W)
 damp(W)
 bode (W), grid on, xlim([1e-1, 1e4]), hold on,
 title('DC-motor controllato in velocità')
end
legend(['Kc=',num2str(0.1)],['Kc=',num2str(1)],['Kc=',num2str(5)])


```
### Kc = 0.1
![alt text](https://github.com/lorenzobellino/Controlli-Automatici/blob/master/Laboratori/LAB04/img/kc01e1p5.JPG)
### Kc = 1
![alt text](https://github.com/lorenzobellino/Controlli-Automatici/blob/master/Laboratori/LAB04/img/kc1e1p5.JPG)
### Kc = 5
![alt text](https://github.com/lorenzobellino/Controlli-Automatici/blob/master/Laboratori/LAB04/img/kc5e1p5.JPG)
### Diagramma di Bode
![alt text](https://github.com/lorenzobellino/Controlli-Automatici/blob/master/Laboratori/LAB04/img/bodeE1.JPG)

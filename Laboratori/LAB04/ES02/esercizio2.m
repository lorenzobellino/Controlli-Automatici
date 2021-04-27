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

%% SIMULAZIONE DEL SISTEMA IN CATENA APERTA IN ASSENZA DEL DISTURBO Td

Td = 0;
open_system('DCmotor_parte1')
sim('DCmotor_parte1')
u = ones(size(tout));
figure, plot(tout,pos_ang, tout,u), grid on,
title('DC-motor in catena aperta in assenza del disturbo Td'),
legend('\theta(t)','u(t)')
close_system('DCmotor_parte1')

%% SIMULAZIONE DEL SISTEMA IN CATENA APERTA IN PRESENZA DEL DISTURBO Td

Td = 0.05;
open_system('DCmotor_parte1')
sim('DCmotor_parte1')
u = ones(size(tout));
figure, plot(tout,pos_ang, tout,u), grid on,
title('DC-motor in catena aperta in assenza del disturbo Td'),
legend('\theta(t)','u(t)')
close_system('DCmotor_parte1')

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
errore = u - pos_ang;
figure, plot(tout,pos_ang, tout,u, tout,errore), grid on,
 title(['DC-motor controllato in velocita'' con Kc=', num2str(Kc), ...
' in assenza del disturbo Td']),
 legend('\theta(t)','\theta_{rif}(t)','e(t)=\theta_{rif}(t)-\theta(t)',4)
close_system('DCmotor_parte2')

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


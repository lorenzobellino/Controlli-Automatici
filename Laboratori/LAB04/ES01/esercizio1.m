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

 %% SIMULAZIONE DEL SISTEMA IN CATENA APERTA IN ASSENZA DEL DISTURBO Td
 Td = 0;
 u = 1/dcgain(F1);

open_system('DCmotor_parte1')
sim('DCmotor_parte1')
%w_rif=1/dcgain(F1)*ones(size(tout));
figure, plot(tout,vel_ang, tout,u*ones(size(tout))), grid on,
title('DC-motor in catena aperta in assenza del disturbo Td'),
legend('\omega(t)','u(t)')
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
errore = u - vel_ang;
figure, plot(tout,vel_ang, tout,u, tout,errore), grid on,
 title(['DC-motor controllato in velocita'' con Kc=', num2str(Kc), ...
' in assenza del disturbo Td']),
 legend('\omega(t)','\omega_{rif}(t)','e(t)=\omega_{rif}(t)-\omega(t)',4)
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
errore = u - vel_ang;
figure, plot(tout,vel_ang, tout,u, tout,errore), grid on,
 title(['DC-motor controllato in velocita'' con Kc=', num2str(Kc), ...
' in assenza del disturbo Td']),
 legend('\omega(t)','\omega_{rif}(t)','e(t)=\omega_{rif}(t)-\omega(t)',4)
close_system('DCmotor_parte2')

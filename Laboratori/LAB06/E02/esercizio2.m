clear all
close all

%% PASSO 0 : Definizione del sistema:
s=tf('s');
F=(s-1)/((s+0.2)*(s^3+2.5*s^2+4*s))
Kr = 0.5

%% PASSO 1 : Determinare Kf, singolarità, fase iniziale e finale del sistema

Kf = dcgain(s*F)
zeri = zero(F)
poli = pole(F)
damp(F)
figure, bode(F), grid on


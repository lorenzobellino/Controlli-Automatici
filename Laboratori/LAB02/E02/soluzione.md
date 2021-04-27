# LABORATORIO 2 : Risposta al gradino unitario per sistemi del II ordine
## PARTE 1: Verificare l'effetto dei vari valori del secondo polo

```Matlab
%PARTE 1
close all
clear all
s = tf('s');
%RISPOSTA DI SISTEMI DEL II ORDINE AD INGRESSI CANONICI
%dati i sistemi dinamici SISO LTI a tempo continuo descritti dalle seguenti funzioni di trasferimento:
%se ne traccino le risposte al gradino unitario osservando gli effetti dei diversi
%valori del polo, si ricavino i valori finali delle risposte e i tempi di salita

es = menu('scelta della funzione di trasferimento',...
         'G1 = 20/((s+1)*(s+10))',...
         'G2 = 2/((s+1)^2)',...
         'G3 = 0.2/((s+1)*(s+0.1))',...
         'visualizza tutti i grafici contemporaneamente');

switch (es)
    case 1
        G1 = 20/((s+1)*(s+10))
        figure, step(G1,'r'), grid on
        %PER G1:
        %poli : p1 = -1 , p2 =-10
        %costanti di tempo : tau1 = 1 , tau2 = 0.1
        %risposta fianle : 2
        %tempo di salita : 2.22
    case 2
        G2 = 2/((s+1)^2)
        figure, step(G2,'b'), grid on
        %PER G2:
        %poli : p1 = -1 , p2 =-1
        %costanti di tempo : tau1 = 1 , tau2 = 1
        %risposta fianle : 2
        %tempo di salita : 3.36
    case 3
        G3 = 0.2/((s+1)*(s+0.1))
        figure, step(G3,'g'), grid on
        %PER G3:
        %poli : p1 = -1 , p2 =-0.1
        %costanti di tempo : tau1 = 1 , tau2 = 10
        %risposta fianle : 2
        %tempo di salita : 22.1
    case 4,
        G1 = 20/((s+1)*(s+10))
        G2 = 2/((s+1)^2)
        G3 = 0.2/((s+1)*(s+0.1))
        figure, step(G1,'r',G2,'b',G3,'g'), grid on
        %notiamo subito che la risposta finale e sempre la stessa e cio e confermato dal
        %risultato teorico : y(inf) = lim(s->0){s*G(s)*1/s} = 2
        %ma aumentanto ogni volta di una decade la costante di tempo del secondo polo
        %ogni volta il sistema arrivera� al suo valore di regime sempre piu lentamente
end

```
![alt text](https://github.com/lorenzobellino/Controlli-Automatici/blob/master/Laboratori/LAB02/img/e2p1.JPG)

## PARTE 2: Verificare l'effetto di diversi valori per uno zero

```Matlab
%PARTE 2
close all
clear all
s = tf('s');
%dato il sistema: G4 = (5/-z)*(s-z)/((s+1)*(s+5)) confrontare le risposte al
%gradino unitario per diversi valori di z
%e si determino i tempi di salita
es=menu('scelta del valore di z',...
        'caso A: z1=100, z2=10, z3=1, z4=0.5 (compare una sottoelongaszione)',...
        'caso B: z1=-0.9, z2=-0.5, z3=-0.1 (compare una sovraelongazione (ymax -yinf)/yinf)',...
        'caso C: z1=-100, z2=-10, z3=-2 (cambia la velocità di risposta)');
switch (es)
    case 1
        z = [100, 10, 1, 0.5]
        G41 = (5/-z(1))*(s-z(1))/((s+1)*(s+5));
        G42 = (5/-z(2))*(s-z(2))/((s+1)*(s+5));
        G43 = (5/-z(3))*(s-z(3))/((s+1)*(s+5));
        G44 = (5/-z(3))*(s-z(4))/((s+1)*(s+5));
        figure, step(G41,'r',G42,'b',G43,'g',G44,'y'), grid on
        %caso 1:
        %nel caso 1 per valori positivi di z notiamo una sottoelongazione, molto
        %evidente per valori di z<5
        %ts = {2.27, 2.27, 2.21, 2.2}
    case 2
        z = [-0.9, -0.5, -0.1]
        G41 = (5/-z(1))*(s-z(1))/((s+1)*(s+5));
        G42 = (5/-z(2))*(s-z(2))/((s+1)*(s+5));
        G43 = (5/-z(3))*(s-z(3))/((s+1)*(s+5));
        figure, step(G41,'r',G42,'b',G43,'g'), grid on
        %caso 2:
        %in questo caso i valori di z sono compresi tra -1 e 0; qui notiamo una sovraelongazione
        %che e inversamente proporzionale al modulo di z
        %ts = {0.3, 0.11, 0.017}
        %sovraelongazione s = (ymax-yinf)/yinf
        %s = {4%, 57%, 589%}
        %possiamo dedurre che tanto piu il sistema è veloce, tanto piu la sovraelongazione
        %sarà maggiore
    case 3
        z = [-100, -10, -2]
        G41 = (5/-z(1))*(s-z(1))/((s+1)*(s+5));
        G42 = (5/-z(2))*(s-z(2))/((s+1)*(s+5));
        G43 = (5/-z(3))*(s-z(3))/((s+1)*(s+5));
        figure, step(G41,'r',G42,'b',G43,'g'), grid on
        %caso 3:
        %in questo caso per valori di z<-1 la risposta sara� monotona crescente
        %ts = {2.27, 2.26, 1.79}
        %notiamo quindi che al diminuiore del modulo del parametro z il sistema diventa piu veloce
```
### caso 1
![alt text](https://github.com/lorenzobellino/Controlli-Automatici/blob/master/Laboratori/LAB02/img/e2p2a.JPG)
### caso 2
![alt text](https://github.com/lorenzobellino/Controlli-Automatici/blob/master/Laboratori/LAB02/img/e2p2b.JPG)
### caso 3
![alt text](https://github.com/lorenzobellino/Controlli-Automatici/blob/master/Laboratori/LAB02/img/e2p2c.JPG)
### valori di z per i tre casi
![alt text](https://github.com/lorenzobellino/Controlli-Automatici/blob/master/Laboratori/LAB02/img/e2p2z.JPG)

## PARTE 3: verificare l'effetto di due poli complessi coniugati per diversi valori di wn e z

```Matlab
%PARTE 3
close all
clear all
s = tf('s');
%dato il sistema: G5 = (wn^2)/(s^2 + 2*z*wm*s + wn^2) confrontare le risposte al
%gradino unitario per diversi valori di wn e z
%si valutino le sovraelongazioni massime s = exp(-pi*z/sqrt(1-z^2))
%si valutino i tempi di salita ts = (1/(wn*sqrt(1-z^2))*(pi -acos(z))
%calcolati come il tempo impiegato per arrivare per la prima volta al
%valore di y infinito
%si valutino graficamente i tempi di assestamento al 5% pari al tempo
%necesdsario affinch� y(t) differisca definitivamente dal valore finale y
%infinit di on pi� del 5% -> (95%-105% da y infinito)

es=menu('scelta del valore di wn e z',...
        'caso A: wn = 2 , z = 0.5',...
        'caso B: wn = 2 , z = 0.25',...
        'caso C: wn = 1 , z = 0.5',...
        'visualizzare tutti i grafici contemporaneamente');
switch (es)
    case 1
        wn = 2; z = 0.5;
        G5 = (wn^2)/((s^2) + (2*z*wn*s) + (wn^2))
        figure, step(G5), grid on
        sov = exp(-pi*z/sqrt(1-z^2))
        ts = (1/(wn*sqrt(1-z^2)))*(pi -acos(z))
        %notiamo che graficamente
        %CASO 1:
        %s = 1.16 = 16%
        %ts = 1.21
        %mentre i risultati predetti teoricamente sono
        %CASO 1:
        %s = 0.163 = 16.3%
        %ts = 1.2092
        %per i tempi di assestamento al 5% ricaviamo:
        %CASO 1:
        %ta = 2.65
    case 2
        wn = 2; z = 0.25;
        G5 = (wn^2)/((s^2) + (2*z*wn*s) + (wn^2))
        figure, step(G5), grid on
        sov = exp(-pi*z/sqrt(1-z^2))
        ts = (1/(wn*sqrt(1-z^2)))*(pi -acos(z))
        %notiamo che graficamente
        %CASO 2:
        %s = 1.44 = 44%
        %ts = 0.946
        %mentre i risultati predetti teoricamente sono
        %CASO 2:
        %s = 0.4443 = 44.43%
        %ts = 0.9416
        %per i tempi di assestamento al 5% ricaviamo:
        %CASO 2:
        %ta = 5.41
    case 3
        wn = 1; z = 0.5;
        G5 = (wn^2)/((s^2) + (2*z*wn*s) + (wn^2))
        figure, step(G5), grid on
        sov = exp(-pi*z/sqrt(1-z^2))
        ts = (1/(wn*sqrt(1-z^2)))*(pi -acos(z))
        %notiamo che graficamente
        %CASO 3:
        %s = 1.16 = 16%
        %ts = 2.41
        %mentre i risultati predetti teoricamente sono
        %CASO 3:
        %s = 0.163 = 16.3%
        %ts = 2.4184
        %per i tempi di assestamento al 5% ricaviamo:
        %CASO 3
        %ta = 5.31
    case 4
        wn1 = 2; z1 = 0.5;
        wn2 = 2; z2 = 0.25;
        wn3 = 1; z3 = 0.5;
        G51 = (wn1^2)/((s^2) + (2*z1*wn1*s) + (wn1^2))
        G52 = (wn2^2)/((s^2) + (2*z2*wn2*s) + (wn2^2))
        G53 = (wn3^2)/((s^2) + (2*z3*wn3*s) + (wn3^2))
        figure, step(G52,'r',G52,'b',G53,'g'), grid on
        s1 = exp(-pi*z1/sqrt(1-z1^2))
        s2 = exp(-pi*z2/sqrt(1-z2^2))
        s3 = exp(-pi*z3/sqrt(1-z3^2))

        ts1 = (1/(wn1*sqrt(1-z1^2)))*(pi -acos(z1))
        ts2 = (1/(wn2*sqrt(1-z2^2)))*(pi -acos(z2))
        ts3 = (1/(wn3*sqrt(1-z3^2)))*(pi -acos(z3))
```
### grafici
![alt text](https://github.com/lorenzobellino/Controlli-Automatici/blob/master/Laboratori/LAB02/img/e2p3.JPG)
### sovraelongazione e tempi di salita
![alt text](https://github.com/lorenzobellino/Controlli-Automatici/blob/master/Laboratori/LAB02/img/e2p3sts.JPG)

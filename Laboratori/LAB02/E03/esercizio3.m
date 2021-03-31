parte = menu('scegli quale esercizio:',...
              'CASO CONTINUO',...
              'CASO DISCRETO');
switch(parte)
case 1
  %CASO CONTINUO
  close all
  clear all
  %date le matrici di stato
  B = [1,1].'
  C = [1,3]
  D = [0]
  %e dati
  T = 0:0.1:50;
  U = 0*T;
  %assumo un ingresso x(t=0) != [0,0]T
  x = randperm(20,2).'

  mat = menu('scegli i valori di A : ',...
              'A = [[-0.5,1],[0,-2]]',...
              'A = [[-0.5,1],[0,-1]]',...
              'A = [-0.5,1],[0,0]]',...
              'A = [[-0.5,1],[0,1]]',...
              'simulare tutte le possibili matrici');
  switch(mat)
  case 1
    A = [[-0.5,1];[0,-2]]
    %AUTOVALORI = {-0.5, -2}
    %stabilita interna : ASINTOTICA STABILITA
    %se Re{lambda} < 0 per ogni lambda => ASINT. STAB.

    %simulare l'evoluzione dello stato x
    SYS = ss(A,B,C,D);
    [YS,TS,XS] = lsim(SYS,U,T,x);

    %plottare l'evoluzione dello stato x1
    figure, plot(TS,XS(:,1),'r'), grid on, title('evoluzione di x1')
    %plottare l'evoluzione dello stato x2
    figure, plot(TS,XS(:,2),'r'), grid on, title('evoluzione di x2')

    %il sistema è internamente stabile, cioe tutti gli autovalori hanno parte reale negativa
    %per quesato motivo levoluzione di x converge a zero
  case 2
    A = [[-0.5,1];[0,-1]]
    %AUTOVALORI {-0.5, -1}
    %stabilita interna ASINTOTICA STABILITA
    %se Re{lambda} < 0 per ogni lambda => ASINT. STAB.

    %simulare l'evoluzione dello stato x
    SYS = ss(A,B,C,D);
    [YS,TS,XS] = lsim(SYS,U,T,x);

    %plottare l'evoluzione dello stato x1
    figure, plot(TS,XS(:,1),'r'), grid on, title('evoluzione di x1')
    %plottare l'evoluzione dello stato x2
    figure, plot(TS,XS(:,2),'r'), grid on, title('evoluzione di x2')

    %il sistema è internamente stabile, cioe tutti gli autovalori hanno parte reale negativa
    %per quesato motivo levoluzione di x converge a zero

  case 3
    A = [[-0.5,1];[0,0]]
    %AUTOVALORI : {-0.5, 0}
    %stabilita interna : SEMPLICEMENTE STABILE
    %se tutti gli autovalori con parte reale <=0 e esiste un autovalore con molteplicita
    %uno la cui parte reale vale 0

    %simulare l'evoluzione dello stato x
    SYS = ss(A,B,C,D);
    [YS,TS,XS] = lsim(SYS,U,T,x);

    %plottare l'evoluzione dello stato x1
    figure, plot(TS,XS(:,1),'r'), grid on, title('evoluzione di x1')
    %plottare l'evoluzione dello stato x2
    figure, plot(TS,XS(:,2),'r'), grid on, title('evoluzione di x2')

    %il sistema e semplicemente stabile con un autovalore nullo
    %per questo motivo l'evoluzione dello stato x2 rimane limitata
    %mentre l'evoluzione di x1 coe asdintoticamente a zero

  case 4
    A = [[-0.5,1];[0,1]]
    %AUTOVALORI : {-0.5, 1}
    %stabilita interna : INSTABILE
    %esiste un autovalore con parte reale > 0

    %simulare l'evoluzione dello stato x
    SYS = ss(A,B,C,D);
    [YS,TS,XS] = lsim(SYS,U,T,x);

    %plottare l'evoluzione dello stato x1
    figure, plot(TS,XS(:,1),'r'), grid on, title('evoluzione di x1')
    %plottare l'evoluzione dello stato x2
    figure, plot(TS,XS(:,2),'r'), grid on, title('evoluzione di x2')

    %il sistema e instabile con almeno un autovalore positivo
    %questo implica che l'evoluzione dell'uscita diverga a infinito
  case 5
    A1 = [[-0.5,1];[0,-2]]
    A2 = [[-0.5,1];[0,-1]]
    A3 = [[-0.5,1];[0,0]]
    A4 = [[-0.5,1];[0,1]]
    %simulo l'evoluzione dello stato x
    SYS1 = ss(A1,B,C,D);
    [YS1,TS1,XS1] = lsim(SYS1,U,T,x);
    SYS2 = ss(A2,B,C,D);
    [YS2,TS2,XS2] = lsim(SYS2,U,T,x);
    SYS3 = ss(A3,B,C,D);
    [YS3,TS3,XS3] = lsim(SYS3,U,T,x);
    SYS4 = ss(A4,B,C,D);
    [YS4,TS4,XS4] = lsim(SYS4,U,T,x);

    %plottare l'evoluzione dello stato X1
    figure, plot(TS1,XS1(:,1),'r',TS2,XS2(:,1),'g',TS3,XS3(:,1),'b',TS4,XS4(:,1),'y'), grid on, title('evoluzione di x1')
    %plottare l'evoluzione dello stato x2
    figure, plot(TS1,XS1(:,2),'r',TS2,XS2(:,2),'g',TS3,XS3(:,2),'b',TS4,XS4(:,2),'y'), grid on, title('evoluzione di x2')

  end

case 2
  close all
  clear all
  %date le matrici di stato
  B = [1,1].'
  C = [1,3]
  D = [0]
  %e dati
  T = 0:1:20;
  U = 0*T;

  %assumo un ingresso x(t=0) != [0,0]T
  x = randperm(20,2).'

  mat = menu('scegli i valori di A : ',...
              'A = [[-0.5,1],[0,-2]]',...
              'A = [[-0.5,1],[0,-1]]',...
              'A = [-0.5,1],[0,0]]',...
              'A = [[-0.5,1],[0,1]]',...
              'simulare tutte le possibili matrici');
  switch(mat)
  case 1
    A = [[-0.5,1];[0,-2]]
    %AUTOVALORI = {-0.5, -2}
    %stabilita interna : INSTABILITA
    %se esiste una utovalore con modulo > 1 = INSTABILE

    %simulare l'evoluzione dello stato x
    SYS = ss(A,B,C,D,-1);
    [YS,TS,XS] = lsim(SYS,U,T,x);

    %plottare l'evoluzione dello stato x1
    figure, plot(TS,XS(:,1),'r'), grid on, title('evoluzione di x1')
    %plottare l'evoluzione dello stato x2
    figure, plot(TS,XS(:,2),'r'), grid on, title('evoluzione di x2')

    %il sistema ha almeno un autovalore con modulo > 1 e quindi almeno una delle
    %evoluzioni degli stati di x divergerta a infinito

  case 2
    A = [[-0.5,1];[0,-1]]
    %AUTOVALORI {-0.5, -1}
    %stabilita interna SEMPLICE STABILITA
    %se tutti  gli autovalori hanno parte reale in modulo <= 1 e esiste
    %un autovalore in modulo = 1 con molteplicità 1 => SEMPL. STAB

    %simulare l'evoluzione dello stato x
    SYS = ss(A,B,C,D,-1);
    [YS,TS,XS] = lsim(SYS,U,T,x);

    %plottare l'evoluzione dello stato x1
    figure, plot(TS,XS(:,1),'r'), grid on, title('evoluzione di x1')
    %plottare l'evoluzione dello stato x2
    figure, plot(TS,XS(:,2),'r'), grid on, title('evoluzione di x2')

    %il sistema ha un autovalore con modulo uguale a 1 e questo implica che la
    %sua evoluzione dello stato rimarra limitata senza convergere a zero

  case 3
    A = [[-0.5,1];[0,0]]
    %AUTOVALORI : {-0.5, 0}
    %stabilita interna : ASINTOTICA STABILITA
    %tutti gli autovalori hanno modulo < 1 => ASINT. STAB.

    %simulare l'evoluzione dello stato x
    SYS = ss(A,B,C,D,-1);
    [YS,TS,XS] = lsim(SYS,U,T,x);

    %plottare l'evoluzione dello stato x1
    figure, plot(TS,XS(:,1),'r'), grid on, title('evoluzione di x1')
    %plottare l'evoluzione dello stato x2
    figure, plot(TS,XS(:,2),'r'), grid on, title('evoluzione di x2')

    %tutti gli autovalori hanno modulo minore di 1 e quindi
    %l'evoluzione di x convergera asintoticamente a zero

  case 4
    A = [[-0.5,1];[0,1]]
    %AUTOVALORI : {-0.5, 1}
    %se tutti  gli autovalori hanno parte reale in modulo <= 1 e esiste
    %un autovalore in modulo = 1 con molteplicità 1 => SEMPL. STAB

    %simulare l'evoluzione dello stato x
    SYS = ss(A,B,C,D,-1);
    [YS,TS,XS] = lsim(SYS,U,T,x);

    %plottare l'evoluzione dello stato x1
    figure, plot(TS,XS(:,1),'r'), grid on, title('evoluzione di x1')
    %plottare l'evoluzione dello stato x2
    figure, plot(TS,XS(:,2),'r'), grid on, title('evoluzione di x2')

    %il sistema ha un autovalore con modulo uguale a 1 e questo implica che la
    %sua evoluzione dello stato rimarra limitata senza convergere a zero

  case 5
    A1 = [[-0.5,1];[0,-2]]
    A2 = [[-0.5,1];[0,-1]]
    A3 = [[-0.5,1];[0,0]]
    A4 = [[-0.5,1];[0,1]]
    %simulo l'evoluzione dello stato x
    SYS1 = ss(A1,B,C,D,-1);
    [YS1,TS1,XS1] = lsim(SYS1,U,T,x);
    SYS2 = ss(A2,B,C,D,-1);
    [YS2,TS2,XS2] = lsim(SYS2,U,T,x);
    SYS3 = ss(A3,B,C,D,-1);
    [YS3,TS3,XS3] = lsim(SYS3,U,T,x);
    SYS4 = ss(A4,B,C,D,-1);
    [YS4,TS4,XS4] = lsim(SYS4,U,T,x);

    %plottare l'evoluzione dello stato X1
    figure, plot(TS1,XS1(:,1),'r',TS2,XS2(:,1),'g',TS3,XS3(:,1),'b',TS4,XS4(:,1),'y'), grid on, title('evoluzione di x1')
    %plottare l'evoluzione dello stato x2
    figure, plot(TS1,XS1(:,2),'r',TS2,XS2(:,2),'g',TS3,XS3(:,2),'b',TS4,XS4(:,2),'y'), grid on, title('evoluzione di x2')

  end


end

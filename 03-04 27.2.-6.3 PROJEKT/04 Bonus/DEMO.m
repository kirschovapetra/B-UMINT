%Demo pre mrtvu pokutu - bonus

clear;

cycles = 10000;
pop_size = 100;     %velkost celej populacie
subpop_size = 20;   %velkost subpopulacie

Df = [zeros(1,5); 10000000*ones(1,5)];       %Df = <0,10 000 000>

Pop = genrpop(pop_size, Df);            %generovanie populacie - nahodne

subpop1 = randpopsel(Pop);      %generovanie subpopulácií
subpop2 = randpopsel(Pop);
subpop3 = randpopsel(Pop);
subpop4 = randpopsel(Pop);
subpop5 = randpopsel(Pop);

Fit1 = investfn(subpop1);                   %vypocet fitness
Fit2 = investfn(subpop2);
Fit3 = investfn(subpop3);
Fit4 = investfn(subpop4);
Fit5 = investfn(subpop5);

[maxFit1,indx1]=max(Fit1);                 % najlepsi - max retazec subpop1
maxRet1=subpop1(indx1,:);       
[maxFit2,indx2]=max(Fit2);                 % najlepsi - max retazec subpop2
maxRet2=subpop2(indx2,:);  
[maxFit3,indx3]=max(Fit3);                 % najlepsi - max retazec subpop3
maxRet3=subpop3(indx3,:); 
[maxFit4,indx4]=max(Fit4);                 % najlepsi - max retazec subpop4
maxRet4=subpop4(indx4,:); 
[maxFit5,indx5]=max(Fit5);                 % najlepsi - max retazec subpop5
maxRet5=subpop5(indx5,:); 

grafFit1=zeros(1,cycles);
grafFit2=zeros(1,cycles);
grafFit3=zeros(1,cycles);
grafFit4=zeros(1,cycles);
grafFit5=zeros(1,cycles);

grafFit=zeros(1,cycles);

Amp = 100000*ones(1,5);
for i = 1:cycles
    %uprava prvej subpopulacie
    best_subpop1 = 5;
    tourn_subpop1 = subpop_size - best_subpop1 - 5;     % necha 5 povodnych

    Bestsubpop1 = selbest(subpop1,-Fit1,[best_subpop1]);      %najlepsie retazce = nemenime
    Bestsubpop11 = selbest(subpop1,-Fit1,[best_subpop1]);     %najlepsie retazce = menime
    Tournsubpop1 = seltourn(subpop1,Fit1,tourn_subpop1);    %nahodny vybr = menime

    Modifsubpop1 = [Bestsubpop11;Tournsubpop1];     %modifikacia
    Modifsubpop1 = crossov(Modifsubpop1,1,0);       %krizenie
    Modifsubpop1 = mutx(Modifsubpop1,0.5,Df);       %mutacia
    Modifsubpop1 = muta(Modifsubpop1,0.2,Amp,Df);   %mutacia

    subpop1 = [Bestsubpop1;Modifsubpop1];

    Fit1 = investfn(subpop1);

    [maxFitnew1,indx1]=max(Fit1);
    if maxFitnew1>maxFit1                     
        maxFit1=maxFitnew1;                 
        maxRet1=subpop1(indx1,:);                 
    end
    grafFit1(i)=maxFit1;

    %uprava druhej subpopulacie
    best_subpop2 = 5;
    tourn_subpop2 = subpop_size - best_subpop2 - 5;     % necha 5 povodnych

    Bestsubpop2 = selbest(subpop2,-Fit2,best_subpop2);      %najlepsie retazce = nemenime
    Bestsubpop22 = selbest(subpop2,-Fit2,best_subpop2);     %najlepsie retazce = menime
    Tournsubpop2 = seltourn(subpop2,Fit2,tourn_subpop2);    %nahodny vybr = menime

    Modifsubpop2 = [Bestsubpop22;Tournsubpop2];     %modifikacia
    Modifsubpop2 = crossov(Modifsubpop2,1,0);       %krizenie
    Modifsubpop2 = mutx(Modifsubpop2,0.5,Df);       %mutacia
    Modifsubpop2 = muta(Modifsubpop2,0.2,Amp,Df);   %mutacia

    subpop2 = [Bestsubpop2;Modifsubpop2];

    Fit2 = investfn(subpop2);

    [maxFitnew2,indx2]=max(Fit2);
    if maxFitnew2>maxFit2                     
        maxFit2=maxFitnew2;                 
        maxRet2=subpop2(indx2,:);                 
    end
    grafFit2(i)=maxFit2;

    %uprava tretie subpopulacie
    best_subpop3 = 5;
    tourn_subpop3 = subpop_size - best_subpop3 - 5;     % necha 5 povodnych

    Bestsubpop3 = selbest(subpop3,-Fit3,best_subpop3);      %najlepsie retazce = nemenime
    Bestsubpop33 = selbest(subpop3,-Fit3,best_subpop3);     %najlepsie retazce = menime
    Tournsubpop3 = seltourn(subpop3,Fit3,tourn_subpop3);    %nahodny vybr = menime

    Modifsubpop3 = [Bestsubpop33;Tournsubpop3];     %modifikacia
    Modifsubpop3 = crossov(Modifsubpop3,1,0);       %krizenie
    Modifsubpop3 = mutx(Modifsubpop3,0.5,Df);       %mutacia
    Modifsubpop3 = muta(Modifsubpop3,0.2,Amp,Df);   %mutacia

    subpop3 = [Bestsubpop3;Modifsubpop3];

    Fit3 = investfn(subpop3);

    [maxFitnew3,indx3]=max(Fit3);
    if maxFitnew3>maxFit3                     
        maxFit3=maxFitnew3;                 
        maxRet3=subpop3(indx3,:);                 
    end
    grafFit3(i)=maxFit3;

    %uprava stvrtej subpopulacie
    best_subpop4 = 5;
    tourn_subpop4 = subpop_size - best_subpop4 - 5;     % necha 5 povodnych

    Bestsubpop4 = selbest(subpop4,-Fit4,best_subpop4);      %najlepsie retazce = nemenime
    Bestsubpop44 = selbest(subpop4,-Fit4,best_subpop4);     %najlepsie retazce = menime
    Tournsubpop4 = seltourn(subpop4,Fit4,tourn_subpop4);    %nahodny vybr = menime

    Modifsubpop4 = [Bestsubpop44;Tournsubpop4];     %modifikacia
    Modifsubpop4 = crossov(Modifsubpop4,1,0);       %krizenie
    Modifsubpop4 = mutx(Modifsubpop4,0.5,Df);       %mutacia
    Modifsubpop4 = muta(Modifsubpop4,0.2,Amp,Df);   %mutacia

    subpop4 = [Bestsubpop4;Modifsubpop4];

    Fit4 = investfn(subpop4);

    [maxFitnew4,indx4]=max(Fit4);
    if maxFitnew4>maxFit4                     
        maxFit4=maxFitnew4;                 
        maxRet4=subpop4(indx4,:);                 
    end
    grafFit4(i)=maxFit4;

    %uprava piatej subpopulacie
    best_subpop5 = 5;
    tourn_subpop5 = subpop_size - best_subpop5 - 5;     % necha 5 povodnych

    Bestsubpop5 = selbest(subpop5,-Fit5,best_subpop5);      %najlepsie retazce = nemenime
    Bestsubpop55 = selbest(subpop5,-Fit5,best_subpop5);     %najlepsie retazce = menime
    Tournsubpop5 = seltourn(subpop5,Fit5,tourn_subpop5);    %nahodny vybr = menime

    Modifsubpop5 = [Bestsubpop55;Tournsubpop5];     %modifikacia
    Modifsubpop5 = crossov(Modifsubpop5,1,0);       %krizenie
    Modifsubpop5 = mutx(Modifsubpop5,0.5,Df);       %mutacia
    Modifsubpop5 = muta(Modifsubpop5,0.2,Amp,Df);   %mutacia

    subpop5 = [Bestsubpop5;Modifsubpop5];

    Fit5 = investfn(subpop5);

    [maxFitnew5,indx5]=max(Fit5);
    if maxFitnew5>maxFit5                     
        maxFit5=maxFitnew5;                 
        maxRet5=subpop5(indx5,:);                 
    end
    grafFit5(i)=maxFit5;

    if mod(i,50) == 0                       %migrácia - architektura typu D
        %1
        Best1 = selbest(subpop1,-Fit1,1);
        r = ceil((20-1).*rand() + 1);
        %subpop2(r) = Best1;
        for k = 1:5
            subpop2(r,k) = Best1(k);
        end
        %2
        Best2 = selbest(subpop2,-Fit2,1);
        r = ceil((20-1).*rand() + 1);
        %subpop3(r) = Best2;
        for k = 1:5
            subpop3(r,k) = Best2(k);
        end
        %3
        Best3 = selbest(subpop3,-Fit3,1);
        r = ceil((20-1).*rand() + 1);
        %subpop4(r) = Best3;
        for k = 1:5
            subpop4(r,k) = Best3(k);
        end
        %4
        Best4 = selbest(subpop4,-Fit4,1);
        r = ceil((20-1).*rand() + 1);
        %subpop5(r) = Best4;
        for k = 1:5
            subpop5(r,k) = Best4(k);
        end
        %5
        Best5 = selbest(subpop5,-Fit5,1);
        r = ceil((20-1).*rand() + 1);
        %subpop1(r) = Best5;
        for k = 1:5
            subpop1(r,k) = Best5(k);
        end
    end
    

end

%hladanie najlepsieho retazca spomedzi najlepsich retazcov vsetkych subpopulacii
maxRets = [maxRet1;maxRet2;maxRet3;maxRet4;maxRet5]; %najlepsie retazce vsetkych subpopulacii
Fit = [Fit1;Fit2;Fit3;Fit4;Fit5];                    %fitness
maxRet = selbest(maxRets,-Fit,[1]);                  %vyber uplne najlepsieho retazca
   
%priradenie grafu k najlepsiemu retazcu
if (maxRet==maxRet1)
    grafFit = grafFit1;
end;
if (maxRet==maxRet2)
    grafFit = grafFit2;
end;
if (maxRet==maxRet3)
    grafFit = grafFit3;
end;
if (maxRet==maxRet4)
    grafFit = grafFit4;
end; 
if (maxRet==maxRet5)
    grafFit = grafFit5;
end;


figure(1)
hold on
%vykreslenie pre vsetky populacie - prvych 200 hodnot
plot(grafFit1(1:200),'m')     
plot(grafFit2(1:200),'m')     
plot(grafFit3(1:200),'m')     
plot(grafFit4(1:200),'m')     
plot(grafFit5(1:200),'m')      

%vykreslenie najlepsej populacie
plot(grafFit(1:200),'b')

xlabel('Cykly');
ylabel('F(x)');

disp('Riesenie: ');
maxRet


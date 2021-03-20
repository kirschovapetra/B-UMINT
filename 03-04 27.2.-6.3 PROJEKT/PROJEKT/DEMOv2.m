%Demo pre stupnovu pokutu

cycles = 30000;
pop_size = 100;     %ocakava 100 - pri zmene upravit kazdy best_count
                    %a pocet zachovanych povodnych jedincov
Df = [zeros(1,5); 10000000*ones(1,5)];       %Df = <0,10 000 000>

Pop = genrpop(pop_size, Df);            %generovanie populacie - nahodne
Fit = investfn2(Pop);                   %vypocet fitness

[maxFit,indx]=max(Fit);                 % najlepsi - max retazec
maxRet=Pop(indx,:);

grafFit=zeros(1,cycles);

Amp = 100000*ones(1,5);
for i = 1:cycles
    best_count = 5;
    best_count2 = 3;
    best_count3 = 2;
    tourn_count = pop_size - best_count*2 - best_count2*2 - best_count3*2 - 10;      %necha 10 z povodnej
    
    BestPop = selbest(Pop,-Fit,[best_count best_count2 best_count3]);          %ulozim si najlepsie retazce - nebudem menit    
    BestPop2 = selbest(Pop,-Fit,[best_count best_count2 best_count3]);         %najlepsie retazce - budem menit
    TournPop = seltourn(Pop,Fit,tourn_count);               %nahodny vyber - budem menit
    
    ModifPop = [BestPop2;TournPop];               %modifikovane retazce = selbest+seltourn              
    ModifPop = crossov(ModifPop,1,0);             %krizenie
    ModifPop = mutx(ModifPop,0.5,Df);             %mutacia
                       
    ModifPop = muta(ModifPop,0.2,Amp, Df);    %aditivna mutacia
    
    Pop = [BestPop;ModifPop];            %novu populaciu tvoria najlepsie + modifikovane retazce
    
    Fit=investfn2(Pop);         %fitness 	
    [maxFitnew,indx]=max(Fit);  %hladanie maxima
    if maxFitnew>maxFit                     
        maxFit=maxFitnew;                        
        maxRet=Pop(indx,:);                 
    end
    grafFit(i)=maxFit;
end;

figure(1)   %1 graf
% plot(grafFit,'m')      % vykreslenie priebehu hladania
plot(grafFit(1:1000),'k','DisplayName','Stupnova pokuta')      % vykreslenie prvych 100 hodnot
hold on
xlabel('Cykly');
ylabel('F(x)');



disp('Riesenie: ');
maxFit
maxRet
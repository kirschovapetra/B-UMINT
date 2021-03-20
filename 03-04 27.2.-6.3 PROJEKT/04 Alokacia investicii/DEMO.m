%Demo pre mrtvu pokutu
%pre otestovanie ostatnych typov pokuty staci vo fitness funkcii investfn() 
%zmenit penalty(X) na penalty2(X)- stupnova resp. penalty3(X) - umerna miere porusenia

clear;

cycles = 20000;
pop_size = 100;                         %velkost populacie
Df = [zeros(1,5); 10000000*ones(1,5)];  %Df = <0,10 000 000>

Pop = genrpop(pop_size, Df);            %generovanie populacie - nahodne
Fit = investfn(Pop);                    %vypocet fitness

[maxFit,indx]=max(Fit);                 % najlepsi - max retazec
maxRet=Pop(indx,:);

grafFit=zeros(1,cycles);

Amp = 100000*ones(1,5);
for i = 1:cycles
    best_count = 5;
    best_count2 = 3;
    best_count3 = 2;
    tourn_count = pop_size - best_count*2 - best_count2*2 - best_count3*2 - 10;      
    
    %ulozime si najlepsie retazce - nebudeme menit 
    BestPop = selbest(Pop,-Fit,[best_count best_count2 best_count3]); 
    
    %najlepsie retazce - budeme menit
    BestPop2 = selbest(Pop,-Fit,[best_count best_count2 best_count3]);
    
    %nahodny vyber - budeme menit
    TournPop = seltourn(Pop,Fit,tourn_count);                          
    
    %modifikovane retazce = selbest+seltourn
    ModifPop = [BestPop2;TournPop];              
    ModifPop = crossov(ModifPop,1,0);     %krizenie
    ModifPop = mutx(ModifPop,0.5,Df);     %mutacia
                     
    ModifPop = muta(ModifPop,0.2,Amp, Df);  %aditivna mutacia
    
    %novu populaciu tvoria najlepsie + modifikovane retazce
    Pop = [BestPop;ModifPop];   
    
    Fit=investfn(Pop);                  %fitness 
    
    [maxFitnew,indx]=max(Fit);          %hladanie maxima
    if maxFitnew>maxFit                     
        maxFit=maxFitnew;                 
        maxRet=Pop(indx,:);                 
    end
    grafFit(i)=maxFit;
end;

figure(1)   %graf 1
% plot(grafFit,'m')      % vykreslenie celeho priebehu hladania
plot(grafFit(1:1000),'m','DisplayName','Death penalty') % vykreslenie prvych 1000 hodnot
hold on
xlabel('Cykly');
ylabel('F(x)');


disp('Riesenie: ');
maxFit
maxRet

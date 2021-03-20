% Demo pre pokutu umernu miere porusenia obmedzeni

cycles = 30000;
pop_size = 100;                         %velkost populacie
Df = [zeros(1,5); 10000000*ones(1,5)];  %Df = <0,10 000 000>

Pop = genrpop(pop_size, Df);            %generovanie populacie - nahodne
Fit = investfn3(Pop);                    %vypocet fitness

[maxFit,indx]=max(Fit);                 % najlepsi - max retazec
maxRet=Pop(indx,:);

grafFit=zeros(1,cycles);

Amp = 100000*ones(1,5);
for i = 1:cycles
    best_count = 5;
    best_count2 = 3;
    best_count3 = 2;
    tourn_count = pop_size - best_count*2 - best_count2*2 - best_count3*2 - 10;      
    
    %ulozim si najlepsie retazce - nebudem menit 
    BestPop = selbest(Pop,-Fit,[best_count best_count2 best_count3]); 
    
    %najlepsie retazce - budem menit
    BestPop2 = selbest(Pop,-Fit,[best_count best_count2 best_count3]);
    
    %nahodny vyber - budem menit
    TournPop = seltourn(Pop,Fit,tourn_count);                          
    
    %modifikovane retazce = selbest+seltourn
    ModifPop = [BestPop2;TournPop];              
    ModifPop = crossov(ModifPop,1,0);     %krizenie
    ModifPop = mutx(ModifPop,0.5,Df);     %mutacia
                     
    ModifPop = muta(ModifPop,0.2,Amp, Df);  %aditivna mutacia
    
    %novu populaciu tvoria najlepsie + modifikovane retazce
    Pop = [BestPop;ModifPop];   
    
    Fit=investfn3(Pop);                  %fitness 
    
    
    [maxFitnew,indx]=max(Fit);          %hladanie maxima
    if maxFitnew>maxFit                     
        maxFit=maxFitnew;                 
        maxRet=Pop(indx,:);                 
    end
    grafFit(i)=maxFit;
end;

figure(1)   %graf 1
plot(grafFit(1:1000),'b','DisplayName','Pokuta umerna...') % vykreslenie prvych 500 hodnot
hold on
xlabel('Cykly');
ylabel('F(x)');



disp('Riesenie: ');
maxFit
maxRet


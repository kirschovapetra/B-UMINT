% Nahodne hladanie minima Rastrigin funkcie
%==================================================
numcykle=1000;	% pocet cyklov hladania
lpop=30;        % velkost  populacie - kolko retazcov naraz testujem

Space=[ones(1,10)*(-5);ones(1,10)*5]; 	% rozsah prvkov v retazci Df = <-5,5>

% MAIN CYCLE
Pop=genrpop(lpop,Space);                % generovanie n- nahodnych retazcov 
Fit=testfn2s(Pop);                      % vypocet Rastrigin funkcie
[minFit,indx]=min(Fit);                 % najlepsi retazec
minRet=Pop(indx,:);
grafFit=zeros(1,numcykle);

for i=1:numcykle
    
    best_count = 2;
    best_count2 = 5;
    tourn_count = lpop - best_count - best_count2;
    
    BestPop = selbest(Pop,Fit,ones(1,best_count));          %ulozim si najlepsie retazce - nebudem menit    
    BestPop2 = selbest(Pop,Fit,ones(1,best_count));         %najlepsie retazce - budem menit
    TournPop = seltourn(Pop,Fit,tourn_count);               %nahodny vyber - budem menit
    
    ModifPop = [BestPop2;TournPop];               %modifikovane retazce = selbest+seltourn              
    ModifPop = crossov(ModifPop,1,0);             %krizenie
    ModifPop = mutx(ModifPop,0.2,Space);         %mutacia
    Amp = 0.1*ones(1,10);                         %vektor [0.1 0.1 .......]
    ModifPop = muta(ModifPop,0.2,Amp, Space);    %aditivna mutacia
    
    Pop = [BestPop;ModifPop];            %novu populaciu tvoria najlepsie + modifikovane retazce
    
    Fit=testfn2s(Pop);	   	
    [minFitnew,indx]=min(Fit);
    if minFitnew<minFit                     
        minFit=minFitnew;                 
        minRet=Pop(indx,:);                
      
    end
    grafFit(i)=minFit;          %do vektora sa zapise minimum v danej iteracii
end


figure(2)
plot(grafFit,'m-.','DisplayName','20%')      % vykreslenie priebehu hladania
hold on
xlabel('Cykly');
ylabel('F(x)');



disp('Riesenie: ');
minRet
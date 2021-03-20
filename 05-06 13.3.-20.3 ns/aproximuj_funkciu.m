% Príklad na aproximáciu nelin. funkcie pomocou NS typu
% MLP siet s 1 vstupom a 1 výstupom
clear
load datafun2

% vytvorenie štruktúry NS 
% 1 vstup - x suradnica
% 1 skrytá vrstva s poctom neurónov 25 s funkciou 'tansig'
% 1 výstup s funkciou 'purelin' - y suradnica
% trénovacia metóda - Levenberg-Marquardt
pocet_neuronov=25;
net=fitnet(pocet_neuronov);

% % vyber rozdelenia
% net.divideFcn='dividerand'; % náhodné rozdelenie
%  net.divideParam.trainRatio=0.6;
%  net.divideParam.valRatio=0;
%  net.divideParam.testRatio=0.4;

net.divideFcn='divideind';      % indexove
net.divideParam.trainInd=indx_train;
net.divideParam.valInd=[];
net.divideParam.testInd=indx_test;


% Nastavenie parametrov trénovania
net.trainParam.goal = 1e-7;     % Ukoncovacia podmienka na chybu
net.trainParam.show = 5;        % Frekvencia zobrazovania priebehu chyby trénovania 
net.trainParam.epochs =300;      % maximalny pocet trenovacich epoch

% Trénovanie NS
net=train(net,x,y);

% Simulácia výstupu NS
outnetsim = sim(net,x);

% vypocet chyby siete
SSE=sum((y-outnetsim).^2)
MSE=SSE/length(y)
MAEE = mae(y-outnetsim)

% Vykreslenie priebehov
figure(1)
plot(x,y,'k',x,outnetsim,'ro')





% Pr�klad na aproxim�ciu nelin. funkcie pomocou NS typu
% MLP siet s 1 vstupom a 1 v�stupom
clear
load datafun2

% vytvorenie �trukt�ry NS 
% 1 vstup - x suradnica
% 1 skryt� vrstva s poctom neur�nov 25 s funkciou 'tansig'
% 1 v�stup s funkciou 'purelin' - y suradnica
% tr�novacia met�da - Levenberg-Marquardt
pocet_neuronov=25;
net=fitnet(pocet_neuronov);

% % vyber rozdelenia
% net.divideFcn='dividerand'; % n�hodn� rozdelenie
%  net.divideParam.trainRatio=0.6;
%  net.divideParam.valRatio=0;
%  net.divideParam.testRatio=0.4;

net.divideFcn='divideind';      % indexove
net.divideParam.trainInd=indx_train;
net.divideParam.valInd=[];
net.divideParam.testInd=indx_test;


% Nastavenie parametrov tr�novania
net.trainParam.goal = 1e-7;     % Ukoncovacia podmienka na chybu
net.trainParam.show = 5;        % Frekvencia zobrazovania priebehu chyby tr�novania 
net.trainParam.epochs =300;      % maximalny pocet trenovacich epoch

% Tr�novanie NS
net=train(net,x,y);

% Simul�cia v�stupu NS
outnetsim = sim(net,x);

% vypocet chyby siete
SSE=sum((y-outnetsim).^2)
MSE=SSE/length(y)
MAEE = mae(y-outnetsim)

% Vykreslenie priebehov
figure(1)
plot(x,y,'k',x,outnetsim,'ro')





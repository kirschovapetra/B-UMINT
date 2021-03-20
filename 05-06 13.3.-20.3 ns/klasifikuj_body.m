clear
% suradnice x,y,z piatich skupin bodov
load databody

% vykreslenie bodov podla skupin
h=figure;
plot3(data1(:,1),data1(:,2),data1(:,3),'b+')
hold on
plot3(data2(:,1),data2(:,2),data2(:,3),'co')
plot3(data3(:,1),data3(:,2),data3(:,3),'g*')
plot3(data4(:,1),data4(:,2),data4(:,3),'r*')
plot3(data5(:,1),data5(:,2),data5(:,3),'mx')

axis([0 1 0 1 0 1])
title('Data body')
xlabel('x')
ylabel('y')
zlabel('z')

disp(' --------------- stlac klavesu --------------')
pause

% vstupne a vystupne data na trenovanie neuronovej siete
datainnet=[data1; data2; data3; data4; data5]'; %body
%do ktorej skupiny patria
dataoutnet=[ones(1,50) zeros(1,200);zeros(1,50) ones(1,50) zeros(1,150); zeros(1,100) ones(1,50) zeros(1,100);  ...
               zeros(1,150) ones(1,50) zeros(1,50);zeros(1,200) ones(1,50)];

% vytvorenie struktury siete
pocet_neuronov = 15;  % definujte pocet neuronov v skrytej vstve
net = patternnet(pocet_neuronov);

% parametre rozdelenia dat na trenovanie, validacne a testovanie
% net.divideFcn='dividerand';
% net.divideParam.trainRatio=0.6;
% net.divideParam.valRatio=0.2;
% net.divideParam.testRatio=0.2;

t1 = [1:30]';
t2 = [51:80]';
t3 = [101:130]';
t4 = [151:180]';
t5 = [201:230]';

train_ids = [t1;t2;t3;t4;t5]';

v1 = [31:40]';
v2 = [81:90]';
v3 = [131:140]';
v4 = [181:190]';
v5 = [231:240]';

val_ids = [v1;v2;v3;v4;v5]';

te1 = [41:50]';
te2 = [91:100]';
te3 = [141:150]';
te4 = [191:200]';
te5 = [241:250]';

test_ids = [te1;te2;te3;te4;te5]';

net.divideFcn='divideind';
net.divideParam.trainInd=train_ids; 
net.divideParam.valInd=val_ids;    
net.divideParam.testInd=test_ids;  


% nastavenie parametrov trenovania           
net.trainParam.goal = 1e-8;         % ukoncovacia podmienka na chybu
net.trainParam.show = 10;           % frekvencia zobrazovania chyby
net.trainParam.epochs = 200;        % maximalny pocet trenovacich epoch
net.trainParam.max_fail = 50;
net.trainParam.min_grad = 1e-8;


% trenovanie NS
net = train(net,datainnet,dataoutnet);

% zobrazenie struktury siete
view(net)

% simulacia vystupu NS pre trenovacie data
outnetsim = sim(net,datainnet);

% chyba NS a dat
err=(outnetsim-dataoutnet);

% percento neuspesne klasifikovanych bodov
y = net(datainnet);
[c,cm,ind,per] = confusion(dataoutnet,y);

% kontingenèná matica
figure
plotconfusion(dataoutnet,y)


% klasifikacia 5 novych bodov do tried
bodynew=[0.55 0.25 0.2;0.3 0.4 0.7;0.2 0.7 0.5;0.7 0.55 0.35;0.9 0.85 0.4];
outnetsimnew=sim(net,bodynew');
triedy = vec2ind(outnetsimnew);

figure(h)
farby='bcgrm';
for i=1:5
    plot3(bodynew(i,1),bodynew(i,2),bodynew(i,3),'ks','MarkerSize',10,'LineWidth',2)   
end
triedy
                
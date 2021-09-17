clear
% vysledky - matica 5x5
res = zeros(5,5);

% vstup zo suboru
file_input = importdata("data_letters.txt");  
data_letters = double(cell2mat(file_input.textdata));%prevod znaku do ascii
letters = 65:90; %ascii

% vstup = 16 parametrov, 20000 dat
datainnet = file_input.data';

% vystup = 26 pismen
dataoutnet = zeros(26,20000); 
for i = 1:26
    for j = 1:20000
        if letters(i)==data_letters(j)
            % "1" je tam, kde sa zhoduje pismeno z "letters" 
            % a pismeno zo vstupu
            dataoutnet(i,j) = 1; 
        end
    end
end

% krizova validacia
A = 1:4000;
B = 4001:8000;
C = 8001:12000;
D = 12001:16000;
E = 16001:20000;

% rozdelenie 1
train_ids1 = [A B C];
val_ids1 = D;
test_ids1 = E;

% rozdelenie 2
train_ids2 = [B D E];
val_ids2 = A;
test_ids2 = C;

% rozdelenie 3
train_ids3 = [A C D];
val_ids3 = E;
test_ids3 = B;

% rozdelenie 4
train_ids4 = [C D E];
val_ids4 = B;
test_ids4 = A;

% rozdelenie 5
train_ids5 = [A C E];
val_ids5 = C;
test_ids5 = D;
    
for b = 1:5
    for a = 1:5
        % vytvorenie struktury siete
        pocet_neuronov = 300;
        net = patternnet(pocet_neuronov);

        %indexove rozdelenie
        net.divideFcn='divideind';
        switch (a)
            case 1
                net.divideParam.trainInd=train_ids1; 
                net.divideParam.valInd=val_ids1;    
                net.divideParam.testInd=test_ids1;
            case 2
                net.divideParam.trainInd=train_ids2; 
                net.divideParam.valInd=val_ids2;    
                net.divideParam.testInd=test_ids2;
            case 3
                net.divideParam.trainInd=train_ids3; 
                net.divideParam.valInd=val_ids3;    
                net.divideParam.testInd=test_ids3;
            case 4
                net.divideParam.trainInd=train_ids4; 
                net.divideParam.valInd=val_ids4;    
                net.divideParam.testInd=test_ids4;
            case 5
                net.divideParam.trainInd=train_ids5; 
                net.divideParam.valInd=val_ids5;    
                net.divideParam.testInd=test_ids5;
        end

        % nastavenie parametrov trenovania           
        net.trainParam.goal = 1e-12;         % ukoncovacia podmienka na chybu
        net.trainParam.show = 10;            % frekvencia zobrazovania chyby
        net.trainParam.epochs = 1000;        % maximalny pocet trenovacich epoch
        net.trainParam.max_fail = 1000;      % maximalny pocet nespravnych validacii
        net.trainParam.min_grad = 1e-12;     % minimalny gradient

        % trenovanie NS
        net = train(net,datainnet,dataoutnet);

        % simulacia vystupu NS pre trenovacie data
        outnetsim = sim(net,datainnet);

        % percento neuspesne klasifikovanych bodov
        y = net(datainnet);
        [c,cm,ind,per] = confusion(dataoutnet,y);
        
        % vypocet uspesnosti        
        testarray = cm;
        diag = 0;
        for i = 1:26
            diag = diag+testarray(i,i);
        end
        all = 0;
        for i = 1:26
            for j = 1:26
                all = all+testarray(i,j);
            end
        end
        res(b,a) = (diag/all)*100;
    end
end
res
max_res = max(res)
min_res = min(res)
avg = sum(res)/5
overall_max_res = max(max_res)
overall_min_res = min(min_res)
overall_avg = sum(avg)/5


% test
datainnet_test = importdata("test_letters.txt");  
dataoutnet_test=sim(net,datainnet_test');

letters_test = char(vec2ind(dataoutnet_test)+64)
% program na hladanie kociek robotom v bludisku s prekazkami,
% robot ma 3 snimace prekazok (vpredu, vlavo, vpravo), otaca sa o 90stupnov
% vlavo alebo vpravo, ide iba dopredu
% cielom je najst vsetky kocky v bludisku, po najdeni kocky ju priniest do
% ciela do pozicie (40,40) 1. typ objektu, do pozicie (1,40) 2. typ objektu 

% toto riesenie obsahuje aj radar na hladanie kocky v def. okruhu, po
% najdeni kocky ju zoberie do ciela

%robot=[poziciaX poziciaY snimacLavo snimacPravo snimacVpred pohyb otocenie smer kocka prekazka cielx ciely offset_rand gain_rand]

% poziciaX - stlpec 1 az 40, poziciaY - riadok 1 az 40

% snimacLavo snimacPravo snimacVpred , 0-volne, 1-prekazka, 2-kocka,
% 3-iny robot

% pohyb , 0-stoji, 1-ide

% otocenie, 0-rovno, 1-doprava, 2-dolava

% smer, 1-hore, 2-dole, 3-doprava, 4-dolava

% kocka, 0-nema kocku,hlada ju, 1-nesie kocku na ciel (40,40), 2 - ide na
% definovany ciel

% prekazka, kde je prekazka 0-nie je, 1-hore, 2-dole, 3-doprava, 4-dolava,
% ak su zaporne hodnoty, prekazka je v cieli

% typ kocka , 1 - objekt 1. typu (napr. jablko, hruska), 2  - objekt 2. typu (napr. banan, pomaranc, citron)

% cielX - stlpec 1 az 40, cielY - riadok 1 az 40

% param1, param2 - parametre pre random hladanie

% hlavna funkcia
function [caszberu]=mainrobot(pocetkociek,pocetprekazok)

h1=figure;
zoznamkociek = [];

% definovanie color mapy 1-pozadie, 2-prekazka, 3-robot, 4-robot s kockou,
% 5- kocka 1 typ ,  6- kocka 2 typ,  7 - neodkryta mapa 
colormaprobot=[1 1 1;0 0 0;0 1 0;1 0 0;0 0 1;1 0 1;1 1 0];
mapa=ones(42);
mapa(1,:)=2;
mapa(42,:)=2;
mapa(:,1)=2;
mapa(:,42)=2;

% budovana mapa 1-pozadie, 2-prekazka, 3-robot, 4-robot s kockou,
% 5- kocka 1 typ ,  6- kocka 2 typ,  7 - neodkryta mapa 
mapazobraz=7*ones(42);
mapazobraz(1,:)=2;
mapazobraz(42,:)=2;
mapazobraz(:,1)=2;
mapazobraz(:,42)=2;

odkrytiemapy=zeros(42);

% definovanie prekazok
if pocetprekazok>0
mapa(2:5,8)=2;
mapa(6,8:10)=2;

mapa(2:7,23)=2;
mapa(8,19:23)=2;

mapa(34:41,28)=2;
mapa(34,25:28)=2;

mapa(34,10:12)=2;
mapa(35:41,10)=2;

mapa(20,32:41)=2;
mapa(18:22,32)=2;

mapa(22,12:20)=2;
mapa(19:25,16)=2;

end

stanicaX=40;
stanicaY=40;

pocetrobot=3;

% maximalny cas trvania simulacie
maxcashladania=120*pocetkociek;

% zoznam kociek
% 1-pozicia X, 2-pozicia Y, 3 - stav kocky, 4 - typ, 5 - parameter 1, 6 - parameter 2, 7 - parameter 3   
zoznamkociek=[];

% definovanie parametrov robota
roboti(1)=struct('poziciaX',1,'poziciaY',1,'snimacLavo',1,'snimacPravo',0,'snimacVpred',1,'pohyb',0,'otocenie',0, ...
        'smer',1,'kocka',0,'prekazka',0,'typkocka',1,'cielX',40,'cielY',40,'param1',10,'param2',40,'pocitadlo',0,'maxkrok',0,'bludenie',0);

% zakreslenie robota
mapa(2,2)=3;

if pocetrobot>1
    %roboti(2,:)=[1 40 1 0 0 0 0 1 0 0 40 40 3 20];
roboti(2)=struct('poziciaX',1,'poziciaY',40,'snimacLavo',1,'snimacPravo',0,'snimacVpred',0,'pohyb',0,'otocenie',0, ...
        'smer',1,'kocka',0,'prekazka',0,'typkocka',1,'cielX',40,'cielY',40,'param1',3,'param2',20,'pocitadlo',0,'maxkrok',0,'bludenie',0);
    
    mapa(41,2)=3;
    if pocetrobot>2
%        roboti(3,:)=[40 1 1 0 0 0 0 2 0 0 40 40 8 30];
roboti(3)=struct('poziciaX',40,'poziciaY',1,'snimacLavo',1,'snimacPravo',0,'snimacVpred',0,'pohyb',0,'otocenie',0, ...
        'smer',2,'kocka',0,'prekazka',0,'typkocka',1,'cielX',40,'cielY',40,'param1',8,'param2',30,'pocitadlo',0,'maxkrok',0,'bludenie',0);

        mapa(2,41)=3;
        pocetrobot=3;
    end
end

% parametre na nahodne hladanie
for ii=1:pocetrobot,
    roboti(ii).maxkrok=fix(40*rand);
end

khladaj=zeros(1,pocetrobot);
nahodahladaj=fix(40*rand(1,pocetrobot));
timeout=[0 0 0];

% definovanie pozicii kociek
kockypos=[4 11;15 22;23 18;25 35;37 16;37 5;10 6;22 8;35 32;8 32;15 35;12 15;30 20;12 28;20 25;33 3;28 9; ...
                14 9;4 21;4 28;38 24;12 38;28 14;3 16;17 13;26 4;26 26;5 6;16 5;29 31;38 12;32 36;38 20;3 35;10 11];
            
if pocetkociek>35
    pocetkociek=35;
end
indx=randperm(35);
for i=1:pocetkociek,
    if rand(1)>0.5
        mapa(kockypos(indx(i),1),kockypos(indx(i),2))=5;
    else
        mapa(kockypos(indx(i),1),kockypos(indx(i),2))=6;
    end
end

% pociatocne vykreslenie mapy
colormap(colormaprobot);
hmapa=image(mapa);
k=0;
pocetuloh=0;
title(['ulozene kocky = ' num2str(pocetuloh)])

% hlavny cyklus
while k<maxcashladania && pocetuloh~=pocetkociek;
    k=k+1;
    for rrob=1:pocetrobot,
        
        % vyber pixelov z mapy
        hp=mapa(roboti(rrob).poziciaY,roboti(rrob).poziciaX+1);
        dp=mapa(roboti(rrob).poziciaY+2,roboti(rrob).poziciaX+1);
        pp=mapa(roboti(rrob).poziciaY+1,roboti(rrob).poziciaX+2);
        vp=mapa(roboti(rrob).poziciaY+1,roboti(rrob).poziciaX);
        
        % nastavenie snimacov robota
        [vs,ps,hs]=nastavsnimace(roboti(rrob),hp,dp,pp,vp);
             
        roboti(rrob).snimacLavo=vs;
        roboti(rrob).snimacPravo=ps;
        roboti(rrob).snimacVpred=hs;
        
        % chod do stanice
        if roboti(rrob).kocka==1
            %novysmer=choddostanice(roboti(rrob));
            if roboti(rrob).typkocka==2
                roboti(rrob).cielX=40;
                roboti(rrob).cielY=1;
            else
                roboti(rrob).cielX=40;
                roboti(rrob).cielY=40;
            end
            [novysmer,novaprekazka]=chodnaciel(roboti(rrob));
            roboti(rrob).prekazka=novaprekazka;
            if novysmer>-1
                roboti(rrob).otocenie=novysmer;
                roboti(rrob).pohyb=1;
                timeout(rrob)=0;
            else
                if novaprekazka<0
                    roboti(rrob).otocenie=0;
                    roboti(rrob).prekazka=0;
                    roboti(rrob).smer=abs(novaprekazka);
                else
                
                    roboti(rrob).pohyb=0;
                    timeout(rrob)=timeout(rrob)+1;
                    if timeout(rrob)>3
                        if rem(roboti(rrob).smer,2)==1
                            roboti(rrob).smer=roboti(rrob).smer+1;
                        else
                            roboti(rrob).smer=roboti(rrob).smer-1;                   
                        end
                        timeout(rrob)=0;
                    end
                end
            end
            
        % chod na ciel    
        elseif roboti(rrob).kocka==2
            [novysmer,novaprekazka]=chodnaciel(roboti(rrob));
            roboti(rrob).prekazka=novaprekazka;
            if novysmer>-1
                roboti(rrob).otocenie=novysmer;
                roboti(rrob).pohyb=1;
                timeout(rrob)=0;
            else
                % ak je prekazka v cieli kocka, zober ju
                if novaprekazka<0
                    roboti(rrob).otocenie=0;
                    roboti(rrob).prekazka=0;
                    roboti(rrob).smer=abs(novaprekazka);
                else

                    roboti(rrob).pohyb=0;
                    if roboti(rrob).poziciaX==roboti(rrob).cielX && roboti(rrob).poziciaY==roboti(rrob).cielY
                        roboti(rrob).kocka=0;

                    end                  
                end
            end    
            
            % nahodne hladanie
        else
            [novysmer,kk,nahoda]=nahodnehladanie(roboti(rrob),khladaj(rrob),nahodahladaj(rrob));
            % nastavenie smeru
            if novysmer>-1
                roboti(rrob).otocenie=novysmer;
                roboti(rrob).pohyb=1;
            else
                roboti(rrob).pohyb=0;
                if rem(roboti(rrob).smer,2)==1
                    roboti(rrob).smer=roboti(rrob).smer+1;
                else
                    roboti(rrob).smer=roboti(rrob).smer-1;                   
                end
                
            end
            khladaj(rrob)=kk;
            nahodahladaj(rrob)=nahoda;
        end
        
        % nastav novu poziciu robota
        stareX=roboti(rrob).poziciaX;
        stareY=roboti(rrob).poziciaY;
        mapa(stareY+1,stareX+1)=1;

        noveX=stareX;
        noveY=stareY;
        
        % ak je robot v pohybe nastav smer cesty
        if roboti(rrob).pohyb==1
            [posX,posY,otoc]=nastavsmercesty(roboti(rrob));
            noveX=posX;
            noveY=posY;
            if otoc>0
                roboti(rrob).smer=otoc;
            end

        end
            
        roboti(rrob).poziciaX=noveX;
        roboti(rrob).poziciaY=noveY;
        
        % co vykona robot v jednotlivych stavoch
        [robotstav,nasielkocku,polozilkocku,zoznamkociek]=akciarobot(roboti(rrob),mapa,zoznamkociek,odkrytiemapy);
        roboti(rrob)=robotstav;
        
        % kontrola ci nahodou neprejde prekazku
        if mapa(roboti(rrob).poziciaY+1,roboti(rrob).poziciaX+1)==2
             noveX=stareX;
             noveY=stareY;
            roboti(rrob).poziciaX=noveX;
            roboti(rrob).poziciaY=noveY;
        end
        
        % zakreslenie novej pozicie robota
        if roboti(rrob).kocka==1 
            mapa(noveY+1,noveX+1)=4;
        else
            mapa(noveY+1,noveX+1)=3;
        end
        
        % prekreslenie mapy 
        figure(h1)
        set(hmapa,'CData',mapa)
 
        % vypisy do okna
        if nasielkocku==1
            title(['ulozene kocky = ' num2str(pocetuloh) ' cas [s] = ' num2str(k)])
        end
        if polozilkocku==1
               pocetuloh=pocetuloh+1;
               title(['ulozene kocky = ' num2str(pocetuloh) ' cas [s] = ' num2str(k)])
        end
        
        % na spomalenie priebehu simulacie
        pause(0.001)

    end
    
%     if rem(k,5)==0
%         figure(h2)
%         set(hmapa2,'CData',mapazobraz)        
%     end
        
end
caszberu=k;
end


















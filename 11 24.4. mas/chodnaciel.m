% funkcia pre riadenie robota do ciela
% novysmer , 0-rovno, 1-vpravo, 2-vlavo, -1 - bez zmeny
% prekazka - 0-nie je, 1-hore, 2-dole, 3-doprava, 4-dolava,
% ak su zaporne hodnoty, prekazka je v cieli
function [novysmer,prekazka]=chodnaciel(robot)
    
    % suradnice ciela robota
    xciel=robot.cielX;
    yciel=robot.cielY;
    
    % kde sa nachadza ciel od aktualnej pozicie robota, vlavo, vpravo, hore
    % dole
    if (xciel-robot.poziciaX)>0
        idevpravo=1;
    else
        idevpravo=0;
    end
    if (xciel-robot.poziciaX)<0
        idevlavo=1;
    else
        idevlavo=0;
    end
    if (yciel-robot.poziciaY)>0
        idedole=1;
    else
        idedole=0;
    end
    if (yciel-robot.poziciaY)<0
        idehore=1;
    else
        idehore=0;
    end

    novysmer=-1;
    prekazka=robot.prekazka;
    % ak nenarazil na prekazku
    if prekazka==0
        
        % ma ist smerom dole
        if idedole==1
           if robot.smer==2 && robot.snimacVpred==0
                novysmer=0;
           elseif robot.smer==3 && robot.snimacPravo==0    %ide vpravo, vpravo volno, otoc dole 
                novysmer=1;
           elseif robot.smer==4 && robot.snimacLavo==0
                novysmer=2;
           elseif robot.smer==1 
                if idevpravo==1 && robot.snimacPravo==0
                    novysmer=1;
                elseif idevlavo==1 && robot.snimacLavo==0
                    novysmer=2;
                end
           end
        end
    
    if novysmer==-1
        % ma ist smerom hore
        if idehore==1
           if robot.smer==1 && robot.snimacVpred==0
                novysmer=0;
           elseif robot.smer==3 && robot.snimacLavo==0    %ide vpravo, vpravo volno, otoc dole 
                novysmer=2;
           elseif robot.smer==4 && robot.snimacPravo==0
                novysmer=1;
           elseif robot.smer==2 
                if idevpravo==1 && robot.snimacLavo==0
                    novysmer=2;
                elseif idevlavo==1 && robot.snimacPravo==0
                    novysmer=1;
                end
           end            
        end
    end
                    
    if novysmer==-1
        % ma ist smerom vpravo
        if idevpravo==1
           if robot.smer==1 && robot.snimacPravo==0
                novysmer=1;
           elseif robot.smer==3 && robot.snimacVpred==0    %ide vpravo, vpravo volno, otoc dole 
                novysmer=0;
           elseif robot.smer==2 && robot.snimacLavo==0
                novysmer=2;
           elseif robot.smer==4 
                if idehore==1 && robot.snimacPravo==0
                    novysmer=1;
                elseif idedole==1 && robot.snimacLavo==0
                    novysmer=2;
                end
           end            
        end
    end
                
    if novysmer==-1
        % ma ist smerom vlavo
        if idevlavo==1
           if robot.smer==1 && robot.snimacLavo==0
                novysmer=2;
           elseif robot.smer==4 && robot.snimacVpred==0    %ide vpravo, vpravo volno, otoc dole 
                novysmer=0;
           elseif robot.smer==2 && robot.snimacPravo==0
                novysmer=1;
           elseif robot.smer==3 
                if idehore==1 && robot.snimacLavo==0
                    novysmer=2;
                elseif idedole==1 && robot.snimacPravo==0
                    novysmer=1;
                end
           end            
        end
    end
    
    % nie je mozny ziadny smer
    if novysmer==-1
        % ak nie je v cieli, tak nastav prekazku
        if xciel~=robot.poziciaX
            if idevpravo==1 && (xciel-robot.poziciaX)==1
                prekazka=-3;
            elseif idevpravo==1
                prekazka=3;
            elseif idevlavo==1 && (robot.poziciaX-xciel)==1
                prekazka=-4;                
            elseif idevlavo==1
                prekazka=4;
            end  
        elseif yciel~=robot.poziciaY
            if idehore==1 && (robot.poziciaY-yciel)==1
                prekazka=-1; 
            elseif idehore==1
                prekazka=1; 
            elseif idedole==1 && (yciel-robot.poziciaY)==1
                prekazka=-2;
            elseif idedole==1
                prekazka=2;
            end                       
        end        
    end
    
    % ak je prekazka, potom jej obchadzanie
    else
        
        % prekazka vpravo
        if prekazka==3 && yciel<21
           if robot.smer==3 && robot.snimacVpred~=0 && robot.snimacPravo~=0 && robot.snimacLavo==0 % ak ide doprava,prekazka vpredu a vpravo, vlavo volno otoc dolava hore
                novysmer=2;
           elseif robot.smer==3 && robot.snimacVpred~=0 && robot.snimacPravo==0 % ak ide doprava,prekazka vpredu , vpravo volno otoc doprava hole
                novysmer=1;                
           elseif robot.smer==2 && robot.snimacLavo~=0 && robot.snimacVpred==0 % ak ide dole,prekazka vlavo, vpred volno pokracuj rovno
                novysmer=0; 
           elseif robot.smer==2 && robot.snimacLavo~=0 && robot.snimacVpred~=0 % ak ide dole,prekazka vlavo a rovno, otoc vpravo
                novysmer=1;                 
           elseif robot.smer==2 && robot.snimacLavo==0 && robot.snimacVpred==0  % ak ide dole,prekazka vlavo a rovno nieje, otoc dolava
                novysmer=2;
           elseif robot.smer==2 && robot.snimacLavo==0 && robot.snimacVpred~=0 && robot.snimacPravo==0 % ak ide dole,prekazka rovno, vlavo a vpravo je volno, otoc doprava
                novysmer=1;               
           elseif robot.smer==4 && robot.snimacLavo~=0 && robot.snimacVpred==0 % ak ide dolava,prekazka vlavo, vpred je volno, chod rovno
                novysmer=0;
           elseif robot.smer==4 && robot.snimacLavo==0 % ak ide dolava, vlavo je volno, chod dolava
                novysmer=2;         
           elseif robot.smer==1 % ak ide dole, toc dolava
                novysmer=2;
           elseif robot.smer==3 && robot.snimacVpred==0 && robot.poziciaX<xciel % ak ide doprava, rovno je volno, este nie je v cieli, chod rovno a vypni obchadzanie prekazky  
                novysmer=0;
                prekazka=0;
           end               
           
        elseif prekazka==3 && yciel>20
           if robot.smer==3 && robot.snimacVpred~=0 && robot.snimacLavo~=0 && robot.snimacPravo==0 % ak ide doprava,prekazka vpredu a vlavo, vpravo volno otoc doprava dole
                novysmer=1;
           elseif robot.smer==3 && robot.snimacVpred~=0 && robot.snimacLavo==0 % ak ide doprava,prekazka vpredu , vlavo volno otoc dolava hole
                novysmer=2;                
           elseif robot.smer==1 && robot.snimacPravo~=0 && robot.snimacVpred==0 % ak ide hore,prekazka vpravo, vpred volno pokracuj rovno
                novysmer=0; 
           elseif robot.smer==1 && robot.snimacPravo~=0 && robot.snimacVpred~=0 % ak ide hore,prekazka vpravo a rovno, otoc vlavo
                novysmer=2;                 
           elseif robot.smer==1 && robot.snimacPravo==0 && robot.snimacVpred==0  % ak ide hore,prekazka vpravo a rovno nieje, otoc doprava
                novysmer=1;
           elseif robot.smer==1 && robot.snimacPravo==0 && robot.snimacVpred~=0 && robot.snimacLavo==0 % ak ide hore,prekazka rovno, vlavo a vpravo je volno, otoc dolava
                novysmer=2;               
           elseif robot.smer==4 && robot.snimacPravo~=0 && robot.snimacVpred==0 % ak ide dolava,prekazka vpravo, vpred je volno, chod rovno
                novysmer=0;
           elseif robot.smer==4 && robot.snimacPravo==0 % ak ide dolava, vpravo je volno, chod doprava
                novysmer=1;         
           elseif robot.smer==2 % ak ide dole, toc dolava
                novysmer=1;
           elseif robot.smer==3 && robot.snimacVpred==0 && robot.poziciaX<xciel % ak ide doprava, rovno je volno, este nie je v cieli, chod rovno a vypni obchadzanie prekazky  
                novysmer=0;
                prekazka=0;
           end               
        end
        
        % prekazka vlavo
        if prekazka==4 && yciel>20
           if robot.smer==4 && robot.snimacVpred~=0 && robot.snimacPravo~=0 && robot.snimacLavo==0 % ak ide doprava,prekazka vpredu a vpravo, vlavo volno otoc dolava hore
                novysmer=2;
           elseif robot.smer==4 && robot.snimacVpred~=0 && robot.snimacPravo==0 % ak ide doprava,prekazka vpredu , vpravo volno otoc doprava hole
                novysmer=1;                
           elseif robot.smer==1 && robot.snimacLavo~=0 && robot.snimacVpred==0 % ak ide dole,prekazka vlavo, vpred volno pokracuj rovno
                novysmer=0; 
           elseif robot.smer==1 && robot.snimacLavo~=0 && robot.snimacVpred~=0 % ak ide dole,prekazka vlavo a rovno, otoc vpravo
                novysmer=1;                 
           elseif robot.smer==1 && robot.snimacLavo==0 && robot.snimacVpred==0  % ak ide dole,prekazka vlavo a rovno nieje, otoc dolava
                novysmer=2;
           elseif robot.smer==1 && robot.snimacLavo==0 && robot.snimacVpred~=0 && robot.snimacPravo==0 % ak ide dole,prekazka rovno, vlavo a vpravo je volno, otoc doprava
                novysmer=1;               
           elseif robot.smer==3 && robot.snimacLavo~=0 && robot.snimacVpred==0 % ak ide dolava,prekazka vlavo, vpred je volno, chod rovno
                novysmer=0;
           elseif robot.smer==3 && robot.snimacLavo==0 % ak ide dolava, vlavo je volno, chod dolava
                novysmer=2;         
           elseif robot.smer==2 % ak ide dole, toc dolava
                novysmer=2;
           elseif robot.smer==4 && robot.snimacVpred==0 && robot.poziciaX>xciel % ak ide doprava, rovno je volno, este nie je v cieli, chod rovno a vypni obchadzanie prekazky  
                novysmer=0;
                prekazka=0;
           end               
           
        elseif prekazka==4 && yciel<21
           if robot.smer==4 && robot.snimacVpred~=0 && robot.snimacLavo~=0 && robot.snimacPravo==0 % ak ide doprava,prekazka vpredu a vlavo, vpravo volno otoc doprava dole
                novysmer=1;
           elseif robot.smer==4 && robot.snimacVpred~=0 && robot.snimacLavo==0 % ak ide doprava,prekazka vpredu , vlavo volno otoc dolava hole
                novysmer=2;                
           elseif robot.smer==2 && robot.snimacPravo~=0 && robot.snimacVpred==0 % ak ide hore,prekazka vpravo, vpred volno pokracuj rovno
                novysmer=0; 
           elseif robot.smer==2 && robot.snimacPravo~=0 && robot.snimacVpred~=0 % ak ide hore,prekazka vpravo a rovno, otoc vlavo
                novysmer=2;                 
           elseif robot.smer==2 && robot.snimacPravo==0 && robot.snimacVpred==0  % ak ide hore,prekazka vpravo a rovno nieje, otoc doprava
                novysmer=1;
           elseif robot.smer==2 && robot.snimacPravo==0 && robot.snimacVpred~=0 && robot.snimacLavo==0 % ak ide hore,prekazka rovno, vlavo a vpravo je volno, otoc dolava
                novysmer=2;               
           elseif robot.smer==3 && robot.snimacPravo~=0 && robot.snimacVpred==0 % ak ide dolava,prekazka vpravo, vpred je volno, chod rovno
                novysmer=0;
           elseif robot.smer==3 && robot.snimacPravo==0 % ak ide dolava, vpravo je volno, chod doprava
                novysmer=1;         
           elseif robot.smer==1 % ak ide dole, toc dolava
                novysmer=1;
           elseif robot.smer==4 && robot.snimacVpred==0 && robot.poziciaX>xciel % ak ide doprava, rovno je volno, este nie je v cieli, chod rovno a vypni obchadzanie prekazky  
                novysmer=0;
                prekazka=0;
           end               
           
        end

        % prekazka hore
        if prekazka==1      %&& xciel>20
           if robot.smer==1 && robot.snimacVpred~=0 && robot.snimacLavo~=0 && robot.snimacPravo==0 % ak ide doprava,prekazka vpredu a vpravo, vlavo volno otoc dolava hore
                novysmer=1;
           elseif robot.smer==1 && robot.snimacVpred~=0 && robot.snimacLavo==0 % ak ide doprava,prekazka vpredu , vpravo volno otoc doprava hole
                novysmer=2;                
           elseif robot.smer==4 && robot.snimacPravo~=0 && robot.snimacVpred==0 % ak ide dole,prekazka vlavo, vpred volno pokracuj rovno
                novysmer=0; 
           elseif robot.smer==4 && robot.snimacPravo~=0 && robot.snimacVpred~=0 % ak ide dole,prekazka vlavo a rovno, otoc vpravo
                novysmer=2;                 
           elseif robot.smer==4 && robot.snimacPravo==0 && robot.snimacVpred==0  % ak ide dole,prekazka vlavo a rovno nieje, otoc dolava
                novysmer=1;
           elseif robot.smer==4 && robot.snimacLavo==0 && robot.snimacVpred~=0 && robot.snimacPravo==0 % ak ide dole,prekazka rovno, vlavo a vpravo je volno, otoc doprava
                novysmer=2;               
           elseif robot.smer==2 && robot.snimacPravo~=0 && robot.snimacVpred==0 % ak ide dolava,prekazka vlavo, vpred je volno, chod rovno
                novysmer=0;
           elseif robot.smer==2 && robot.snimacPravo==0 % ak ide dolava, vlavo je volno, chod dolava
                novysmer=1;         
           elseif robot.smer==3 % ak ide dole, toc dolava
                novysmer=1;
           elseif robot.smer==1 && robot.snimacVpred==0 && robot.poziciaY>yciel % ak ide doprava, rovno je volno, este nie je v cieli, chod rovno a vypni obchadzanie prekazky  
                novysmer=0;
                prekazka=0;
           end               
                     
        end

        % prekazka dole
        if prekazka==2  %&& xciel>20
           if robot.smer==2 && robot.snimacVpred~=0 && robot.snimacPravo~=0 && robot.snimacLavo==0 % ak ide doprava,prekazka vpredu a vpravo, vlavo volno otoc dolava hore
                novysmer=2;
           elseif robot.smer==2 && robot.snimacVpred~=0 && robot.snimacPravo==0 % ak ide doprava,prekazka vpredu , vpravo volno otoc doprava hole
                novysmer=1;                
           elseif robot.smer==4 && robot.snimacLavo~=0 && robot.snimacVpred==0 % ak ide dole,prekazka vlavo, vpred volno pokracuj rovno
                novysmer=0; 
           elseif robot.smer==4 && robot.snimacLavo~=0 && robot.snimacVpred~=0 % ak ide dole,prekazka vlavo a rovno, otoc vpravo
                novysmer=1;                 
           elseif robot.smer==4 && robot.snimacLavo==0 && robot.snimacVpred==0  % ak ide dole,prekazka vlavo a rovno nieje, otoc dolava
                novysmer=2;
           elseif robot.smer==4 && robot.snimacLavo==0 && robot.snimacVpred~=0 && robot.snimacPravo==0 % ak ide dole,prekazka rovno, vlavo a vpravo je volno, otoc doprava
                novysmer=1;               
           elseif robot.smer==1 && robot.snimacLavo~=0 && robot.snimacVpred==0 % ak ide dolava,prekazka vlavo, vpred je volno, chod rovno
                novysmer=0;
           elseif robot.smer==1 && robot.snimacLavo==0 % ak ide dolava, vlavo je volno, chod dolava
                novysmer=2;         
           elseif robot.smer==3 % ak ide dole, toc dolava
                novysmer=2;
           elseif robot.smer==2 && robot.snimacVpred==0 && robot.poziciaY<yciel % ak ide doprava, rovno je volno, este nie je v cieli, chod rovno a vypni obchadzanie prekazky  
                novysmer=0;
                prekazka=0;
           end               
                     
        end        
        
        
    end
               
end


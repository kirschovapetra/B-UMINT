
% funkcia na nahodne prehladavanie
% novysmer , 0-rovno, 1-vpravo, 2-vlavo, -1 - bez zmeny
% kki, kko - pocitadlo
% nahodai, nahodao - kedy ma byt vykonana zmena smeru 
function [novysmer,kko,nahodao]=nahodnehladanie(robot,kki,nahodai)
        if robot.snimacPravo==2  % ak je vpravo kocka, chod doprava
           novysmer=1;
        elseif robot.snimacLavo==2  % ak je vlavo kocka, chod dolava
           novysmer=2; 
        elseif robot.snimacVpred==0 || robot.snimacVpred==2 % ak je rovno kocka alebo volno chod rovno
           novysmer=0;
        elseif robot.snimacVpred~=0 && robot.snimacPravo==0 && robot.snimacLavo==0 % ak je rovno prekazka, vpravo aj vlavo volno, vyber si vlavo alebo vpravo
           if rand<0.4
               novysmer=2;
           else
               novysmer=1;
           end
        elseif robot.snimacVpred~=0 && robot.snimacPravo==0   % ak je rovno prekazka, vpravo  volno, chod vpravo
           novysmer=1;
        elseif robot.snimacVpred~=0 && robot.snimacLavo==0
           novysmer=2;
        else
            novysmer=-1;
        end
        
        % nahodna zmena smeru
        if kki==nahodai 
           % ak ide rovno, zmen smer 
           if novysmer==0 && robot.snimacVpred~=2
               % ak je vlavo volno, chod vlavo
               if robot.snimacLavo==0
                  novysmer=2;
               elseif robot.snimacPravo==0  % ak je vpravo volno, chod vpravo
                  novysmer=1;
               end
           end
           % nahodne generovanie casu na zmenu smeru
           nahodai=fix(robot.param2*rand+robot.param1);
           kko=0;
        else
            kko=kki+1;
        end
        nahodao=nahodai;     
end



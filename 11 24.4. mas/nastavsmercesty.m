% funkcia na nastavenie smeru cesty, podla toho ktorym smerom je otoceny
% vypocita poziciu robota a ktorym smerom sa ma otocit
function [posX,posY,otoc]=nastavsmercesty(robot)
    stareX=robot.poziciaX;
    stareY=robot.poziciaY;
    posX=robot.poziciaX;
    posY=robot.poziciaY;
    otoc=0;
    % nastavenie smeru cesty
    if robot.pohyb==1
        if robot.otocenie==0 && robot.smer==1 % hore
            posX=stareX;
            posY=stareY-1;
        elseif robot.otocenie==0 && robot.smer==2 % dole
            posX=stareX;
            posY=stareY+1;
        elseif robot.otocenie==0 && robot.smer==3 % vpravo
            posX=stareX+1;
            posY=stareY;
        elseif robot.otocenie==0 && robot.smer==4 % vlavo
            posX=stareX-1;
            posY=stareY;
            
        elseif robot.otocenie==1 && robot.smer==1 % otocenie vpravo
            posX=stareX+1;
            posY=stareY;
            otoc=3;
         elseif robot.otocenie==1 && robot.smer==3 % otocenie dole
            posX=stareX;
            posY=stareY+1;
            otoc=2;
         elseif robot.otocenie==1 && robot.smer==2 % otocenie vlavo
            posX=stareX-1;
            posY=stareY;
            otoc=4;
         elseif robot.otocenie==1 && robot.smer==4 % otocenie hore
            posX=stareX;
            posY=stareY-1;
            otoc=1;
            
        elseif robot.otocenie==2 && robot.smer==1 % otocenie vlavo
            posX=stareX-1;
            posY=stareY;
            otoc=4;
         elseif robot.otocenie==2 && robot.smer==3 % otocenie hore
            posX=stareX;
            posY=stareY-1;
            otoc=1;
         elseif robot.otocenie==2 && robot.smer==2 % otocenie vpravo
            posX=stareX+1;
            posY=stareY;
            otoc=3;
         elseif robot.otocenie==2 && robot.smer==4 % otocenie dole
            posX=stareX;
            posY=stareY+1;
            otoc=2;
        end
    end
    if posY<1
        posY=1;
    end
    if posX<1
        posX=1;
    end    
    if posX>40
        posX=40;
    end    
    if posY>40
        posY=40;
    end 

end


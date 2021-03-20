% funkcia, ktora vrati parametre objektu a jeho typ 
function [typkocky,paramkocky]=citajparamkocky(mapab,posX,posY)

pd=[0.91 0.07 0.91 0.03 0.5 0.4;0.75 0.15 0.77 0.06 0.57 0.27; ...
0.33 0.23 0.3 0.2 0.75 0.15;0.73 0.08 0.92 0.03 0.47 0.18;0.5 0.15 0.83 0.08 0.7 0.13];

paramkocky=zeros(1,3);

            % doplnit rozpoznavanie pomocou NS
            if mapab(posY+1,posX+1)==6
               typkocky=2;
               druh=fix(3*rand(1))+3;
            else
               typkocky=1;
               druh=fix(3*rand(1))+1;

            end
            
            for i=1:3
                  paramkocky(i)=pd(druh,2*(i-1)+1)+2*pd(druh,2*(i-1)+2)*rand(1)-pd(druh,2*(i-1)+2); 
            end
end


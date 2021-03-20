% nastavenie stavu snimacov, podla pixelov v mape
function [vs,ps,hs]=nastavsnimace(robot,horepole,dolepole,vpravopole,vlavopole)
    
    % smer hore
    if robot.smer==1 
        if horepole==2
            hs=1;
        elseif horepole==5 || horepole==6
            hs=2;  
        elseif horepole==3 || horepole==4
            hs=3;               
        else
            hs=0;            
        end
        if vlavopole==2
            vs=1;
        elseif vlavopole==5 || vlavopole==6
            vs=2;
        elseif vlavopole==3 || vlavopole==4
            vs=3;                                                           
        else
            vs=0;                      
        end
        if vpravopole==2
            ps=1;
        elseif vpravopole==5 || vpravopole==6
            ps=2;                                                 
        elseif vpravopole==3 || vpravopole==4
            ps=3;                                                           
        else
            ps=0;                      
        end
        
    end
    % smer dole
    if robot.smer==2
        if dolepole==2
            hs=1;
        elseif dolepole==5 || dolepole==6
            hs=2;
        elseif dolepole==3 || dolepole==4
            hs=3;                                                           
        else
            hs=0;            
        end
        if vpravopole==2
            vs=1;
        elseif vpravopole==5 || vpravopole==6
            vs=2;    
        elseif vpravopole==3 || vpravopole==4
            vs=3;                                               
        else
            vs=0;                      
        end
        if vlavopole==2
            ps=1;
        elseif vlavopole==5 || vlavopole==6
            ps=2;
        elseif vlavopole==3 || vlavopole==4
            ps=3;                                               
        else
            ps=0;                      
        end
        
    end
     % smer vpravo
    if robot.smer==3
        if vpravopole==2
            hs=1;
        elseif vpravopole==5 || vpravopole==6
            hs=2;
        elseif vpravopole==3 || vpravopole==4
            hs=3;                                   
        else
            hs=0;            
        end
        if horepole==2
            vs=1;
        elseif horepole==5 || horepole==6
            vs=2;
        elseif horepole==3 || horepole==4
            vs=3;                                                           
        else
            vs=0;                      
        end
        if dolepole==2
            ps=1;
        elseif dolepole==5 || dolepole==6
            ps=2;
        elseif dolepole==3 || dolepole==4
            ps=3;                                               
        else
            ps=0;                      
        end
        
    end
     % smer vlavo
    if robot.smer==4
        if vlavopole==2
            hs=1;
        elseif vlavopole==5 || vlavopole==6
            hs=2;
        elseif vlavopole==3 || vlavopole==4
            hs=3;                       
        else
            hs=0;            
        end
        if dolepole==2
            vs=1;
        elseif dolepole==5 || dolepole==6
            vs=2;  
        elseif dolepole==3 || dolepole==4
            vs=3;                                   
        else
            vs=0;                      
        end
        if horepole==2
            ps=1;
        elseif horepole==5 || horepole==6
            ps=2;
        elseif horepole==3 || horepole==4
            ps=3;                                               
        else
            ps=0;                      
        end
        
    end
 
end


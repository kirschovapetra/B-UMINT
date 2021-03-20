% fukcia, ktora riesi akcie, co sa robot robit v urcitych stavoch
% robot - struktura robota
% mapab - aktualna mapa bludiska
% zkvstup - zoznam najdenych kociek
% odkrytiemapy1 - kde uz bol

function [robotupdate,nasielkocku,polozilkocku,zkvystup]=akciarobot(robot,mapab,zkvstup,odkrytiemapy1)
    dosahradaru=3;
    nasielkocku=0;
    polozilkocku=0;
    zkvystup = zkvstup;    
    
    % ak nasiel kocku, nastav stav zober kocku
    if mapab(robot.poziciaY+1,robot.poziciaX+1)==5 || mapab(robot.poziciaY+1,robot.poziciaX+1)==6
        robot.kocka=1;
        robot.smer=2;
        robot.otocenie=0;
        nasielkocku=1;
        robot.typkocka=1; 
        
        zkvystup = pridajKocky([robot.poziciaY,robot.poziciaX,robot.typkocka,1],zkvystup);
        zkvystup = zmenFlag(0,zkvystup,robot.poziciaX,robot.poziciaY);
    end;
    
        

    % ak nesie kocku
    if robot.kocka==1
       [najdenepozkocky]=najdikocku(robot,mapab,dosahradaru);
       if ~isempty(najdenepozkocky)
            %prida sa do zoznamu    
           kockynazapis = pridajFlag(najdenepozkocky);  
           zkvystup = pridajKocky(kockynazapis,zkvystup);  
       end;

       % ak priniesol kocku do ciela
        if robot.typkocka==1
            if robot.poziciaX==40 && robot.poziciaY==40
                robot.kocka=0;
                polozilkocku=1;
            end;
        elseif robot.typkocka==2
            if robot.poziciaX==40 && robot.poziciaY==1
                robot.kocka=0;
                polozilkocku=1;
            end;               
        end;
    end;

    % ak nema kocku
    if robot.kocka==0
        [volnaKocka,id] = najdiVolnuKocku(zkvystup);
        
        if (isempty(volnaKocka))
            %nahodne
            [najdenepozkocky]=najdikocku(robot,mapab,dosahradaru);
            %ak najde kocku nastavi ciel na jej poziciu
            if ~isempty(najdenepozkocky)
                robot.cielX=najdenepozkocky(1,2);
                robot.cielY=najdenepozkocky(1,1);
                robot.kocka=2; 
                %oznaci sa ako obsadena                 
                zkvystup = zmenFlag(0,zkvystup,robot.cielX,robot.cielY);
            end;
        else 
            robot.cielX=volnaKocka(2);
            robot.cielY=volnaKocka(1);
            robot.kocka=2;
            %oznaci sa ako obsadena                 
            zkvystup = zmenFlag(0,zkvystup,robot.cielX,robot.cielY);
        end;  
    end;   
    
    if (robot.kocka == 2)
        if (~kockaJeVolna(zkvystup,robot.cielX,robot.cielY))
            robot.kocka = 0;
        end;
    end;
    
    robotupdate=robot;
end

        


% funkcia na prehladanie okolia robota radarom
% vrati pozicie kociek [Y X] - [riadok stlpec] v mape
function [novapozkocky]=najdikocku(robot,celamapa,dosahsenzora)
    % def. rozsahu senzora
    rmin=robot.poziciaY-dosahsenzora+1;
    rmax=robot.poziciaY+dosahsenzora+1;
    smin=robot.poziciaX-dosahsenzora+1;
    smax=robot.poziciaX+dosahsenzora+1;
    
    % ohranicenie mapy
    if rmin<2
        rmin=2;
    end
    if smin<1
        smin=1;
    end
    if rmax>41
        rmax=41;
    end
    if smax>41
        smax=41;
    end
    
    % ohranicenie prekazkov, radar cez prekaz nevidi
    ss=robot.poziciaX+1;
    for rr=rmin:robot.poziciaY+1,
        if celamapa(rr,ss)==2
            rmin=rr;
            break;
        end
    end
    rr=robot.poziciaY+1;
    for ss=smin:robot.poziciaX+1,
        if celamapa(rr,ss)==2
            smin=ss;
            break;
        end
    end
    ss=robot.poziciaX+1;
    for rr=robot.poziciaY+1:rmax,
        if celamapa(rr,ss)==2
            rmax=rr;
            break;
        end
    end
    rr=robot.poziciaY+1;
    for ss=robot.poziciaX+1:smax,
        if celamapa(rr,ss)==2
            smax=ss;
            break;
        end
    end    
    novapozkocky=[];
    
    % hladanie kocky v ohranicenom priestore
    for rr=rmin:rmax,
        for ss=smin:smax,
            if celamapa(rr,ss)==5
                novapozkocky=[novapozkocky;rr-1 ss-1 1];
            elseif celamapa(rr,ss)==6
                novapozkocky=[novapozkocky;rr-1 ss-1 2];
            end
        end
    end
            
end


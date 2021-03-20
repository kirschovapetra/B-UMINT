function [jeVolna] = kockaJeVolna(zoznamKociek,x,y)
    [rows,cols] = size(zoznamKociek);
    jeVolna = 1;
    for (i = 1:rows)
        if (zoznamKociek(i,1)==y & zoznamKociek(i,2)==x & zoznamKociek(i,4)==0)
                jeVolna = 0;
        end;
    end;
end



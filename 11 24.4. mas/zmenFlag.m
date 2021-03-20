function [novyZoznamKociek] = zmenFlag(hodnota,zoznamKociek,X,Y)
    [rows,cols] = size(zoznamKociek);
    novyZoznamKociek = zoznamKociek;
    for (i = 1:rows)
        if (novyZoznamKociek(i,1)==Y & novyZoznamKociek(i,2)==X)
            novyZoznamKociek(i,4) = hodnota;
        end;
    end;
end


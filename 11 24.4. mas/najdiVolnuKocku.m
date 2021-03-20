function [kocka,id] = najdiVolnuKocku(zoznamKociek)
    [rows, cols] = size(zoznamKociek);
%     defaultne hodnoty
    kocka = [];
    id = -1;
    
    if (rows==1)
        if (zoznamKociek(4)==1)
            kocka = zoznamKociek;
            id = 1;
        end;
    else
        for (i = 1:rows)
            if (zoznamKociek(i,4)==1)
                kocka = zoznamKociek(i,:);
                id = i;
                return;
            end;
        end;
    end;
end


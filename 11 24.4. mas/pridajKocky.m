function [zoznamKociekOut] = pridajKocky(kocky,zoznamKociek)
    zoznamKociekOut = zoznamKociek;
%     velkost celeho zoznamu
    [ZKrows, ZKcols] = size(zoznamKociek);
%     velkost zoznamu najdenych kociek
    [Krows,Kcols] = size(kocky);
%     predpoklad, ze sa daju zapisat vsetky
    canWrite = ones(Krows,1);
    
    for j = 1:Krows
        for i = 1:ZKrows
%             kocka sa nasla v zozname a je volna
            if (zoznamKociek(i,1)==kocky(j,1) & zoznamKociek(i,2)==kocky(j,2))
               canWrite(j) = 0;
            end;
        end;
    end;
    
    for i = 1:length(canWrite)
%         do zoznamu sa doplnia len tie, ktore mozeme zapisat
        if (canWrite(i) == 1)
            zoznamKociekOut = [zoznamKociekOut;kocky(j,:)];
        end;
    end;
end


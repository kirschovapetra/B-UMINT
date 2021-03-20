%stupnova pokuta
function [Pen] = penalty2(X)
    B = bounds_lines(X);        %obmedzenia
    n = sum(B>0);               %pocet prvkov vektora B, ktore su > 0
                                %teda pocet porusenych obmedzeni                         
    Pen = -3000000*n;
end


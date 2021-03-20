%pokuta umerna miere porusenia obmedzeni
function [Pen] = penalty3(X)
    B = bounds_lines(X);        %obmedzenia
    Pen = 0;
    Exp = 1000;
    if (B(1)>0)                 %porusene 1. obmedzenie
        Pen = Pen - B(1)^Exp;
    end
    if (B(2)>0)                 %porusene 2. obmedzenie
        Pen = Pen - B(2)^Exp;
    end
    if (B(3)>0)                 %porusene 3. obmedzenie
        Pen = Pen - B(3)^Exp;
    end
    if (B(4)>0)                 %porusene 4. obmedzenie
        Pen = Pen - B(4)^Exp;
    end     
end


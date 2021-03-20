%mrtva pokuta
function [Pen] = penalty(X)
    B = bounds_lines(X); %ohranicenia
    if (all(B<=0))
        Pen = 0;
    else
        Pen = -10000000;
    end;   
end

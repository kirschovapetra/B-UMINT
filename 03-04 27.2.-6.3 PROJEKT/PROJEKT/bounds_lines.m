function [B] = bounds_lines(X) 
    %vsetko musi byt <=0 
    B(1) = X(1)+X(2)+X(3)+X(4)+X(5)-10000000;
    B(2) = X(1)+X(2)-2500000;
    B(3)= -X(4)+X(5);
    B(4) = -0.5*X(1)-0.5*X(2)+0.5*X(3)+0.5*X(4)- 0.5*X(5);
end


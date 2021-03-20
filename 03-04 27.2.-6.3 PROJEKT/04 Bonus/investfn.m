%Fitness pre mtrvu pokutu
function[Fit]=investfn(Pop)
    [lpop,lstring]=size(Pop);   %velkost populacie                                 
    
    for i = 1:lpop
        X = Pop(i,:);         %jeden retazec
        Fit(i) = 0.04*X(1)+0.07*X(2)+0.11*X(3)+0.06*X(4)+0.05*X(5)+penalty(X);
    end
end





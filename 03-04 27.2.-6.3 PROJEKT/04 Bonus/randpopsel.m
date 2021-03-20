function [subpop] = randpopsel(Pop)
a=1;
b=100;
    for i = 1:20
        r = ceil((b-a)*rand() + a);
        if r > 100
            r = r-1;
        end
        subpop(i,:) = Pop(r,:);
    end
end


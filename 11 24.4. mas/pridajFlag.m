%0 = nie je dostupna, 1 = je dostupna 
function [kockynazapis] = pridajFlag(najdenepozkocky)
    [rows,cols] = size(najdenepozkocky);
    kockynazapis = [najdenepozkocky ones(rows,1)];
end


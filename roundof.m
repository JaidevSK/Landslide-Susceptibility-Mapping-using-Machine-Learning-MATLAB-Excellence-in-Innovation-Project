function[val] = roundof(ipval)
    if ipval >= 4.5
        val = 5;
    elseif ipval >= 3.5 & ipval<4.5
        val = 4;
    elseif ipval >=2.5 & ipval < 3.5
        val = 3;
    elseif ipval >=1.5 & ipval<2.5
        val = 2;
    else 
        val = 1;
    end
end
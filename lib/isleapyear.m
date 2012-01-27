function A = isleapyear(year)
%Checks if a given year is a leap year or not

A = false;

if mod(year,4) == 0
    if mod(year,100) == 0
        if mod(year,400) == 0
            A = true;
        end
    end
end

end


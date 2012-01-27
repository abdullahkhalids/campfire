function decimal = deg2dec(degrees)
%Given an array with the first element in degrees (hours), the second in
%minutes and the so on, with relative differences of 1/60, converts to the
%corresponding seconds form

decimal = sum(degrees.*(1/60).^(0:length(degrees)-1));


end


function temperature = AmbientTemperature(date,time)
%Find temperature for date and time

monthlyTemp =[18 22 27 34 39 38 35 34 34 32 27 21]+273.16; 

temperature = monthlyTemp(date(2));

end


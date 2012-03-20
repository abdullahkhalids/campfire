function temperature = AmbientTemperature(location)
%Find temperature for date and time

temperature = location.monthlyTemperatures(location.date(2));

end


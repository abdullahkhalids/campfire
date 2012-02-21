function intensity = SolarIntensity(date,time)
%Given a date, computes the solar intensity for that date and time

monthlyIntensities = [180.96 221.22 238.40 272.16 281.71 297.76 266.31 246.74 270.63 235.60 201.71 169.01]*3.155;

intensity = monthlyIntensities(date(2));

end


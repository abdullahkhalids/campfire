function [alpha,beta,daytime,S] = SunAngles(time,date,latitude,longitude,timezoneLongitude)
%Computes the position of the sun given the time,date,and location
%time is in the 24 hour clock, in the form [hour min seconds] or just
%hours.
%date is in the format [day month], or just day of the year
%location is in latitude and longitude, with each either a single number of
%an array with each elemement given the degrees,min,seconds etc.


%Get the decimal time
if length(time)>1
    time = deg2dec(time);
end

%Get the day of the year
if length(date)>1
    date = date2day(date(1),date(2));
end

%Get the location
if length(latitude)>1
    latitude = deg2dec(latitude);
end

if length(longitude)>1
    longitude = deg2dec(longitude);
end

%Compute the solar declination
solarDeclination = 23.45*sind(360/365*(284+date));

%Get decimal date
dateDec = date + time/24;

%Calculate the hour angle
x = 360/365.242*(dateDec - 1);

%Corrections to solar time
EOT = 0.258*cosd(x) - 7.146*sind(x) - 3.648*cosd(2*x) - 9.228*sind(2*x);
%Longitude correction
LongitudeCorrection = 4*(timezoneLongitude - longitude);
%Correction in hours
Correction = (EOT + LongitudeCorrection)/60;

solarTime = time + Correction;

hourAngle = 15*(solarTime - 12);

%Compute sun angles
alpha = atand((cosd(solarDeclination)*sind(hourAngle))/(sind(latitude)*sind(solarDeclination) + cosd(latitude)*cosd(solarDeclination)*cosd(hourAngle)));
beta = atand((cosd(latitude)*sind(solarDeclination) - sind(latitude)*cosd(solarDeclination)*cosd(hourAngle))/(sind(latitude)*sind(solarDeclination) + cosd(latitude)*cosd(solarDeclination)*cosd(hourAngle)));


if hourAngle<0
    alpha = -abs(alpha);
end

% Compute the vector for the sun
S = [cosd(beta)*sind(alpha); cosd(beta)*cosd(alpha); sind(beta)*cosd(alpha)]/sqrt(cosd(beta)^2 + sind(beta)^2*cosd(alpha)^2);

%Compute Sunrise and sunset angles
sunInSkyAngle = acosd(-tand(latitude)*tand(solarDeclination));

if abs(hourAngle) > abs(sunInSkyAngle)
    daytime = 0;
else
    daytime = 1;
end


end


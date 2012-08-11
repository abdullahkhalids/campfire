function sunVector = SunVector(sun)
%SUNVECTOR Computes the vector to the sun

a = sun.widthAngle;
b = sun.lengthAngle;

sunVector = [cosd(a)*sind(b);
    cosd(a)*cosd(b);
    cosd(b)*sind(a)];

sunVector = sunVector/norm(sunVector);



end


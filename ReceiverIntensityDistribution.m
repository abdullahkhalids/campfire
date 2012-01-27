function distribution = ReceiverIntensityDistribution(trough,receiver,sun,atmosphere)
%RECEIVERINTENSITYDISTRIBUTION Summary of this function goes here
%   Detailed explanation goes here

%Compute the incidence angles of the center of the incident sun cone with
%the surface normal
incidenceAngles = trough.normalAngles - sun.positionAngle;

transmissionAngles = snellLaw(incidenceAngles,atmosphere.refractiveIndex,trough.refractiveIndex);

%Given the sun's position, compute the angle the center of the reflected
%cone makes with the vertical.
reflectedAngles = 2*trough.normalAngles - sun.positionAngle;

%gradient of reflected ray
gradientReflected = 1./tan(reflectedAngles);

%compute intersections of reflected rays with receiver
[x,y] = LineCircleIntersection(trough,gradientReflected,receiver);

%compute which of the receiver points each of the rays ends up at
indexes = IntersectionIndexes(receiver.coordinates,x,y);

%the trough receives a uniform intensity from the sun
troughReflectedIntesities(1:length(trough.coordinates),1) = frenelReflectionCoefficient(incidenceAngles,transmissionAngles,atmosphere.refractiveIndex,trough.refractiveIndex,'mixed')*sun.intensity;

%add up all the intensities at the receiver for each point
distribution = zeros(length(receiver.coordinates),1);
for i=1:length(trough.coordinates)
    if indexes(i)~=0
        distribution(indexes(i)) = distribution(indexes(i)) + troughReflectedIntesities(i);
    end
end


end


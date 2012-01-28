function distribution = ReceiverIntensityDistribution(simulation,trough,receiver,sun,atmosphere)
%RECEIVERINTENSITYDISTRIBUTION Summary of this function goes here
%   Detailed explanation goes here

%Compute the incidence angles of the center of the incident sun cone with
%the surface normal
anglesIncidence = trough.anglesNormal - sun.positionAngle;

anglesTransmission = snellLaw(anglesIncidence,atmosphere.refractiveIndex,trough.refractiveIndex);

%Given the sun's position, compute the angle the center of the reflected
%cone makes with the vertical.
anglesReflected = 2*trough.anglesNormal - sun.positionAngle;

%gradient of reflected ray
gradientsReflected = angle2grad(anglesReflected);

%compute intersections of reflected rays with receiver
pointsIntersections = LineCircleIntersection(trough,gradientsReflected,receiver);

%compute which of the receiver points each of the rays ends up at
indexes = IntersectionIndexes(receiver.coordinates,pointsIntersections);

%the trough receives a uniform intensity from the sun
troughReflectedIntesities(1:length(trough.coordinates),1) = frenelReflectionCoefficient(anglesIncidence,anglesTransmission,atmosphere.refractiveIndex,trough.refractiveIndex,'mixed')*sun.intensity*simulation.grainLength;

%add up all the intensities at the receiver for each point
distribution = zeros(1,length(receiver.coordinates));
for i=1:length(trough.coordinates)
    if indexes(i)~=0
        distribution(indexes(i)) = distribution(indexes(i)) + troughReflectedIntesities(i);
    end
end


end


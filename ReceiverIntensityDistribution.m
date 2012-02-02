function distribution = ReceiverIntensityDistribution(simulation,trough,receiver,sun,atmosphere)
%Computes the intensity distribution over the receiver.

%Compute the incidence angles of the center of the incident sun cone with
%the surface normal
%anglesIncidence = trough.anglesNormal - sun.positionAngle;
anglesIncidence = acos((sun.positionVector(2) - sun.positionVector(1)*trough.gradients)./sqrt(1+trough.gradients.^2));

%Compute transmission angles
anglesTransmission = snellLaw(anglesIncidence,atmosphere.refractiveIndex,trough.refractiveIndex);

%gradient of reflected ray
gradientsReflected = (sun.positionVector(2)*(1 + trough.gradients.^2) - 2*(sun.positionVector(2) - sun.positionVector(1)*trough.gradients))./(sun.positionVector(1)*(1 + trough.gradients.^2) + 2*(sun.positionVector(2) - sun.positionVector(1)*trough.gradients).*trough.gradients);

%compute intersections of reflected rays with receiver
pointsIntersections = LineCircleIntersection(trough,gradientsReflected,receiver);

%compute which of the receiver points each of the rays ends up at
indexes = IntersectionIndexes(receiver.coordinates,pointsIntersections);

%the trough receives a uniform intensity from the sun
troughReflectedIntensities = sun.intensity*simulation.grainLength*frenelReflectionCoefficient(anglesIncidence,anglesTransmission,atmosphere.refractiveIndex,trough.refractiveIndex,'mixed');

%add up all the intensities at the receiver for each point
distribution = zeros(1,length(receiver.coordinates));
for i=1:length(trough.coordinates)
    if indexes(i)~=0
        distribution(indexes(i)) = distribution(indexes(i)) + troughReflectedIntensities(i);
    end
end


end


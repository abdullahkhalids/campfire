function distribution = ReceiverIntensityDistribution(simulation,trough,receiver,sun,atmosphere)
%Computes the intensity distribution over the receiver.

%Compute the incidence angles of the center of the incident sun cone with
%the surface normal
%anglesIncidence = trough.anglesNormal - sun.positionAngle;
anglesConeCenterIncidence = acos((sun.positionVector(2) - sun.positionVector(1)*trough.gradients)./sqrt(1+trough.gradients.^2));

%Compute all the rays of each sun cone
anglesIncidence = SunCone(anglesConeCenterIncidence,sun);

%Compute transmission angles
anglesTransmission = snellLaw(anglesIncidence,atmosphere.refractiveIndex,trough.refractiveIndex);

%Compute gradients
gradientsReflected = SunConeReflections(anglesConeCenterIncidence,trough,sun);

%compute intersections of reflected rays with receiver
pointsIntersections = LineCircleIntersection(trough,gradientsReflected,receiver);

%compute which of the receiver points each of the rays ends up at
indexes = IntersectionIndexes(receiver.coordinates,pointsIntersections);

%the trough receives a uniform intensity from the sun
troughReflectedIntensities = (sun.irradiance*simulation.grainLength/sun.fullQuantization)*frenelReflectionCoefficient(anglesIncidence,anglesTransmission,atmosphere.refractiveIndex,trough.refractiveIndex,'mixed');

%add up all the intensities at the receiver for each point
distribution = zeros(1,length(troughReflectedIntensities));
for i=1:length(troughReflectedIntensities)
    if indexes(i)~=0
        distribution(indexes(i)) = distribution(indexes(i)) + troughReflectedIntensities(i);
    end
end


end


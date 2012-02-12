function distribution = ReceiverIntensityDistribution(simulation,trough,receiver,sun,atmosphere)
%Computes the intensity distribution over the receiver.

%Compute the incidence angles,vectors and intensities
[anglesIncidence, vectorsIncidence, intensitiesIncidence] = SunRays(sun,trough.gradients,simulation);

%Compute transmission angles
anglesTransmission = Transmissions(anglesIncidence,atmosphere,trough);

%Compute gradients
[vectorsReflection, intensitiesReflection] = Reflections(atmosphere, trough, anglesIncidence, vectorsIncidence,intensitiesIncidence,anglesTransmission);
gradientsReflection = vectorsReflection(2,:)./vectorsReflection(1,:);

%Compute where each reflected ray ends up on the receiver
indexes = ReceiverIntersections(gradientsReflection,trough,receiver,sun);

%add up all the intensities at the receiver for each point
distribution = zeros(1,length(intensitiesReflection));
for i=1:length(intensitiesReflection)
    if indexes(i)~=0
        distribution(indexes(i)) = distribution(indexes(i)) + intensitiesReflection(i);
    end
end


end


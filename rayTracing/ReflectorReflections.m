function [gradientsReflection,vectorsReflection,intensitiesReflection] = ReflectorReflections(atmosphere, trough, anglesIncidence, vectorsIncidence,intensitiesIncidence)
%REFLECTORREFLECTIONS Given a set of rays incident on a surface, computes
%the reflections taking into account the specularity etc.

%Compute transmission angles
anglesTransmission = Transmissions(anglesIncidence,atmosphere,trough);

%Compute gradients
[vectorsReflection, intensitiesReflection] = Reflections(atmosphere, trough, anglesIncidence, vectorsIncidence,intensitiesIncidence,anglesTransmission);
gradientsReflection = vectorsReflection(2,:)./vectorsReflection(1,:);



end


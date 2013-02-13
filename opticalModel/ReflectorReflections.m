function [vectorsReflection,intensitiesReflection] = ReflectorReflections(atmosphere, trough, normalsExpanded,anglesIncidence, vectorsIncidence,intensitiesIncidence)
%REFLECTORREFLECTIONS Given a set of rays incident on a surface, computes
%the reflections taking into account the specularity etc.

%Compute transmission angles
anglesTransmission = Transmissions(anglesIncidence,atmosphere,trough);

%Compute gradients
[vectorsReflection, intensitiesReflection] = Reflections(atmosphere, trough, normalsExpanded,anglesIncidence, vectorsIncidence,intensitiesIncidence,anglesTransmission);

end


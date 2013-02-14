function [vectorsReflectedSpecular,intensitiesReflection] = ReflectorReflections(atmosphere, parabola, normalsExpanded,anglesIncidence, vectorsIncidence,intensitiesIncidence)
%REFLECTORREFLECTIONS Given a set of rays incident on a surface, computes
%the reflections taking into account the specularity etc.

m = (4*parabola.halfQuantization+1);

%compute reflected vectors
vectorsReflected = -vectorsIncidence + repmat(2*sum(vectorsIncidence.*normalsExpanded,1),3,1).*normalsExpanded;
%account for specularity
specularAngles = mat2cell(random('normal',0,parabola.specularityStdDev,1,2*parabola.halfQuantization*length(vectorsReflected)),1,2*parabola.halfQuantization*ones(1,length(vectorsReflected)));

%convert to cell
vectorsReflected = num2cell(vectorsReflected,1);

vectorsReflectedSpecular = cell2mat(cellfun(@RotateVector,vectorsReflected,specularAngles,'UniformOutput',false));

% reflect the intensities
if parabola.reflectivityCheck
    %reflected intensities are reduced by the reflection coefficient
    intensitiesReflection = intensitiesIncidence.*parabola.reflectivity;
else
    %Compute transmission angles
    anglesTransmission = Transmissions(anglesIncidence,atmosphere,parabola);
    
    %reflected intensities are reduced by the frenel coefficients
    intensitiesReflection = intensitiesIncidence.*FresnelReflectionCoefficient(anglesIncidence,anglesTransmission,atmosphere.refractiveIndex,trough.refractiveIndex,'mixed');
end

on = ones(1,m);
% account for specularity - equally divide
intensitiesReflection =  expand(intensitiesReflection,@(x) on*x/m);

end

function vectorsExpanded = RotateVector(vector,thetas)

vectorsExpanded = [expand(thetas,@(theta) [1 0 0; 0 cos(theta) -sin(theta); 0 sin(theta) cos(theta)]*vector) ...
    vector ...
    expand(thetas,@(theta) [cos(theta) sin(theta) 0; -sin(theta) cos(theta) 0; 0 0 1]*vector)];

end


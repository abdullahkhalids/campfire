function [vectorsReflection, intensitiesReflection] = Reflections(material1, material2, anglesIncidence, vectorsIncidence,intensitiesIncidence,anglesTransmission)
%Computes the reflected angles, vectors, and intensites given the incident
%vectors, intensities and the gradient of the reflection surface

m = size(vectorsIncidence,2)/size(material2.gradients,2);

%compute the normal vector at each point
normals = repmat(1./sqrt(1 + material2.gradients.^2),2,1).*[-material2.gradients; ones(1,length(material2.gradients))];

%expand these out to the correct size
normalsExpanded = expand(normals,@(x)repmat(x,1,m));

%compute reflected vectors
vectorsReflected = vectorsIncidence - repmat(2*sum(vectorsIncidence.*normalsExpanded,1),2,1).*normalsExpanded;

%Account for specularity
vectorsReflection = RotateVectorsMat(vectorsReflected,material2.halfQuantization,abs(random('normal',0,material2.specularityStdDev,1,length(vectorsReflected))));

%reflected intensities are reduced by the frenel coefficients
intensitiesReflection = intensitiesIncidence.*FresnelReflectionCoefficient(anglesIncidence,anglesTransmission,material1.refractiveIndex,material2.refractiveIndex,'mixed');

%then split into specular and non-specular rays
base = (1-material2.specularity)/(2*material2.halfQuantization) * ones(1,material2.fullQuantization);
base(material2.halfQuantization+1) = material2.specularity;
intensitiesReflection = ExpandIntensities(intensitiesReflection,base);

end


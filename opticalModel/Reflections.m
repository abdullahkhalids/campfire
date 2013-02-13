function [vectorsReflectedSpecular, intensitiesReflection] = Reflections(material1, material2, normalsExpanded,anglesIncidence, vectorsIncidence,intensitiesIncidence,anglesTransmission)
%Computes the reflected angles, vectors, and intensites given the incident
%vectors, intensities and the gradient of the reflection surface

% m = size(vectorsIncidence,2)/size(material2.gradients,2);

% expand normal vectors out to the correct size
% normalsExpanded = repmat(material2.normals,1,m);

%compute reflected vectors
vectorsReflected = -vectorsIncidence + repmat(2*sum(vectorsIncidence.*normalsExpanded,1),3,1).*normalsExpanded;
vectorsReflected = num2cell(vectorsReflected,1);
%account for specularity
specularAngles = abs(random('normal',0,material2.specularityStdDev,1,length(vectorsReflected)));


% vectorsReflectedSpecular = cell2mat(cellfun(@SpecularExpand,num2cell(vectorsReflected,1),num2cell(specularAngles),'UniformOutput',false));
vectorsReflectedSpecular = zeros(3,4*length(vectorsReflected));

%x pos
vectorsReflectedSpecular(:,3:4:end) = cell2mat(cellfun(@(vector,theta) [1 0 0; 0 cos(theta) -sin(theta); 0 sin(theta) cos(theta)]*vector ...
    ,vectorsReflected,num2cell(specularAngles),'UniformOutput',false));
%x neg
vectorsReflectedSpecular(:,1:4:end) = cell2mat(cellfun(@(vector,theta) [1 0 0; 0 cos(theta) -sin(theta); 0 sin(theta) cos(theta)]*vector ...
    ,vectorsReflected,num2cell(-specularAngles),'UniformOutput',false));
%z pos
vectorsReflectedSpecular(:,4:4:end) = cell2mat(cellfun(@(vector,theta) [cos(theta) sin(theta) 0; -sin(theta) cos(theta) 0; 0 0 1]*vector ...
    ,vectorsReflected,num2cell(specularAngles),'UniformOutput',false));
%z neg
vectorsReflectedSpecular(:,2:4:end) = cell2mat(cellfun(@(vector,theta) [cos(theta) sin(theta) 0; -sin(theta) cos(theta) 0; 0 0 1]*vector ...
    ,vectorsReflected,num2cell(-specularAngles),'UniformOutput',false));


% reflect the intensities
if material2.reflectivityCheck
    %reflected intensities are reduced by the reflection coefficient
    intensitiesReflection = intensitiesIncidence.*material2.reflectivity;
else
    %reflected intensities are reduced by the frenel coefficients
    intensitiesReflection = intensitiesIncidence.*FresnelReflectionCoefficient(anglesIncidence,anglesTransmission,material1.refractiveIndex,material2.refractiveIndex,'mixed');
end

on = ones(1,4);
% account for specularity - equally divide
intensitiesReflection = cell2mat(cellfun(@(x) on*x/4,num2cell(intensitiesReflection),'UniformOutput',false));



% m = size(vectorsIncidence,2)/size(material2.gradients,2);
% 
% %compute the normal vector at each point
% normals = repmat(1./sqrt(1 + material2.gradients.^2),2,1).*[-material2.gradients; ones(1,length(material2.gradients))];
% 
% %expand these out to the correct size
% normalsExpanded = expand(normals,@(x)repmat(x,1,m));
% 
% %compute reflected vectors
% vectorsReflected = vectorsIncidence - repmat(2*sum(vectorsIncidence.*normalsExpanded,1),2,1).*normalsExpanded;
% 
% %Account for specularity
% vectorsReflection = RotateVectorsMat(vectorsReflected,material2.halfQuantization,abs(random('normal',0,material2.specularityStdDev,1,length(vectorsReflected))));
% 
% %reflected intensities are reduced by the frenel coefficients
% intensitiesReflection = intensitiesIncidence.*material2.reflectivity;%FresnelReflectionCoefficient(anglesIncidence,anglesTransmission,material1.refractiveIndex,material2.refractiveIndex,'mixed');
% 
% %then split into specular and non-specular rays
% base = (1-material2.specularity)/(2*material2.halfQuantization) * ones(1,material2.fullQuantization);
% base(material2.halfQuantization+1) = material2.specularity;
% intensitiesReflection = ExpandIntensities(intensitiesReflection,base);

end

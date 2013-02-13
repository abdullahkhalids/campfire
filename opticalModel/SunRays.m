function [anglesIncidence, vectorsIncidence, intensitiesIncidence] = SunRays(normalsExpanded,sun,simulation)
%Given a sun computes the incidence angles and incident vectors on a
%surface given the gradient at each point as well as the corresponding
%intensities

% 
% %The angle that the center of the sun cone makes with each point
% anglesConeCenters = acos(abs((sun.positionVector(2) - sun.positionVector(1)*gradients)./sqrt(1+gradients.^2)));
% 
% %Expand them out to get rays for the whole cone
% anglesIncidence = ExpandAngles(anglesConeCenters,sun.halfQuantization,sun.halfAngle);
% 
% %the incidence vectors at each point
% vectorsIncidence = RotateVectors(repmat(sun.positionVector,1,length(gradients)),sun.halfQuantization,sun.halfAngle);
% 
% %intensities
% IntensityPerCone = repmat(sun.irradiance*simulation.grainVolume,1,size(anglesConeCenters,2));
% base = ones(1,sun.fullQuantization)/sun.fullQuantization;
% intensitiesIncidence = ExpandIntensities(IntensityPerCone,base);

m = 4*sun.halfQuantization+1;

% expand sun vector into cone
Rot = @(angle,vector,axes) createRotation(angle,axes)*vector;
base = zeros(3,m);
xbase = linspace(-sun.halfAngle,sun.halfAngle,2*sun.halfQuantization+1);
zbase = linspace(-sun.halfAngle,sun.halfAngle,2*sun.halfQuantization);
base(:,1:2:end) = expand(xbase,@(theta) Rot(theta,sun.positionVector,'x'));
base(:,2:2:end-1) = expand(zbase,@(theta) Rot(theta,sun.positionVector,'z'));

% and get incidence angles
vectorsIncidence = repmat(base,1,size(normalsExpanded,2)/m);

% get the angles of incidence
% normalsExpanded = expand(normals,@(x)repmat(x,1,m));
% normalsExpanded = repmat(normals,1,4*sun.halfQuantization+1);
anglesIncidence = acos(sum(vectorsIncidence.*normalsExpanded,1));

%intensities
IntensityPerCone = sun.irradiance*simulation.grainVolume*ones(1,m)/m;
intensitiesIncidence = repmat(IntensityPerCone,1,size(normalsExpanded,2)/m);

end



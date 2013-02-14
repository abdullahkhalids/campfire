function [anglesIncidence, vectorsIncidence, intensitiesIncidence] = SunRays(normalsExpanded,sun,simulation)
%Given a sun computes the incidence angles and incident vectors on a
%surface given the gradient at each point as well as the corresponding
%intensities

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
anglesIncidence = acos(sum(vectorsIncidence.*normalsExpanded,1));

%intensities
IntensityPerCone = sun.irradiance*simulation.grainVolume*ones(1,m)/m;
intensitiesIncidence = repmat(IntensityPerCone,1,size(normalsExpanded,2)/m);

end



function [anglesIncidence, vectorsIncidence, intensitiesIncidence] = SunRays(sun,gradients,simulation)
%Given a sun computes the incidence angles and incident vectors on a
%surface given the gradient at each point as well as the corresponding
%intensities

%The angle that the center of the sun cone makes with each point
anglesConeCenters = acos(abs((sun.positionVector(2) - sun.positionVector(1)*gradients)./sqrt(1+gradients.^2)));

%Expand them out to get rays for the whole cone
anglesIncidence = ExpandAngles(anglesConeCenters,sun.halfQuantization,sun.halfAngle);

%the incidence vectors at each point
vectorsIncidence = RotateVectors(repmat(sun.positionVector(1:2),1,length(gradients)),sun.halfQuantization,sun.halfAngle);

%intensities
IntensityPerCone = repmat(sun.irradiance*simulation.grainLength,1,size(anglesConeCenters,2));
base = ones(1,sun.fullQuantization)/sun.fullQuantization;
intensitiesIncidence = ExpandIntensities(IntensityPerCone,base);

end



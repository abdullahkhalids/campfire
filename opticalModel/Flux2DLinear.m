function [isIntersection,intensitiesReflection] = Flux2DLinear(parabola,receiver,sun,atmosphere,simulation)
%FLUX2D Computes the flux on a parabola.

% common calculation
m = 4*sun.halfQuantization+1;
normalsExpanded = expand(parabola.normals,@(x)repmat(x,1,m));

% The sun throws light rays at all points.
% Compute the incidence angles, vectors and intensities
[anglesIncidence, vectorsIncidence, intensitiesIncidence] = SunRays(normalsExpanded,sun,simulation);

% These rays are reflected off the reflector surface
[vectorsReflection,intensitiesReflection] = ReflectorReflections(atmosphere, parabola,normalsExpanded, anglesIncidence, vectorsIncidence,intensitiesIncidence); %#ok<ASGLU>

%Compute where each reflected ray ends up on the receiver
%[indexes,isIntersection] = ReceiverIntersectionsLinear(gradientsReflection,parabola,receiver,sun);

isIntersection = ReceiverIntersectionsCylinder(vectorsReflection,parabola,receiver,sun);

end


function [indexes,isIntersection,intensitiesReflection] = Flux2DCircular(parabola,receiver,sun,atmosphere,simulation)
%FLUX2DCIRCULAR Computes the flux on the dish receiver

% The sun throws light rays at all points.
% Compute the incidence angles, vectors and intensities
[anglesIncidence, vectorsIncidence, intensitiesIncidence] = SunRays(sun,parabola.gradients,simulation);

% These rays are reflected off the receiver surface
[gradientsReflection,vectorsReflection,intensitiesReflection] = ReflectorReflections(atmosphere, parabola, anglesIncidence, vectorsIncidence,intensitiesIncidence); %#ok<ASGLU>

%Compute where each reflected ray ends up on the receiver
[indexes,isIntersection] = ReceiverIntersectionsCircular(gradientsReflection,parabola,receiver,sun);



end


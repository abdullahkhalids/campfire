function [indexes,isIntersection,intensitiesReflection ] = Flux2D(parabola,receiver,sun,atmosphere,simulation)
%FLUX2D Computes the flux on a parabola.

% The sun throws light rays at all points.
% Compute the incidence angles, vectors and intensities
[anglesIncidence, vectorsIncidence, intensitiesIncidence] = SunRays(sun,parabola.gradients,simulation);

% These rays are reflected off the receiver surface
[gradientsReflection,vectorsReflection,intensitiesReflection] = ReflectorReflections(atmosphere,parabola,anglesIncidence,vectorsIncidence,intensitiesIncidence);

%Compute where each reflected ray ends up on the receiver
[indexes,isIntersection] = ReceiverIntersections(gradientsReflection,parabola,receiver,sun);



end


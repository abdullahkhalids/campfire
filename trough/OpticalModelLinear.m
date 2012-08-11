function [InterceptFactor,PowerReceiver, PowerReflector,receiverEffectiveLength] = OpticalModelLinear(simulation,trough,receiver,sun,atmosphere)
%OPTICALMODEL Computes distribution and total power on a linear receiver.
% The optical model starts with rays from the sun and sends them
% through the system, modelling reflections, transmissions and 
% all other necessary optical processes. Rays stop when they 
% reach the receiver. 
% This function outputs the following:


%% 2D Optical Model
% The sun throws light rays at all points.
% Compute the incidence angles, vectors and intensities
[anglesIncidence, vectorsIncidence, intensitiesIncidence] = SunRays(sun,trough.gradients,simulation);

% These rays are reflected off the receiver surface
[gradientsReflection,vectorsReflection,intensitiesReflection] = ReflectorReflections(atmosphere, trough, anglesIncidence, vectorsIncidence,intensitiesIncidence); %#ok<ASGLU>

%Compute where each reflected ray ends up on the receiver
[indexes,isIntersection] = ReceiverIntersections(gradientsReflection,trough,receiver,sun);

%% 3D Optical Model

[InterceptFactor,PowerReceiver, PowerReflector,receiverEffectiveLength] = Flux3DLinear(indexes,isIntersection,intensitiesReflection,trough,receiver,sun,simulation);



end


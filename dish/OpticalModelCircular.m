function [InterceptFactor,PowerReceiver, PowerReflector] = OpticalModelCircular(simulation,dish,receiver,sun,atmosphere)
%OPTICALMODELPOINT Computes distribution and total power on a linear receiver.
% The optical model starts with rays from the sun and sends them
% through the system, modelling reflections, transmissions and 
% all other necessary optical processes. Rays stop when they 
% reach the receiver. 
% This function outputs the following:

% Compute the cross section in the plane of the sun
dish.crosssection = DishCrosssection(dish,sun,simulation);

%% 2D Optical Model
% The sun throws light rays at all points.
% Compute the incidence angles, vectors and intensities
[anglesIncidence, vectorsIncidence, intensitiesIncidence] = SunRays(sun,dish.crosssection.gradients,simulation);

% These rays are reflected off the receiver surface
[gradientsReflection,vectorsReflection,intensitiesReflection] = ReflectorReflections(atmosphere, dish.crosssection, anglesIncidence, vectorsIncidence,intensitiesIncidence);

%Compute where each reflected ray ends up on the receiver
[indexes,isIntersection] = ReceiverIntersections(gradientsReflection,dish.crosssection,receiver,sun);


%% 3D Optical Model

[InterceptFactor,PowerReceiver, PowerReflector] = Flux3DCircular(indexes,isIntersection,intensitiesReflection,dish,receiver,sun,simulation);


end


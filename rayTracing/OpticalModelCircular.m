function [InterceptFactor,PowerReceiver, PowerReflector] = OpticalModelCircular(simulation,dish,receiver,sun,atmosphere)
%OPTICALMODELPOINT Computes distribution and total power on a linear receiver.
% The optical model starts with rays from the sun and sends them
% through the system, modelling reflections, transmissions and 
% all other necessary optical processes. Rays stop when they 
% reach the receiver. 
% This function outputs the following:
% InterceptFactor: The optical efficiency
% PowerReceiver: The power incidence
% Power Reflector: The power incident on the reflector

% Compute the cross section in the plane of the sun
dish.crosssection = DishCrosssection(dish,sun,simulation);

%% 2D Optical Model
[indexes,isIntersection,intensitiesReflection] = Flux2D(dish.crosssection,receiver,sun,atmosphere,simulation);

%% 3D Optical Model
[InterceptFactor,PowerReceiver, PowerReflector] = Flux3DCircular(indexes,isIntersection,intensitiesReflection,dish,receiver,sun,simulation);

end


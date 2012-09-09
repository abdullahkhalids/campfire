function [InterceptFactor,PowerReceiver, PowerReflector,receiverEffectiveLength] = OpticalModelLinear(simulation,trough,receiver,sun,atmosphere)
%OPTICALMODEL Computes distribution and total power on a linear receiver.
% The optical model starts with rays from the sun and sends them
% through the system, modelling reflections, transmissions and 
% all other necessary optical processes. Rays stop when they 
% reach the receiver. 
% This function outputs the following:
% InterceptFactor: The optical efficiency
% PowerReceiver: The power incidence
% Power Reflector: The power incident on the reflector


%% 2D Optical Model
[indexes,isIntersection,intensitiesReflection] = Flux2DLinear(trough,receiver,sun,atmosphere,simulation);

%% 3D Optical Model
[InterceptFactor,PowerReceiver, PowerReflector,receiverEffectiveLength] = Flux3DLinear(indexes,isIntersection,intensitiesReflection,trough,receiver,sun,simulation);

end


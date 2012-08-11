function E = opticalEfficiencyError(x)
%OPTICALEFFICIENCYERROR The error in the optical efficiency from the ideal
% x has the following elements. trough.focalLength,trough.width,
% receiver.absorberDiameter, receiver.glassSleeveDiameter
%get user simulation constants
constants;

trough.focalLength = x(1);
trough.width = x(2);
receiver.absorberDiameter = x(3);
receiver.glassSleeveDiameter = x(4);

%rest of simulation parameters
calculations;

%compute the receiver distribution for the 2D case
receiverDistribution = ReceiverIntensityDistribution(simulation,trough,receiver,sun,atmosphere);

%Compute the total flux for a 3D case
[~, ~,InterceptFactor] = Flux3D(receiverDistribution,trough,receiver,sun,simulation);

E = -InterceptFactor;


end


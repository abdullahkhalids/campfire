function [InterceptFactor, PowerTrough, PowerReceiver] = InterceptEnergy(simulation,trough,receiver,receiverFluid,sun,atmosphere,location)


%compute the receiver distribution for the 2D case
receiverDistribution = ReceiverIntensityDistribution(simulation,trough,receiver,sun,atmosphere);

%Compute the total flux for a 3D case
[PowerReceiver, PowerTrough,InterceptFactor] = Flux3D(receiverDistribution,trough,receiver,sun,simulation);


end


tic
%get user simulation constants
constants;

%rest of simulation parameters
calculations;

%compute the receiver distribution for the 2D case
receiverDistribution = ReceiverIntensityDistribution(simulation,trough,receiver,sun,atmosphere);

%Compute the total flux for a 3D case
[PowerReceiver, PowerTrough,InterceptFactor] = Flux3D(receiverDistribution,trough,receiver,sun,simulation);

%Output temperature from receiver
collectorCycle.outletTemperature = ReceiverTemperature(receiver, PowerReceiver, collectorCycle, atmosphere);


toc

disp(['Power On Receiver = ' num2str(PowerReceiver) 'W'])
disp(['Intercept Factor = ' num2str(InterceptFactor*100) '%']);
disp(['Output Temperature increase = ' num2str(collectorCycle.outletTemperature- atmosphere.temperature) ' C']);
disp(['Mass Flow Rate = ' num2str(collectorCycle.flowRate) ' kg/s']);


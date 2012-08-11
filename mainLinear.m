clear all;

tic
%get user simulation constants
constants;

%rest of simulation parameters
calculations;

%optical model
[InterceptFactor,PowerReceiver, PowerTrough, receiver.effectiveLength] = OpticalModelLinear(simulation,trough,receiver,sun,atmosphere);

%Output temperature from receiver
collectorCycle.outletTemperature = ReceiverTemperatureLinear(receiver, PowerReceiver, collectorCycle, atmosphere,simulation);


toc

disp(['Power On Receiver = ' num2str(PowerReceiver) 'W'])
disp(['Intercept Factor = ' num2str(InterceptFactor*100) '%']);
disp(['Output Temperature increase = ' num2str(collectorCycle.outletTemperature- atmosphere.temperature) ' C']);
disp(['Mass Flow Rate = ' num2str(collectorCycle.flowRate) ' kg/s']);


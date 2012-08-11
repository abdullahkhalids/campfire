tic
%get user simulation constants
constants;

%rest of simulation parameters
calculations;

% dish
dishDef;

%optical model
[InterceptFactor,PowerReceiver, PowerReflector] = OpticalModelCircular(simulation,dish,receiver,sun,atmosphere);

%Output temperature from receiver
% collectorCycle.outletTemperature = ReceiverTemperature(receiver, PowerReceiver, collectorCycle, atmosphere);


toc

disp(['Power On Receiver = ' num2str(PowerReceiver) 'W'])
disp(['Intercept Factor = ' num2str(InterceptFactor*100) '%']);
disp(['Output Temperature increase = ' num2str(collectorCycle.outletTemperature- atmosphere.temperature) ' C']);
disp(['Mass Flow Rate = ' num2str(collectorCycle.flowRate) ' kg/s']);


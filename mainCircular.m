tic
%get user simulation constants
constants;

%rest of simulation parameters
calculations;

%optical model
[InterceptFactor,PowerReceiver, PowerReflector] = OpticalModelCircular(simulation,dish,pointReceiver,sun,atmosphere);

%Output temperature from receiver
[collectorCycle.outletTemperature,pointReceiver.temperature] = ReceiverTemperatureCircular(pointReceiver,PowerReceiver,collectorCycle,atmosphere,simulation);

toc

disp(['Power On Receiver = ' num2str(PowerReceiver) 'W'])
disp(['Intercept Factor = ' num2str(InterceptFactor*100) '%']);
disp(['Output Steady State Temperature Rise = ' num2str(collectorCycle.outletTemperature - atmosphere.temperature) ' C']);
disp(['Mass Flow Rate = ' num2str(collectorCycle.flowRate) ' kg/s']);
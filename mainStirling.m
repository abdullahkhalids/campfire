tic
%get user simulation constants
constants;

%rest of simulation parameters
calculations;

%optical model
[InterceptFactor,PowerReceiver, PowerReflector] = OpticalModelCircular(simulation,dish,pointReceiver,sun,atmosphere);

%Output temperature from receiver
[TimeForSteadyState,HeatStirling,stirlingReceiver] = ReceiverTemperatureStirling(stirlingReceiver,PowerReceiver,collectorCycle,atmosphere,simulation);

toc

disp(['Power On Receiver = ' num2str(PowerReceiver) 'W'])
disp(['Intercept Factor = ' num2str(InterceptFactor*100) '%']);
disp(['The Stirling Engine can be turned on in ' num2str(TimeForSteadyState) ' s']);
disp(['It will get about ' num2str(HeatStirling) ' W power']);
disp(['The receiver temperature will be at about ' num2str(stirlingReceiver.temperature) ' K']);
% disp(['Output Steady State Temperature Rise = ' num2str(collectorCycle.outletTemperature - atmosphere.temperature) ' C']);
% disp(['Mass Flow Rate = ' num2str(collectorCycle.flowRate) ' kg/s']);
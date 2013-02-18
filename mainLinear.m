% clear all;
tic
%get user simulation constants
constants;

%rest of simulation parameters
calculations;

%optical model
[InterceptFactor,PowerReceiver, PowerTrough, receiver.effectiveLength] = OpticalModelLinear(simulation,trough,receiver,sun,atmosphere);

%Output temperature from receiver
[collectorCycle.outletTemperature] = ReceiverTemperatureLinear(receiver, PowerReceiver, collectorCycle, atmosphere,simulation);

toc

Trise = collectorCycle.outletTemperature - collectorCycle.inletTemperature;
thermalGain = collectorCycle.massFlowRate*materialProperty(collectorCycle.fluid.heatCapacityTable,collectorCycle.inletTemperature)*Trise;

disp(['Power On Receiver = ' num2str(PowerReceiver) 'W'])
disp(['Intercept Factor = ' num2str(InterceptFactor*100) '%']);
disp(['Output Temperature increase = ' num2str(Trise) ' C']);
disp(['Flow Rate = ' num2str(1000*collectorCycle.flowRate*60) ' liters/min']);
disp(['Thermal Efficiency = ', num2str(100*thermalGain/PowerReceiver),'%']);
disp(['Total Efficiency = ', num2str(100*thermalGain/PowerTrough),'%']);

%costs
costs;

[TotalCost individualCosts] = ComputeCosts(costTable,trough,receiver);

disp(['Trough Cost = Rs. ' num2str(individualCosts(1))]);
disp(['Receiver Cost = Rs. ' num2str(individualCosts(2))])
% disp(['Collector Cycle Cost = Rs. ' num2str(individualCosts(3))])

disp(['Total Cost = Rs. ' num2str(TotalCost)]);

clear all; close all;
mislocation = 0.02;
constants
calculations;

    defaultStream = RandStream.getDefaultStream;
    load('Z:\matlab\solar\randstream');
    defaultStream.State = savedState;

%compute the receiver distribution for the 2D case
receiverDistribution = ReceiverIntensityDistribution(simulation,trough,receiver,sun,atmosphere);

%Compute the total flux for a 3D case
[PowerReceiver, PowerTrough,InterceptFactor] = Flux3D(receiverDistribution,trough,receiver,sun,simulation);

%Output temperature from receiver
%[receiverFluid.outletTemperature, receiverFluid.massFlowRate] = ReceiverTemperatureOutput(receiver, PowerReceiver, receiverFluid, atmosphere);

disp(['Power On Receiver = ' num2str(PowerReceiver) 'W'])
disp(['Intercept Factor = ' num2str(InterceptFactor*100) '%']);
% disp(['Output Temperature = ' num2str(receiverFluid.outletTemperature) ' C']);
% disp(['Mass Flow Rate = ' num2str(receiverFluid.massFlowRate) ' kg/s']);

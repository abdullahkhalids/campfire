function [TempFluidOut,TempReceiverOut] = ReceiverTemperatureCircular(receiver,PowerReceiver,collectorCycle,atmosphere,simulation)
%RECEIVERTEMPERATURECENTRAL Computes the steady state temperature of a
%central dish receiver using the input heat flux.

TempReceiverIn = receiver.temperature;
TempFluidIn = collectorCycle.inletTemperature;

% The guess is randomly perturbed because of possible division by 0 errors.
% If there is an error, run again.
Tguess = [TempReceiverIn TempFluidIn] + rand(1,2);
options=optimset('Display','off');


for i=1:ceil(simulation.time)
    
    h = @(T) HeatBalanceEquations(T(1),T(2),TempReceiverIn,TempFluidIn,PowerReceiver,receiver,collectorCycle,atmosphere);
    T = fsolve(h,Tguess,options);

    Tguess = [T(1) TempFluidIn]+rand(1,2);
    TempReceiverIn = T(1);
end

TempReceiverOut = T(1);
TempFluidOut = T(2);

end

function F = HeatBalanceEquations(TempReceiverOut,TempFluidOut,TempReceiverIn,TempFluidIn,PowerReceiver,receiver,collectorCycle,atmosphere)
% 
ReceiverEffectiveHeatCapacity = receiver.volume*receiver.density*receiver.heatCapacity;
FluidEffectiveHeatCapacity = collectorCycle.flowRate*collectorCycle.fluid.heatCapacity;

TempReceiverAvg = (TempReceiverIn+TempReceiverOut)/2;

% the effective power is power on receiver minus the losses
PowerEffective = ComputeEffectivePower(TempReceiverAvg,PowerReceiver,receiver,atmosphere);
HeatTransferReceiver = ReceiverEffectiveHeatCapacity*(TempReceiverOut - TempReceiverIn);
HeatTransferFluid = FluidEffectiveHeatCapacity*(TempFluidOut - TempFluidIn);


%
Nu = 4.36;
%Nu1 changes when inner tube
k1 = materialProperty(collectorCycle.fluid.thermalConductivityTable,TempFluidIn);
h1 = Nu*k1/(2*receiver.pipe.radius);

% the convective heat transfer between the fluid and the receiver
TempLogMean = ((TempReceiverOut - TempFluidOut) - (TempReceiverIn - TempFluidIn))/(log((TempReceiverOut - TempFluidOut)/(TempReceiverIn - TempFluidIn)));
ConvectiveHeatTransfer = h1*(2*pi*receiver.pipe.radius*receiver.pipe.length)*TempLogMean;


%equation 1 says the that effective power is equal to the heat energy given
%to the receiver and fluid
F(1) = PowerEffective - HeatTransferReceiver - HeatTransferFluid;
%equation 1 says that the heat transfer between fluid and receiver is
%convective in nature
F(2) = HeatTransferFluid - ConvectiveHeatTransfer;

F = real(F);

end


function Power = ComputeEffectivePower(TempReceiver,PowerReceiver,receiver,atmosphere)
% heat balance equations. The first is for the receiver. The 

sigma = 5.67e-8;

convectiveLossAperature = receiver.convectiveCoefficient*receiver.aperatureArea*(TempReceiver - atmosphere.temperature);
% radiativeLossAperature = sigma*receiver.emissivity*receiver.aperatureArea*(TempReceiver^4 - atmosphere.temperature^4);
radiativeLossBody = sigma*receiver.emissivity*receiver.area*(TempReceiver^4 - atmosphere.temperature^4);

Power = PowerReceiver - convectiveLossAperature - radiativeLossBody;

end
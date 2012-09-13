function [TimeForSteadyState,HeatStirling,receiver] = ReceiverTemperatureStirling(receiver,PowerReceiver,collectorCycle,atmosphere,simulation)
%RECEIVERTEMPERATURESTIRLING Given the temperature required for the
%stirling engine to operate, computes if such a state is possible, and if
%yes how much heat is transferred to the stirling

TempReceiverIn = receiver.temperature;
TempPlateIn = receiver.plate.temperature;


% The guess is randomly perturbed because of possible division by 0 errors.
% If there is an error, run again.
Tguess = [TempReceiverIn TempPlateIn] + rand(1,2);
options=optimset('Display','off');


for i=1:ceil(simulation.time)
    
    h = @(T) HeatBalanceEquations(T(1),T(2),TempReceiverIn,TempPlateIn,PowerReceiver,receiver,atmosphere);
    T = fsolve(h,Tguess,options);

    Tguess = [T(1) T(2)]+rand(1,2);
    TempReceiverIn = T(1);
    TempPlateIn = T(2);
    
    if TempPlateIn > receiver.plate.desiredTemperature
        TimeForSteadyState = i;
        break;
    end
    
end

receiver.temperature = TempReceiverIn;
receiver.plate.temperature = TempPlateIn;

% the heat given to the stirling engine is just the remainder of the
% incident flux after losses
HeatStirling = ComputeEffectivePower(TempReceiverIn,PowerReceiver,receiver,atmosphere);

end

function F = HeatBalanceEquations(TempReceiverOut,TempPlateOut,TempReceiverIn,TempPlateIn,PowerReceiver,receiver,atmosphere)


ReceiverEffectiveHeatCapacity = receiver.volume*receiver.density*receiver.heatCapacity;
PlateEffectiveHeatCapacity = receiver.plate.volume*receiver.plate.density*receiver.plate.heatCapacity;

TempReceiverAvg = (TempReceiverIn+TempReceiverOut)/2;

% the effective power is power on receiver minus the losses
PowerEffective = ComputeEffectivePower(TempReceiverAvg,PowerReceiver,receiver,atmosphere);
HeatTransferReceiver = ReceiverEffectiveHeatCapacity*(TempReceiverOut - TempReceiverIn);
HeatTransferPlate = PlateEffectiveHeatCapacity*(TempPlateOut - TempPlateIn);

% the heat transfer between the receiver and the plate
ActiveArea = 2*(receiver.plate.length)^2 + 4*receiver.plate.length*receiver.plate.width;
CharacteristicLength = sqrt(ActiveArea/(4*pi));
lengthRatio = receiver.plate.width/receiver.plate.length;
dimensionlessConduction = interp1([0.1 1 2 10],[0.943 0.956 0.961 1.111],lengthRatio,'spline');
ConductiveHeatTransfer = dimensionlessConduction*receiver.plate.thermalConductivity*ActiveArea/CharacteristicLength*(TempReceiverAvg - TempPlateIn);




% the equations
%equation 1 says the that effective power is equal to the heat energy given
%to the receiver and plate
F(1) = PowerEffective - HeatTransferReceiver - HeatTransferPlate;
%equation 2 says that the heat transfer to the plate is equal to the
%conductive heat transfer between the plate and receiver
F(2) = HeatTransferPlate - ConductiveHeatTransfer;

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
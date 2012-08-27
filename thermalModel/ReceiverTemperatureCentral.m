function T = ReceiverTemperatureCentral(receiver,PowerReceiver,collectorCycle,atmosphere,simulation)
%RECEIVERTEMPERATURECENTRAL Computes the steady state temperature of a
%central dish receiver using the input heat flux.

tolerance = 0.01; %K
sigma = 5.67e-8;
deltaT = tolerance + 1;

T = receiver.temperature;

while (deltaT > tolerance)
    % power on receiver - the convective heat transfer - the radiative heat
    % transfer
    deltaT = (PowerReceiver ...
        - receiver.convectiveCoefficient*receiver.area*(T - atmosphere.temperature) ...
        - sigma*receiver.emissivity*receiver.area*(T^4 - atmosphere.temperature^4))/(receiver.mass*receiver.heatCapacity);
    
    T = T + deltaT;
end


end


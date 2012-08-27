function [ReceiverTemperature,InterceptFactor,PowerReceiver, PowerReflector] = CircularCollector(simulation,dish,receiver,sun,collectorCycle,atmosphere)
%CIRCULARCOLLECTOR One function to compute circular receiver results

%rest of simulation parameters
calculations;

%optical model
[InterceptFactor,PowerReceiver, PowerReflector] = OpticalModelCircular(simulation,dish,receiver,sun,atmosphere);

%Output temperature from receiver
ReceiverTemperature = ReceiverTemperatureCentral(pointReceiver,PowerReceiver,collectorCycle,atmosphere,simulation);


end


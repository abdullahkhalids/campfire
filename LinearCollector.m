function [ReceiverTemperature,InterceptFactor,PowerReceiver, PowerTrough,simulation,sun,atmosphere,trough,receiver,collectorCycle,field] = LinearCollector(simulation,location,field,trough,receiver,sun,collectorCycle,atmosphere)
%LINEARCOLLECTOR One function to compute linear receiver results


%reset random number stream
defaultStream = RandStream.getDefaultStream;
load('randstream');
defaultStream.State = savedState;

%rest of simulation parameters
calculations;

%optical model
[InterceptFactor,PowerReceiver, PowerTrough, receiver.effectiveLength] = OpticalModelLinear(simulation,trough,receiver,sun,atmosphere);

%Output temperature from receiver
ReceiverTemperature = ReceiverTemperatureLinear(receiver, PowerReceiver, collectorCycle, atmosphere,simulation);

end


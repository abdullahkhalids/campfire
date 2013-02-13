function [FinalTemperature,ReceiverTemperature,simulation,sun,atmosphere,trough,receiver,collectorCycle,field] = FieldPerformance(field,simulation,location,trough,receiver,sun,collectorCycle,atmosphere)
%FIELDPERFORMANCE 
ReceiverTemperature = zeros(1,field.series+1);
ReceiverTemperature(1) = collectorCycle.inletTemperature;

for i=2:field.series+1
    
    % run a trough
    [ReceiverTemperature(i),~,~,~,simulation,sun,atmosphere,trough,receiver,collectorCycle,field] = LinearCollector(simulation,location,field,trough,receiver,sun,collectorCycle,atmosphere);  
    
    % this is the input temp of the next trough
    collectorCycle.inletTemperature = ReceiverTemperature(i); 
end

FinalTemperature = ReceiverTemperature(field.series+1);



end


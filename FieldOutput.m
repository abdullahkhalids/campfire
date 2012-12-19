tic
% declare some constants
parallel = 4;
series = 12;
TotalFlowRate = 5/60/1000; %m^3/s

% get user simulation constants
constants;

% get solo flow rate
collectorCycle.flowRate = TotalFlowRate/parallel;

ReceiverTemperature = zeros(1,series+1);
ReceiverTemperature(1) = collectorCycle.inletTemperature;

for i=2:series+1
    
    % run a trough
    [ReceiverTemperature(i),InterceptFactor,PowerReceiver,PowerTrough] = LinearCollector(simulation,location,trough,receiver,sun,collectorCycle,atmosphere);  
    
%     ReceiverTemperature(i) = collectorCycle.outletTemperature;
    collectorCycle.inletTemperature = ReceiverTemperature(i);
    

    
end
toc
disp(['Flow rate per series = ' num2str(collectorCycle.flowRate*60*1000)]);
disp(['Final Temp = ' num2str(ReceiverTemperature(series+1))]);
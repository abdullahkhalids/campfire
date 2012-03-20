% clear all;
% 
% main;

for i=1:50
    
        %exchange heat
%     collectorCycle.inletTemperature = collectorCycle.outletTemperature - 3000/collectorCycle.flowRate/collectorCycle.fluid.heatCapacity;
   
    %heat oil using the trough
    collectorCycle.outletTemperature = ReceiverTemperature(receiver, PowerReceiver, collectorCycle, atmosphere);
    
 
    [collectorCycle.inletTemperature,turbineCycle.turbineInletTemperature, Qvapor] = HeatE(collectorCycle,turbineCycle,heatExchanger);
    te = collectorCycle.outletTemperature - collectorCycle.inletTemperature;
    T(i,:) =[collectorCycle.outletTemperature collectorCycle.inletTemperature collectorCycle.flowRate*collectorCycle.fluid.heatCapacity*te + 273];
    disp(num2str(T(i,:) - 273));
%     disp(num2str([Qvapor]));
    
    turbineCycle.inletTemperature = atmosphere.temperature;

end
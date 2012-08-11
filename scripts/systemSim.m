%clear all;
turbineCycle.turbineInletPressure = psi2bar(200);
turbineCycle.turbineOutletPressure = psi2bar(1);


%main

for i=1:50% (Tth < 200+273)
    
    %heat oil using the trough
    collectorCycle.outletTemperature = ReceiverTemperature(receiver, PowerReceiver, collectorCycle, atmosphere);
    
    %exchange heat
    [collectorCycle.inletTemperature,turbineCycle.turbineInletTemperature, quality] = HeatExchanger(collectorCycle.outletTemperature,turbineCycle.inletTemperature,collectorCycle,turbineCycle,heatExchanger.UA);
    
    %put through turbine
    [outPower, turbineCycle.turbineOutletTemperature] = turbine(turbineCycle.turbineInletPressure,turbineCycle.turbineOutletPressure,turbineCycle.turbineInletTemperature,quality*turbineCycle.flowRate,turbine.efficiency);
    
    %condensor
    turbineCycle.inletTemperature = condensor(turbineCycle.turbineOutletTemperature,turbineCycle.flowRate,water);
    
    disp(num2str([collectorCycle.outletTemperature turbineCycle.turbineInletTemperature turbineCycle.turbineOutletTemperature turbineCycle.inletTemperature]));
    
end

plot(quality)

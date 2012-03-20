function [Tho,Tco, Qvapor] = HeatE(cycleHot,cycleCold,heatExchanger)
%Models a heat exchanger. Gives output temperatures, given inputs
%Implements the effectiveness-NTU method

Thin = cycleHot.outletTemperature;
Tcin = cycleCold.inletTemperature;

%heat capacity rates
    heatCapacityRateHot = cycleHot.flowRate*cycleHot.fluid.heatCapacity;
    heatCapacityRateCold = cycleCold.flowRate*cycleCold.fluid.heatCapacityVapor;

    Cmin = min(heatCapacityRateHot,heatCapacityRateCold);

    Qmax = Cmin*(Thin - Tcin);
    
    %Compute effectiveness
    NTU = heatExchanger.UA/Cmin; 
    
    effectivenessEvaporator = 1 - exp(-NTU);
    
    Qvapor = effectivenessEvaporator*Qmax;

    Tco = Tcin + Qvapor/heatCapacityRateCold;  
    Tho = Thin - Qvapor/heatCapacityRateHot;
end
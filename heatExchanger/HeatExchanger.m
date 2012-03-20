function [Tho,Tco,cycleCold, Qvapor] = HeatExchanger(cycleHot,cycleCold,heatExchanger)
%Models a heat exchanger. Gives output temperatures, given inputs
%Implements the effectiveness-NTU method

Thin = cycleHot.outletTemperature;
Tcin = cycleCold.inletTemperature;

Qvapor = 0;

% %heat capacity rates
% heatCapacityRateHot = cycleHot.flowRate*cycleHot.fluid.heatCapacity;
% heatCapacityRateCold = cycleCold.flowRate*cycleCold.fluid.heatCapacity;
% 
% Cmin = min(heatCapacityRateHot,heatCapacityRateCold);
% Cmax = max(heatCapacityRateHot,heatCapacityRateCold);
% 
% %heat capacity rates ratio
% c = Cmin/Cmax;
% 
% %maximum heat transfer rate
% Qmax = Cmin*(Thin - Tcin);
% 
% %Compute effectiveness
% NTU = heatExchanger.UA/Cmin;


if cycleCold.quality < 1
    
    %heat capacity rates
    heatCapacityRateHot = cycleHot.flowRate*(1-cycleCold.quality)*cycleHot.fluid.heatCapacity;
    heatCapacityRateCold = cycleCold.flowRate*(1-cycleCold.quality)*cycleCold.fluid.heatCapacity;

    Cmin = min(heatCapacityRateHot,heatCapacityRateCold);
    Cmax = max(heatCapacityRateHot,heatCapacityRateCold);

    %heat capacity rates ratio
    c = Cmin/Cmax;
    %Compute effectiveness
    NTU = heatExchanger.UA/Cmin;    
    %For counterflow arrangement
    effectiveness = (1 - exp(-NTU*(1-c)))/(1 - c*exp(-NTU*(1-c)));
    
    %maximum heat transfer rate
    Qmax = Cmin*(Thin - Tcin);
    
    %heat transfer rate between the fluids
    Q = effectiveness*Qmax;
    
    Tho = temp(Q,heatCapacityRateHot,Thin);
    
    if cycleCold.quality == 0 && Q/heatCapacityRateCold < (cycleCold.fluid.boilingPoint - Tcin) %fluid under boiling point
        %set cold fluid out temperature
        Tco = Tcin + Q/heatCapacityRateCold;
        cycleCold.quality = 0;
    else %fluid starts boiling
        %set cold out temperature to boiling temperature
        Tco = cycleCold.fluid.boilingPoint;
        
        %Take fluid to boiling point and compute new Qmax
        QmaxBoiling = Cmin*(Thin - cycleCold.fluid.boilingPoint);
        
        %evaporator effectiveness
        effectivenessEvaporator = 1 - exp(-NTU);
        
        %new transfer rate
        Qboiling = effectivenessEvaporator*QmaxBoiling;
        
        %check how much vapor now present
        vaporProduction = Qboiling/cycleCold.fluid.latentHeatEvaporation + cycleCold.quality;
        
        if vaporProduction <= cycleCold.flowRate %all fluid does not boil
            cycleCold.quality = vaporProduction/cycleCold.flowRate;
        else %all fluid does boil
            cycleCold.quality = 1;
            
            %heat capacity rates
            heatCapacityRateCold = cycleCold.flowRate*cycleCold.fluid.heatCapacityVapor;

            Cmin = min(heatCapacityRateHot,heatCapacityRateCold);

            Qmax = Cmin*(Thin - cycleCold.fluid.boilingPoint);
            
            %Compute effectiveness
            NTU = heatExchanger.UA/Cmin; 

            effectivenessEvaporator = 1 - exp(-NTU);

            QnewNew = effectivenessEvaporator*Qmax;

            Tco = Tcin + QnewNew/heatCapacityRateCold;
        end
    end
else %for case when fluid is all vapor
    %heat capacity rates
    heatCapacityRateHot = cycleHot.flowRate*cycleHot.fluid.heatCapacity;
    heatCapacityRateCold = cycleCold.flowRate*cycleCold.fluid.heatCapacityVapor;

    Cmin = min(heatCapacityRateHot,heatCapacityRateCold);

    Qmax = Cmin*(Thin - cycleCold.fluid.boilingPoint);
    
    %Compute effectiveness
    NTU = heatExchanger.UA/Cmin; 
    
    effectivenessEvaporator = 1 - exp(-NTU);
    
    Qvapor = effectivenessEvaporator*Qmax;

    Tco = Tcin + Qvapor/heatCapacityRateCold;   
    
    Tho = temp(Qvapor,heatCapacityRateHot,Thin);
    
end



% %Check if boiling is happening
% if Q/heatCapacityRateCold < (cycleCold.fluid.boilingPoint - Tcin)
%     %set cold fluid out temperature
%     Tco = Tcin + Q/heatCapacityRateCold;
%     quality = 0;
% 
% else   
%     %set cold out temperature to boiling temperature
%     Tco = cycleCold.fluid.boilingPoint;
%     
%     %Take fluid to boiling point and compute new Qmax
%     QmaxNew = Cmin*(Thin - cycleCold.fluid.boilingPoint);
%     
%     %evaporator effectiveness
%     effectivenessEvaporator = 1 - exp(-NTU);
%     
%     %new transfer rate
%     Qnew = effectivenessEvaporator*QmaxNew;
%     
%     %check how much vapor produced
%     vaporProduction = Qnew/cycleCold.fluid.latentHeatEvaporation;
%         
%     if vaporProduction <= cycleCold.flowRate
%         quality = vaporProduction/cycleCold.flowRate;
%     else
%         quality = 1;
%         
%         %heat capacity rates
%         %heatCapacityRateHot = flowRateHot*fluidHot.heatCapacity;
%         heatCapacityRateCold = cycleCold.flowRate*cycleCold.fluid.heatCapacityVapor;
% 
%         Cmin = min(heatCapacityRateHot,heatCapacityRateCold);
%         %Cmax = max(heatCapacityRateHot,heatCapacityRateCold);
%         
%         QmaxNewNew = Cmin*(Thin - cycleCold.fluid.boilingPoint);
%         
%         QnewNew = effectiveness*QmaxNewNew;
%         
%         Tco = Tco + QnewNew/heatCapacityRateCold;
%     end      
% end




end

function e = exchangerEffectiveness(state)
    if state == 0
        %For counterflow arrangement
        e = (1 - exp(-NTU*(1-c)))/(1 - c*exp(-NTU*(1-c)));
    elseif state == 1
        e = 1 - exp(-NTU);
    else
        e = 1;
    end
end

function T = temp(Q,heatCapacityRateHot,Thin)
%The hot liquid always cools down
    T = Thin - Q/heatCapacityRateHot;
end

        


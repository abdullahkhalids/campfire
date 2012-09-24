function [Tplus Tminus] = errorAnalysis(structure,parameter,delta)
%ERRORANALYSIS


warning off;

for i='+-'
    %get user simulation constants
    constants;
    
    evalc([structure '.' parameter '=' structure '.' parameter i delta]);
    
    %reset random number stream
    defaultStream = RandStream.getDefaultStream;
    load('randstream');
    defaultStream.State = savedState;
    
    %rest of simulation parameters
    calculations;
    
    %optical model
    [~,PowerReceiver, ~, receiver.effectiveLength] = OpticalModelLinear(simulation,trough,receiver,sun,atmosphere);
    
    %Output temperature from receiver
    collectorCycle.outletTemperature = ReceiverTemperatureLinear(receiver, PowerReceiver, collectorCycle, atmosphere,simulation);
        
    T = collectorCycle.outletTemperature - collectorCycle.inletTemperature;
    
    if i=='+'
        Tplus = T;
    else
        Tminus = T;
    end
end

end


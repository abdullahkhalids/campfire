function [Savings energySaved] = FieldInstantSavings(FinalTemperature,field,collectorCycle,alternateFuel)
%FIELDSAVINGS

heaterEffeciency = 0.95;

% if don't exceed the desired temp
if FinalTemperature < field.desiredTemperature
    deltaT = FinalTemperature - field.inletTemperature;
else
    deltaT = field.desiredTemperature - field.inletTemperature;
end

energySaved = field.totalFlowRate * collectorCycle.fluid.heatCapacity * deltaT /heaterEffeciency;

Savings = alternateFuel.joulePrice * energySaved;


end


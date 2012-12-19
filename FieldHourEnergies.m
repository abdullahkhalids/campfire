function [FieldEnergy,BoilerEnergy] = FieldHourEnergies(FinalTemperature,field,collectorCycle,alternateFuel)
%FIELDDAYCOSTING Computes the energy saved by the field and the cost of
%heating with an alternate fuel.

% if don't exceed the desired temp
if FinalTemperature < field.desiredTemperature
    deltaT = FinalTemperature - field.inletTemperature;
    deltaT2 = field.desiredTemperature - FinalTemperature;
else
    deltaT = field.desiredTemperature - field.inletTemperature;
    deltaT2 = 0;
end

FieldEnergy = field.totalFlowRate * collectorCycle.fluid.density*collectorCycle.fluid.heatCapacity * deltaT/field.transmissionLoss;

BoilerEnergy = field.totalFlowRate * collectorCycle.fluid.density*collectorCycle.fluid.heatCapacity * deltaT2 /alternateFuel.heaterEffeciency;



end


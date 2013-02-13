function [LCOE,EnergyProduced,TotalCost] = PlantLCOE(field,trough,receiver,simulation,location,sun,collectorCycle,atmosphere,alternateFuel,costTable)
%FIELDLCOE Compute the LCOE of the field

%% Compute energies
[YearFieldEnergy YearBoilerEnergy,~,~,~,trough,receiver,~,field] = PlantYearEnergies(field,simulation,location,trough,receiver,sun,collectorCycle,atmosphere,alternateFuel);
disp('Energies');
disp(YearFieldEnergy);
disp(YearBoilerEnergy);
EnergyProduced = (YearFieldEnergy+YearBoilerEnergy)*field.life;

%% Do the Costing
%capital cost
CapitalCost = FieldCost(field,trough,receiver,costTable);
%maintainence cost
MaintainenceCost = CapitalCost*field.maintainencePercentage*field.life;
%heating cost
BoilerCost = YearBoilerEnergy*field.life*alternateFuel.joulePrice;

TotalCost = CapitalCost+MaintainenceCost+BoilerCost;
disp('Costs');
disp(CapitalCost);
disp(MaintainenceCost);
disp(BoilerCost);
%% Compute LCOE
LCOE = TotalCost/EnergyProduced;

end


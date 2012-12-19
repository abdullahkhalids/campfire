tic
constants;
costs;


[LCOE,EnergyProduced,TotalCost] = PlantLCOE(field,trough,receiver,simulation,location,sun,collectorCycle,atmosphere,alternateFuel,costTable);


toc

disp(['LCOE for your plant = ' num2str(LCOE)]);
disp(['Energy Produced = ' num2str(EnergyProduced)]);
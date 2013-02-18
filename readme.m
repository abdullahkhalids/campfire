% Version 8.2.
% Frozen February 18, 2013 6:10 pm.

% Please start with constants.m. Define the properties of your system. Most
% properties are self explanatory.

% Then run either mainLinear.m or mainCircular.m depending on whether you
% have a structure with a constant cross-section or one with rotational
% symmetry.

% New
% * Made speed improvements
% * Intead of interpolation, now polynomials are compuated for materials.

% Notes
% 1. optical model
% 2. thermal model
% 3. costing
% 
% trough.material
% 1. refractiveIndex, reflectivity 3. density
% 
% receiver.absorber
% 2. emissivity, thermalConductivity, absorptance
% 
% receiver.sleeve
% 2. emissivity, absorptance
% 
% receiver.gas
% 2. thermalDiffusivityTable, viscosityTable, prandtlNumberTable, thermalConductivityTable
% 
% collectorCycle.fluid
% 2. viscosityTable, densityTable, heatCapacityTable, heatConductivityTable
% 
% atmosphere
% 2. viscosityTable, prandtlNumberTable, thermalConductivityTable

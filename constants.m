%% Constants
dataValues;

%% Sim area
simulation = struct();
simulation.size = [2 2];
simulation.grainLength = 1e-3;
simulation.randCheck = false;
simulation.randStreamName = 'randstream';
simulation.receiverSegmentLength = 0.2;
simulation.time = 60*60;

%% Trough Characteristics
trough = struct();
trough.name = 'trough';
trough.focalLength = 0.3;
trough.focusCoordinates = [0 0];
trough.orientationAngle = 0;
trough.width = 1;
trough.length = 2.5;
trough = mergeStructs(trough,aluminium);
trough.material = 'alref1';
trough.surfaceStdDev = [12e-3 12e-3]; %rad [width length]
% trough.specularity = 0.9;
trough.specularityStdDev = 2e-3;
trough.halfQuantization = 1;
trough.trackingError = deg2rad(0);
trough.reflectivity = 0.85; % 0.95
trough.reflector.type = 'sheet';
trough.bearing = 0;
trough.reflectivityCheck = true; %if true, then use reflectivity, otherwise fresnel

%% Receiver Characteristics
receiver = struct();
receiver.name = 'receiver';
receiver.extraLength = 0;
receiver.surfaceStdDev = 0.5e-3;
receiver.mislocation = [0 0];
receiver.absorber = struct();
receiver.absorber.type = 'pipe';
receiver.absorber = mergeStructs(receiver.absorber,cermet);
receiver.absorber.diameter = 0.050; %m
receiver.absorber.thickness = 0.0029; %m
receiver.sleeve = struct();
receiver.sleeve.type = 'pipe';
receiver.sleeve.diameter = 0.110; %m
receiver.sleeve.thickness = 0.002; %m
receiver.sleeve = mergeStructs(receiver.sleeve,glass);
receiver.gas = air;
receiver.annulusCheck = true;
receiver.annulus = struct();
receiver.annulus.diameter = 0.020; %m
receiver.bracketSpacing = 4;

%% Collector cycle
collectorCycle = struct();
collectorCycle.fluid = water;
collectorCycle.flowRate = 1/60/1000; % 0.5; %m^3/s 1g/m-->0.00378541*60m^3/s 
collectorCycle.inletTemperature = celcius2kelvin(25);
collectorCycle.outletTemperature = 'default';
collectorCycle.type = 'fluid';

%% Field
field = struct();
field.life = 5; %years
field.maintainencePercentage = 5e-2; % percentage
field.series = 1;
field.parallel = 50;
field.totalFlowRate = 10/60/1000; %m^3/s
field.inletTemperature = celcius2kelvin(25);
field.desiredTemperature = celcius2kelvin(80);
field.performanceHours = [9 11 1 3];
field.representativeHours = 2; %fix this
field.performanceMonths = [1 4 7 10];
field.representativeMonths = 3;
field.transmissionLoss = 0.85;

%% Sun Characteristics
sun = struct();
sun.halfQuantization = 1;
sun.irradiance = 600; %look at this
sun.halfAngle = deg2rad(min2deg(16));

%% Location
location = lahore;
location.date = [21 6];
location.time = [12 10];

%% Atmosphere
atmosphere = struct();
atmosphere = mergeStructs(atmosphere,air);
atmosphere.gravity = 9.81;
atmosphere.temperature = celcius2kelvin(25);
atmosphere.windSpeed = 1;
atmosphere.pressure = 'default';

%% alternate fuel
alternateFuel = suigas;
alternateFuel.heaterEffeciency =1; %percentage

% %% trough structure
% troughStructure = struct();
% troughStructure.type = 'pipe';
% troughStructure.material = 'ssrod';
% troughStructure.diameter = 0.01;
% troughStructure.thickness = 0.01;
% troughStructure.widthInterval = 0.2;


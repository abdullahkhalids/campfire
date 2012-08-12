%% Constants
dataValues;

%% Sim area
simulation = struct();
simulation.size = [2 2];
simulation.grainLength = 1e-3;
simulation.receiverSegmentLength = 0.1;

%% Trough Characteristics
trough = struct();
trough.focalLength = 0.2;
trough.focusCoordinates = [0 0];
trough.orientationAngle = 0;
trough.width = 1;
trough.length = 10;
trough = mergeStructs(trough,aluminium);
trough.surfaceStdDev = 10e-3; %rad
trough.specularity = 0.85;
trough.specularityStdDev = 5e-3;
trough.halfQuantization = 1;
trough.trackingError = deg2rad(0);

%% Receiver Characteristics
receiver = struct();
receiver.extraLength = 0;
receiver.surfaceStdDev = 0.5e-3;
receiver.mislocation = [0 0];
receiver.absorber = struct();
receiver.absorber = mergeStructs(receiver.absorber,copper);
receiver.absorber.diameter = 0.012; %m
receiver.absorber.thickness = 0.002; %m
receiver.sleeve = struct();
receiver.sleeve.diameter = 0.039; %m
receiver.sleeve.thickness = 0.02; %m
receiver.sleeve = mergeStructs(receiver.sleeve,glass);
receiver.gas = air;

%% Collector cycle
collectorCycle = struct();
collectorCycle.fluid = oil;
collectorCycle.flowRate = 0.5; %kg/s
collectorCycle.inletTemperature = 'default';
collectorCycle.outletTemperature = 'default';

%% Turbine cycle
turbineCycle = struct();
turbineCycle.fluid = butane;
turbineCycle.flowRate = 0.005; %kg/s 0.005
turbineCycle.quality = 0;

%% Sun Characteristics
sun = struct();
sun.halfQuantization = 1;

%% Location
location = lahore;
location.date = [21 6];
location.time = [12 10];

%% Atmosphere
atmosphere = struct();
atmosphere = mergeStructs(atmosphere,air);
atmosphere.gravity = 9.81;
atmosphere.temperature = 'default';
atmosphere.windSpeed = 'default';
atmosphere.pressure = 'default';

%% Heat Exchangers
heatExchanger = struct();
heatExchanger.UA = 200;

%% Turbine
turbine.efficiency = 0.5;

%%
dish = struct();
dish.focalLength = 0.2;
dish.focusCoordinates = [0 0];
dish.radius = 0.5;
dish = mergeStructs(dish,aluminium);
dish.surfaceStdDev = 10e-3; %rad
dish.specularity = 0.85;
dish.specularityStdDev = 5e-3;
dish.halfQuantization = 1;


% have to define conventions for these angles
dish.yaw = 0; % x-y plane
dish.pitch = 0; % z-y plane
dish.roll = 0; % not needed




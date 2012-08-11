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
trough.refractiveIndex = aluminium.refractiveIndex;
trough.surfaceStdDev = 10e-3; %rad
trough.specularity = 0.85;
trough.specularityStdDev = 5e-3;
trough.halfQuantization = 1;
trough.trackingError = deg2rad(0);

%% Receiver Characteristics
receiver = struct();
receiver.absorberDiameter = 0.012; %m
receiver.absorberThickness = 0.002; %m
receiver.glassSleeveDiameter = 0.039; %m
receiver.glassSleeveThickness = 0.02; %m
receiver.extraLength = 0;
receiver.surfaceStdDev = 0.5e-3;
receiver.emissivity = copper.emissivity;
receiver.absorber = copper;
receiver.gas = air;
receiver.mislocation = [0 0];


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
atmosphere = air;
atmosphere.refractiveIndex = 1;
atmosphere.gravity = 9.81;
atmosphere.temperature = 'default';
atmosphere.windSpeed = 'default';
atmosphere.pressure = 'default';

%% Heat Exchangers
heatExchanger = struct();
heatExchanger.UA = 200;

%% Turbine
turbine.efficiency = 0.5;

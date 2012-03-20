%Constants
dataValues;

%Sim area
simulation = struct();
simulation.size = [2 2];
simulation.grainLength = 1e-3;

%Trough Characteristics
trough = struct();
trough.focalLength = 0.2;
trough.focusCoordinates = [0 0];
trough.orientationAngle = 0;
trough.width = 1;
trough.length = 10;
trough.refractiveIndex = aluminium.refractiveIndex;
trough.surfaceStdDev = 20e-3; %rad
trough.specularity = 0.85;
trough.specularityStdDev = 5e-3;
trough.halfQuantization = 1;
trough.trackingError = deg2rad(0);

%Receiver Characteristics
receiver = struct();
%receiver.radius = 0.03;
receiver.extraLength = 1;
receiver.surfaceStdDev = 0.5e-3;
receiver.emissivity = copper.emissivity;
receiver.absorber = copper;
receiver.gas = air;
receiver.innerDiameterAbsorber = 0.0508; %m
receiver.outerDiameterAbsorber = receiver.innerDiameterAbsorber + 0.002; %m
receiver.innerDiameterGlassSleeve = receiver.outerDiameterAbsorber + 0.02; %m
receiver.outerDiameterGlassSleeve = receiver.innerDiameterGlassSleeve + 0.007; %m

%Collector cycle
collectorCycle = struct();
collectorCycle.fluid = oil;
collectorCycle.flowRate = 0.5; %kg/s

%Turbine cycle
turbineCycle = struct();
turbineCycle.fluid = butane;
turbineCycle.flowRate = 0.005; %kg/s 0.005
turbineCycle.quality = 0;

%Sun Characteristics
sun = struct();
sun.halfQuantization = 1;

%Location
location = lahore;
location.date = [21 6];
location.time = [12 10];

%Atmosphere
atmosphere = air;
atmosphere.refractiveIndex = 1;
atmosphere.gravity = 9.81;

%Heat Exchangers
heatExchanger = struct();
heatExchanger.UA = 200;

%Turbine
turbine.efficiency = 0.5;

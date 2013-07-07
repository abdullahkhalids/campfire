%% Constants
dataValues;

%% Sim area
simulation = struct();
simulation.size = [2 2];
simulation.grainLength = 1e-3;
simulation.receiverSegmentLength = 0.2;
simulation.time = 60*60;

%% Trough Characteristics
trough = struct();
trough.name = 'trough';
trough.type = 'sheet';
trough.focalLength = 1.84;
trough.focusCoordinates = [0 0];
trough.orientationAngle = 0;
trough.width = 5;
trough.length = 7.8;
trough = mergeStructs(trough,aluminium);
trough.surfaceStdDev = 5e-3; %rad
trough.specularity = 0.98;
trough.specularityStdDev = 1e-3;
trough.halfQuantization = 1;
trough.trackingError = deg2rad(0);

%% Receiver Characteristics
receiver = struct();
receiver.name = 'receiver';
receiver.extraLength = 0;
receiver.surfaceStdDev = 0.5e-3;
receiver.mislocation = [0 0];
receiver.absorber = struct();
receiver.absorber.type = 'pipe';
receiver.absorber = mergeStructs(receiver.absorber,copper);
receiver.absorber.diameter = 0.070; %m
receiver.absorber.thickness = 0.004; %m
receiver.sleeve = struct();
receiver.sleeve.type = 'pipe';
receiver.sleeve.diameter = 0.115; %m
receiver.sleeve.thickness = 0.004; %m
receiver.sleeve = mergeStructs(receiver.sleeve,glass);
receiver.gas = air;
receiver.annulusCheck = true;
receiver.annulus = struct();
receiver.annulus.diameter = 0.0508; %m

%% Collector cycle
collectorCycle = struct();
collectorCycle.fluid = water;
collectorCycle.flowRate = 20.7/1000/60; %m^3/s
collectorCycle.inletTemperature = celcius2kelvin(29.5);
collectorCycle.outletTemperature = 'default';
collectorCycle.type = 'fluid';

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
atmosphere.temperature = celcius2kelvin(38.4);
atmosphere.windSpeed = 0;
atmosphere.pressure = 'default';

%% Heat Exchangers
heatExchanger = struct();
heatExchanger.UA = 200;

%% Turbine
turbine.efficiency = 0.5;

%% Dish
dish = struct();
dish.name = 'dish';
dish.type = 'sheet';
dish.focalLength = 0.2;
dish.focusCoordinates = [0 0];
dish.radius = 3;
dish = mergeStructs(dish,aluminium);
dish.surfaceStdDev = 10e-3; %rad
dish.specularity = 0.85;
dish.specularityStdDev = 5e-3;
dish.halfQuantization = 1;
% have to define conventions for these angles
dish.yaw = 0; % x-y plane
dish.pitch = 0; % z-y plane
dish.roll = 0; % not needed

%% Central receiver
pointReceiver = struct();
pointReceiver.radius = 0.05; %m %radius of aperature
pointReceiver.area = 6*0.4*0.4; %0.5*0.3*6; %m^2
pointReceiver.mislocation = [0 0];
pointReceiver.mass = 10; %kg
pointReceiver = mergeStructs(pointReceiver,ceramic);
pointReceiver.pipe.length = 40; %m
pointReceiver.pipe.radius = 0.0025; %m

%% Stirling receiver
stirlingReceiver = struct();
stirlingReceiver.radius = 0.05; %m
stirlingReceiver.area = 6*0.4*0.4; %m^2
stirlingReceiver.mislocation = [0 0];
stirlingReceiver.mass = 10; %kg
stirlingReceiver = mergeStructs(stirlingReceiver,ceramic);
stirlingReceiver.plate.length = 0.3; %m
stirlingReceiver.plate.width = 0.005; %m
stirlingReceiver.plate = mergeStructs(stirlingReceiver.plate,stainlessSteel);
stirlingReceiver.plate.desiredTemperature = celcius2kelvin(100);

%Constants
dataValues;

%Sim area
simulation = struct();
simulation.size = [1 1];
simulation.grainLength = 1e-3;

%Trough Characteristics
trough = struct();
trough.focalLength = 0.2;
trough.focusCoordinates = [0 0];
trough.orientationAngle = 0;
trough.width = 1.5;
trough.refractiveIndex = AluminiumRefractiveIndex;
trough.surfaceStdDev = 0;%5e-3; %rad
trough.specularity = 0.85;
trough.specularityStdDev = 20e-3;
trough.halfQuantization = 1;

%Receiver Characteristics
receiver = struct();
receiver.radius = 0.05;
receiver.surfaceStdDev = 0.5e-3;

%Sun Characteristics
sun = struct();
sun.halfAngle = deg2rad(min2deg(16));
sun.irradiance = 1000;
sun.halfQuantization = 1;

%atmosphere
atmosphere = struct();
atmosphere.refractiveIndex = 1;
atmosphere.windSpeed = 0; %km/h

%location
location.latitude = [31 32 59];
location.longitude = [74 20 37];
location.date = [15 2];
location.time = 12;
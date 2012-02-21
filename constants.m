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
trough.width = 1;
trough.length = 10;
trough.refractiveIndex = AluminiumRefractiveIndex;
trough.surfaceStdDev = 20e-3; %rad
trough.specularity = 0.85;
trough.specularityStdDev = 5e-3;
trough.halfQuantization = 1;

%Receiver Characteristics
receiver = struct();
receiver.radius = 0.04;
receiver.length = 11;
receiver.surfaceStdDev = 0.5e-3;
receiver.emissivity = CopperEmissivity;

%Receiver fluid
receiverFluid.speed = 0.1;
receiverFluid.density = rho_water;
receiverFluid.heatCapacity = cp_water;

%Sun Characteristics
sun = struct();
sun.halfAngle = deg2rad(min2deg(16));
sun.halfQuantization = 1;

%atmosphere
atmosphere = struct();
atmosphere.refractiveIndex = 1;
atmosphere.windSpeed = 1; %m/s


%location
location.timezoneLongitude = 75; %E
location.latitude = [31 32 59]; %N
location.longitude = [74 20 37];%E
location.date = [21 6];
location.time = [12 10];
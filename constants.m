%Constants
dataValues;

%Sim area
simulation = struct();
simulation.size = [1 1];
simulation.grainLength = 1e-3;

%Trough Characteristics
trough = struct();
trough.focalLength = 0.4;
trough.focusCoordinates = [0 0];
trough.rotAngle = deg2rad(0);
trough.width = 2;
trough.refractiveIndex = AluminiumRefractiveIndex;

%Receiver Characteristics
receiver = struct();
receiver.radius = 0.05;

%Sun Characteristics
sun = struct();
sun.positionAngle = deg2rad(4);
sun.halfAngle = deg2rad(min2deg(16));
sun.intensity = 1000;

%atmosphere
atmosphere = struct();
atmosphere.refractiveIndex = 1;
atmosphere.windSpeed = 0; %km/h
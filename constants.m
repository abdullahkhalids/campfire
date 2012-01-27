%Constants

%Sim area
simulation = struct();
simulation.size = [1 1];
simulation.grainSize = 1e-3;
%simulation.numberOfReflections = 2;

%Trough Characteristics
trough = struct();
trough.focalLength = 0.3;
trough.focusCoordinates = [0 0];
trough.rotAngle = deg2rad(22);
trough.width = 1.4;
trough.refractiveIndex = 1.65;

%Receiver Characteristics
receiver = struct();
receiver.radius = 0.05;

%Sun Characteristics
sun = struct();
sun.positionAngle = deg2rad(30);
sun.halfAngle = deg2rad(min2deg(16));
sun.intensity = 1000;

%atmosphere
atmosphere = struct();
atmosphere.refractiveIndex = 1;
atmosphere.windSpeed = 0; %km/h
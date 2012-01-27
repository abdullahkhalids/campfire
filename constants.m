

%Constants

%sim area
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
trough.height = TroughHeight(trough.focalLength,trough.width);
trough.rimAngle = TroughRimAngle(trough.focalLength, trough.width);

%Receiver Characteristics
receiver = struct();
receiver.radius = 0.05;
receiver.position = trough.focusCoordinates;

%Sun Characteristics
sun = struct();
sun.positionAngle = deg2rad(30);
sun.halfAngle = deg2rad(min2deg(16));
sun.intensity = 1000;
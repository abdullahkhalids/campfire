clc;
tic
%set up simulation constants
constants;

%set up some simulation factors
simulation.grainVolume = (simulation.grainLength)^2;

%compute trough coordinates
trough.height = TroughHeight(trough.focalLength,trough.width);
trough.rimAngle = TroughRimAngle(trough.focalLength, trough.width);
trough.coordinates = TroughCoordinates(trough, simulation);
trough.gradients = Gradient(trough.coordinates);
trough.gradientsNormal = GradientNormal(trough.coordinates);
trough.anglesNormal =  AngleNormal(trough.gradients);
trough.coordinates = trough.coordinates(:,2:end-1); %throw away the coordinates no longer needed

%compute receiver coordinates
receiver.position = trough.focusCoordinates;
receiver.coordinates = RecieverCoordinates(receiver, simulation);

%compute the receiver distribution
receiverDistribution = ReceiverIntensityDistribution(simulation,trough,receiver,sun,atmosphere);

% p = 1000;
% plotter;
toc
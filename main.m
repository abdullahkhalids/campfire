clear all; clc;

%set up simulation constants
constants;

%compute trough coordinates
trough.height = TroughHeight(trough.focalLength,trough.width);
trough.rimAngle = TroughRimAngle(trough.focalLength, trough.width);
trough.coordinates = TroughCoordinates(trough, simulation);
trough.gradients = Gradient(trough.coordinates);
trough.normalGradient = GradientNormal(trough.coordinates);
trough.normalAngles =  NormalAngle(trough.gradients);

%compute receiver coordinates
receiver.position = trough.focusCoordinates;
receiver.coordinates = RecieverCoordinates(receiver, simulation);

%compute the receiver distribution
receiverDistribution = ReceiverIntensityDistribution(trough,receiver,sun,atmosphere);

% p = 1000;
% plotter;

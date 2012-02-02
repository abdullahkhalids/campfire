clear all; close all; clc;
tic
%set up simulation constants
constants;

%set up some simulation factors
simulation.grainVolume = (simulation.grainLength)^2;

%compute receiver coordinates
receiver.position = trough.focusCoordinates;
receiver.coordinates = RecieverCoordinates(receiver, simulation);

totalIntensity = trough.width*sun.intensity;

k = 1;

for f=0.05:0.1:4
    
    trough.focalLength = f;
    %compute trough coordinates
    trough.height = TroughHeight(trough.focalLength,trough.width);
    trough.rimAngle = TroughRimAngle(trough.focalLength, trough.width);
    trough.coordinates = TroughCoordinates(trough, simulation);
    trough.gradients = Gradient(trough.coordinates);
    trough.gradientsNormal = GradientNormal(trough.coordinates);
    trough.anglesNormal =  AngleNormal(trough.gradients);
    trough.coordinates = trough.coordinates(:,2:end-1); %throw away the coordinates no longer needed
    %compute the receiver distribution
    receiverDistribution = ReceiverIntensityDistribution(simulation,trough,receiver,sun,atmosphere);

    interceptFactor(k) = sum(receiverDistribution)/totalIntensity*100;
    disp(['Intercept Factor(f = ' num2str(f) ') = ' num2str(interceptFactor(k))]);
    k = k+1;
end

plot(interceptFactor,f);

toc
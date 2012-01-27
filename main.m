clear all; clc;

tic
%set up simulation constants
constants;

%compute trough coordinates
trough.coordinates = TroughCoordinates(trough, simulation);
trough.gradients = Gradient(trough.coordinates);
trough.normalGradient = GradientNormal(trough.coordinates);
trough.normalAngles =  NormalAngle(trough.gradients);

%compute receiver coordinates
receiver.coordinates = RecieverCoordinates(receiver, simulation);

%Compute the incidence angles of the center of the incident sun cone with
%the surface normal
incidenceAngles = trough.normalAngles - sun.positionAngle;

%Given the sun's position, compute the angle the center of the reflected
%cone makes with the vertical.
reflectedAngles = 2*trough.normalAngles - sun.positionAngle;

%gradient of reflected ray
gradientReflected = 1./tan(reflectedAngles);

%compute intersections of reflected rays with receiver
[x,y] = LineCircleIntersection(trough,gradientReflected,receiver);

%compute which of the receiver points each of the rays ends up at
indexes = IntersectionIndexes(receiver.coordinates,x,y);

%the trough receives a uniform intensity from the sun
troughReceivedIntesities(1:length(trough.coordinates),1) = sun.intensity;

%add up all the intensities at the receiver for each point
receiverReceivedIntensities = zeros(length(receiver.coordinates),1);
for i=1:length(trough.coordinates)
    if indexes(i)~=0
        receiverReceivedIntensities(indexes(i)) = receiverReceivedIntensities(indexes(i)) + troughReceivedIntesities(i);
    end
end

% p = 1000;
% plotter;
toc
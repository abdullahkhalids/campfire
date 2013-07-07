clc; 
tic
%set up simulation constants
constants;

%set up some simulation factors
simulation.grainVolume = (simulation.grainLength)^2;

%sun
sun.positionVector = [sin(sun.positionAngle); cos(sun.positionAngle)];
sun.intensityDistribution = PillBox(sun,simulation);
sun.fullQuantization = 2*sun.halfQuantization + 1;

%compute trough coordinates
trough.height = TroughHeight(trough.focalLength,trough.width);
trough.rimAngle = TroughRimAngle(trough.focalLength, trough.width);
trough.coordinates = TroughCoordinates(trough, simulation);
trough.gradients = SurfaceErrors(trough.coordinates,trough.surfaceStdDev);
trough.coordinates = trough.coordinates(:,2:end-1); %throw away the coordinates no longer needed
trough.fullQuantization = 2*trough.halfQuantization + 1;
if trough.halfQuantization == 0; trough.specularity = 1; end;

%compute receiver coordinates
receiver.position = trough.focusCoordinates;
receiver.coordinates = RecieverCoordinates(receiver, simulation);
receiver.gradients = ReceiverGradient(receiver);

%compute the receiver distribution
receiverDistribution = ReceiverIntensityDistribution(simulation,trough,receiver,sun,atmosphere);

toc

TotalEnergy = sum(receiverDistribution);
Efficiency = TotalEnergy/(trough.width*sun.irradiance)*100;
disp(['Power On Receiver = ' num2str(TotalEnergy) 'W'])
disp(['Intercept Factor = ' num2str(Efficiency) '%']);

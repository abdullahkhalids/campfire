tic
%set up simulation constants
constants;

%set up some simulation factors
simulation.grainVolume = (simulation.grainLength)^2;

%sun
[sun.widthAngle sun.lengthAngle sun.daytime] = SunAngles(location.time,location.date,location.latitude,location.longitude,location.timezoneLongitude);
sun.positionVector = [sind(sun.widthAngle); cosd(sun.widthAngle)];
sun.fullQuantization = 2*sun.halfQuantization + 1;
sun.irradiance = SolarIntensity(location.date, location.time); %W/m^2
sun.intensityDistribution = PillBox(sun,simulation);

%atmosphere
atmosphere.temperature = AmbientTemperature(location.date,location.time);

%compute trough coordinates
trough.rotAngle = deg2rad(sun.widthAngle);
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
receiver.troughLength = trough.length;

%compute the receiver distribution for the 2D case
receiverDistribution = ReceiverIntensityDistribution(simulation,trough,receiver,sun,atmosphere);

%Compute the total flux for a 3D case
[PowerReceiver, PowerTrough,InterceptFactor] = Flux3D(receiverDistribution,trough,receiver,sun,simulation);

%Output temperature from receiver
[receiverFluid.outletTemperature, receiverFluid.massFlowRate] = ReceiverTemperatureOutput(receiver, PowerReceiver, receiverFluid, atmosphere);

toc

disp(['Power On Receiver = ' num2str(PowerReceiver) 'W'])
disp(['Intercept Factor = ' num2str(InterceptFactor*100) '%']);
disp(['Output Temperature = ' num2str(receiverFluid.outletTemperature) ' C']);
disp(['Mass Flow Rate = ' num2str(receiverFluid.massFlowRate) ' kg/s']);


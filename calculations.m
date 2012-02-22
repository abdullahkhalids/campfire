%%
%simulation
simulation.grainVolume = (simulation.grainLength)^2;
simulation.randseed = 1;


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
receiver.position = trough.focusCoordinates% + mislocation/sqrt(2);
receiver.coordinates = RecieverCoordinates(receiver, simulation);
receiver.gradients = ReceiverGradient(receiver);
receiver.troughLength = trough.length;

clear rho_water cp_water CopperEmissivity AluminiumRefractiveIndex cp_oil rho_oil

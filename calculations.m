%set up some simulation factors
simulation.grainVolume = (simulation.grainLength)^2;

%sun
sun.halfAngle = deg2rad(min2deg(16));
[sun.widthAngle sun.lengthAngle sun.daytime] = SunAngles(location.time,location.date,location.latitude,location.longitude,location.timezoneLongitude);
sun.positionVector = [sind(sun.widthAngle); cosd(sun.widthAngle)]; %check
sun.fullQuantization = 2*sun.halfQuantization + 1;
sun.irradiance = SolarIntensity(location); %W/m^2
%sun.intensityDistribution = PillBox(sun,simulation);

%atmosphere
atmosphere.temperature = AmbientTemperature(location);
atmosphere.windSpeed = WindSpeed(location);
atmosphere.pressure = atm2bar(1);

%compute trough coordinates
trough.rotAngle = deg2rad(sun.widthAngle) + trough.trackingError;
trough.height = TroughHeight(trough.focalLength,trough.width);
trough.rimAngle = TroughRimAngle(trough.focalLength, trough.width);
trough.coordinates = TroughCoordinates(trough, simulation);
trough.gradients = TroughGradient(trough.coordinates,trough.surfaceStdDev);
trough.coordinates = trough.coordinates(:,2:end-1); %throw away the coordinates no longer needed
trough.fullQuantization = 2*trough.halfQuantization + 1;
if trough.halfQuantization == 0; trough.specularity = 1; end;

%compute receiver stuff
receiver.radius = receiver.outerDiameterAbsorber;
receiver.length = trough.length + receiver.extraLength;
receiver.troughLength = trough.length;
receiver.position = trough.focusCoordinates;
receiver.coordinates = RecieverCoordinates(receiver, simulation);
receiver.gradients = ReceiverGradient(receiver);

%Collector Cycle
collectorCycle.inletTemperature = atmosphere.temperature;
collectorCycle.outletTemperature = atmosphere.temperature;
collectorCycle.speed = fluidSpeed(collectorCycle.flowRate,receiver.radius,collectorCycle.fluid.density);
collectorCycle.quality = 0;

%Turbine Cycle
turbineCycle.turbineInletTemperature = atmosphere.temperature;
turbineCycle.turbineOutletTemperature = atmosphere.temperature;
turbineCycle.inletTemperature = atmosphere.temperature;
turbineCycle.turbineInletPressure = atmosphere.pressure;
turbineCycle.turbineOutletPressure = atmosphere.pressure;
turbineCycle.speed = fluidSpeed(turbineCycle.flowRate,receiver.radius,turbineCycle.fluid.density);
turbineCycle.quality = 1;
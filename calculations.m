%set up some simulation factors
simulation.grainVolume = (simulation.grainLength)^2;

%sun
sun.halfAngle = deg2rad(min2deg(16));
[sun.widthAngle sun.lengthAngle sun.daytime] = SunAngles(location.time,location.date,location.latitude,location.longitude,location.timezoneLongitude,trough.bearing);
sun.positionVector = [sind(sun.widthAngle); cosd(sun.widthAngle)]; %this is only the parabola
sun.fullQuantization = 2*sun.halfQuantization + 1;
sun.irradiance = setValueStructField(sun,'irradiance',SolarIntensity(location)); %W/m^2

%atmosphere
atmosphere.temperature = setValueStructField(atmosphere,'temperature',AmbientTemperature(location));
atmosphere.windSpeed = setValueStructField(atmosphere,'windSpeed',WindSpeed(location));
atmosphere.pressure = setValueStructField(atmosphere,'pressure',atm2bar(1));

%compute trough coordinates
trough.rotAngle = deg2rad(sun.widthAngle) + trough.trackingError;
trough.height = ParabolaHeight(trough.focalLength,trough.width);
trough.rimAngle = ParabolaRimAngle(trough.focalLength, trough.width);
trough.arcLength = ParabolaArcLength(trough.focalLength,trough.width);
trough.area = trough.arcLength*trough.length;
trough.aperature = trough.width*trough.length;
trough.coordinates = ParabolaCoordinates(trough, simulation);
trough.gradients = ParabolaGradient(trough.coordinates,trough.surfaceStdDev);
trough.coordinates = trough.coordinates(:,2:end-1); %throw away the coordinates no longer needed
trough.fullQuantization = 2*trough.halfQuantization + 1;
if trough.halfQuantization == 0; trough.specularity = 1; end;
trough.reflector.length = trough.length;
trough.reflector.width = trough.arcLength;
trough.reflector.material = trough.material;

%compute receiver stuff
receiver.absorber.innerDiameter = receiver.absorber.diameter - receiver.absorber.thickness; %m
receiver.absorber.outerDiameter = receiver.absorber.diameter; %m
receiver.sleeve.innerDiameter = receiver.sleeve.diameter - receiver.sleeve.thickness; %m
receiver.sleeve.outerDiameter = receiver.sleeve.diameter; %m
receiver.radius = receiver.absorber.outerDiameter/2;
receiver.length = trough.length + receiver.extraLength; %m
receiver.absorber.length = receiver.length; %m
receiver.sleeve.length = receiver.length; %m
receiver.position = trough.focusCoordinates + receiver.mislocation;
receiver.coordinates = RecieverCoordinates(receiver, simulation);
receiver.gradients = ReceiverGradient(receiver);
receiver.nBrackets = ceil(receiver.length/receiver.bracketSpacing);

%Collector Cycle
collectorCycle.inletTemperature = setValueStructField(collectorCycle,'inletTemperature', atmosphere.temperature);
collectorCycle.outletTemperature = setValueStructField(collectorCycle,'outletTemperature', atmosphere.temperature);
collectorCycle.area = pi*(receiver.absorber.innerDiameter^2 - receiver.annulus.diameter^2)/4;
collectorCycle.speed = fluidSpeed(collectorCycle.flowRate,receiver.absorber.innerDiameter,collectorCycle.fluid.density,receiver.annulusCheck,receiver.annulus.diameter);
collectorCycle.quality = 0;
collectorCycle.volume = pi*(receiver.radius)^2*receiver.length*3; % 3 is an arbitrary factor here.
collectorCycle.material = collectorCycle.fluid.material;

%troughStructure
troughStructure.length = trough.length*ceil(trough.width/troughStructure.widthInterval);



%Turbine Cycle
turbineCycle.turbineInletTemperature = atmosphere.temperature;
turbineCycle.turbineOutletTemperature = atmosphere.temperature;
turbineCycle.inletTemperature = atmosphere.temperature;
turbineCycle.turbineInletPressure = atmosphere.pressure;
turbineCycle.turbineOutletPressure = atmosphere.pressure;
% turbineCycle.speed = fluidSpeed(turbineCycle.flowRate,receiver.radius,turbineCycle.fluid.density);
turbineCycle.quality = 1;

%Dish
dish.refractiveIndex = aluminium.refractiveIndex;
sun.vector = SunVector(sun);
% dish.axisVector = DishAxisVector(dish);
dish.axisVector = sun.vector;

%Central receiver
pointReceiver.aperatureArea = pi*pointReceiver.radius^2;
pointReceiver.position = dish.focusCoordinates + pointReceiver.mislocation;
pointReceiver.temperature = atmosphere.temperature;
pointReceiver.volume = sqrt(pointReceiver.area/6)^3;
pointReceiver.surfaceStdDev = 0;
pointReceiver.coordinates = -pointReceiver.radius:simulation.grainLength:pointReceiver.radius; 
pointReceiver.coordinates(2,:) = pointReceiver.position(2);
% RecieverCoordinates(pointReceiver, simulation);
pointReceiver.gradients = ReceiverGradient(pointReceiver);

%Stirling receiver
stirlingReceiver.aperatureArea = pi*pointReceiver.radius^2;
stirlingReceiver.position = dish.focusCoordinates + pointReceiver.mislocation;
stirlingReceiver.temperature = atmosphere.temperature;
stirlingReceiver.volume = sqrt(pointReceiver.area/6)^3;
stirlingReceiver.surfaceStdDev = 0;
stirlingReceiver.coordinates = -pointReceiver.radius:simulation.grainLength:pointReceiver.radius; 
stirlingReceiver.coordinates(2,:) = pointReceiver.position(2);
stirlingReceiver.gradients = ReceiverGradient(pointReceiver);
stirlingReceiver.plate.temperature = atmosphere.temperature;
stirlingReceiver.plate.volume = (stirlingReceiver.plate.length)^2*stirlingReceiver.plate.width;

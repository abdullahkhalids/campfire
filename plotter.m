clear all; clc; %close all;

constants;
figure; hold on;hold all;

legendText = char();

%%
%Do some computations
m=1;

radius = 0.005:0.01:0.07;

%for mislocation = 0:0.005:0.03
for y = radius
n = 1;
%width =  0.5:0.1:2;
%hours = 8:16;
surface = 5e-3:5e-3:40e-3;
for x = surface%y=radius
        
    %reset random number stream
    defaultStream = RandStream.getDefaultStream;
    load('Z:\matlab\solar\randstream');
    defaultStream.State = savedState;
    
    %Constants
    dataValues;

    %Sim area
    simulation = struct();
    simulation.size = [1 1];
    simulation.grainLength = 1e-3;

    %Trough Characteristics
    trough = struct();
    trough.focalLength = 0.3;
    trough.focusCoordinates = [0 0];
    trough.orientationAngle = 0;
    trough.width = 1;
    trough.length = 10;
    trough.refractiveIndex = AluminiumRefractiveIndex;
    trough.surfaceStdDev = x;%20e-3; %rad
    trough.specularity = 0.85;
    trough.specularityStdDev = 5e-3;
    trough.halfQuantization = 1;

    %Receiver Characteristics
    receiver = struct();
    receiver.radius = y; %0.025;
    receiver.length = 11;
    receiver.surfaceStdDev = 0.5e-3;
    receiver.emissivity = CopperEmissivity;

    %Receiver fluid
    receiverFluid.speed = 0.1;
    receiverFluid.density = rho_water;
    receiverFluid.heatCapacity = cp_water;

    %Sun Characteristics
    sun = struct();
    sun.halfAngle = deg2rad(min2deg(16));
    sun.halfQuantization = 1;

    %atmosphere
    atmosphere = struct();
    atmosphere.refractiveIndex = 1;
    atmosphere.windSpeed = 1; %m/s


    %location
    location.timezoneLongitude = 75; %E
    location.latitude = [31 32 59]; %N
    location.longitude = [74 20 37];%E
    location.date = [21 6];
    location.time = [12 0];

    %simulation
    simulation.grainVolume = (simulation.grainLength)^2;
    simulation.randseed = 1;


    %sun
    [sun.widthAngle sun.lengthAngle sun.daytime,S] = SunAngles(location.time,location.date,location.latitude,location.longitude,location.timezoneLongitude);
    sun.positionVector = [S(1); S(2)];%[sind(sun.widthAngle); cosd(sun.widthAngle)];
    sun.positionVector = sun.positionVector/norm(sun.positionVector);
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
    receiver.position = trough.focusCoordinates;% - mislocation/sqrt(2);
    receiver.coordinates = RecieverCoordinates(receiver, simulation);
    receiver.gradients = ReceiverGradient(receiver);
    receiver.troughLength = trough.length;

    clear rho_water cp_water CopperEmissivity AluminiumRefractiveIndex cp_oil rho_oil


    %compute the receiver distribution for the 2D case
    receiverDistribution = ReceiverIntensityDistribution(simulation,trough,receiver,sun,atmosphere);

    %Compute the total flux for a 3D case
    [PowerReceiver(n), PowerTrough,InterceptFactor(n)] = Flux3D(receiverDistribution,trough,receiver,sun,simulation);
    n = n+1;


end

    plot(surface,InterceptFactor*100);
    legendText = char(legendText,['Radius = ' num2str(y)]);
    m = m+1;
end

%end
axis([min(surface) max(surface) 0 90]);
xlabel('Surface Deviations/rad');
ylabel('Intercept Factor');
title('Intercept Factor vs Surface Errors');
legendText(1,:) = [];
legend(legendText,-1);
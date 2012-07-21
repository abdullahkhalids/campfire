clear all; clc; %close all;
figure; hold on;hold all;
legendText = char();

%get user simulation constants
constants;

%Set up vectors of changed paramters
focalLength = 0.1:0.1:2;
temp = 50:50:200;

for T=temp

i = 1;
for x = focalLength;
    
    %reset random number stream
    defaultStream = RandStream.getDefaultStream;
    load('Z:\matlab\solar\randstream');
    defaultStream.State = savedState;
    
    trough.focalLength = x;
    trough.width = TroughArcLength2Width(trough,1.2);
    trough.trackingError = deg2rad(0);

    receiver.innerDiameterAbsorber = 0.01; %m
    receiver.outerDiameterAbsorber = receiver.innerDiameterAbsorber + 0.002; %m
    receiver.innerDiameterGlassSleeve = receiver.outerDiameterAbsorber + 0.02; %m
    receiver.outerDiameterGlassSleeve = receiver.innerDiameterGlassSleeve + 0.007; %m

    %rest of simulation parameters
    calculations;

    %post calculation paramters
    collectorCycle.inletTemperature = 273 + T;

    %compute the receiver distribution for the 2D case
    receiverDistribution = ReceiverIntensityDistribution(simulation,trough,receiver,sun,atmosphere);
    %Compute the total flux for a 3D case
    [PowerReceiver, PowerTrough,InterceptFactor] = Flux3D(receiverDistribution,trough,receiver,sun,simulation);
    %Output temperature from receiver
    collectorCycle.outletTemperature = ReceiverTemperatureOutput(receiver, PowerReceiver, collectorCycle, atmosphere);

    %Store important outputs
    Tinc(i) = collectorCycle.outletTemperature - collectorCycle.inletTemperature;
    efficiency(i) = Tinc(i)*collectorCycle.flowRate*collectorCycle.fluid.heatCapacity/PowerReceiver;
    intFac(i) = InterceptFactor;
    powRec(i) = PowerReceiver;
    w(i) = trough.width;
    i = i+1;
end

%Plot
plot(focalLength,Tinc,'LineWidth', 2);
%plot(w,intFac,'LineWidth', 2);
%plot(w,powRec,'LineWidth', 2);
legendText = char(legendText,['Temperature = ' num2str(T) '^o C']);
end


title('Single pass temperature increase vs Focal length at various liquid input temperatures')
xlabel('Focal Length/m');
ylabel('Temperature/K');
legendText(1,:) = [];
legend(legendText,-1,'Location' , 'SouthWest');

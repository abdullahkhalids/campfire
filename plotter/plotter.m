%get user simulation constants
constants;
% 
% receiver.emissivity = stainlessSteel.emissivity;
% receiver.absorber = stainlessSteel;

focalLength = 0.1:0.1:2;
i = 1;

for x = focalLength;

trough.focalLength = x;
trough.width = TroughArcLength2Width(trough,1.2);
trough.trackingError = deg2rad(0);

receiver.innerDiameterAbsorber = 0.01; %m
receiver.outerDiameterAbsorber = receiver.innerDiameterAbsorber + 0.002; %m
receiver.innerDiameterGlassSleeve = receiver.outerDiameterAbsorber + 0.02; %m
receiver.outerDiameterGlassSleeve = receiver.innerDiameterGlassSleeve + 0.007; %m

%rest of simulation parameters
calculations;

collectorCycle.inletTemperature = 273 + 100;

%compute the receiver distribution for the 2D case
receiverDistribution = ReceiverIntensityDistribution(simulation,trough,receiver,sun,atmosphere);

%Compute the total flux for a 3D case
[PowerReceiver, PowerTrough,InterceptFactor] = Flux3D(receiverDistribution,trough,receiver,sun,simulation);

%Output temperature from receiver
collectorCycle.outletTemperature = ReceiverTemperatureOutput(receiver, PowerReceiver, collectorCycle, atmosphere);

Tinc(i) = collectorCycle.outletTemperature - collectorCycle.inletTemperature;
efficiency(i) = Tinc(i)*collectorCycle.flowRate*collectorCycle.fluid.heatCapacity/PowerReceiver;

intFac(i) = InterceptFactor;
powRec(i) = PowerReceiver;
w(i) = trough.width;

i = i+1;

end

plot(w,Tinc,'LineWidth', 2);
figure;
plot(w,intFac);
figure;
plot(w,powRec);
title('Single pass temperature increase at 200^o C')
xlabel('Length/m');
ylabel('Temperature/K');
hold on;

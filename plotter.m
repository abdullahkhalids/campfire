%get user simulation constants
constants;

radius = [0.005:0.005:0.09];
i = 1;
for r = radius;

receiver.innerDiameterAbsorber = r;

receiver.outerDiameterAbsorber = receiver.innerDiameterAbsorber + 0.002; %m
receiver.innerDiameterGlassSleeve = receiver.outerDiameterAbsorber + 0.02; %m
receiver.outerDiameterGlassSleeve = receiver.innerDiameterGlassSleeve + 0.007; %m


    
%rest of simulation parameters
calculations;

collectorCycle.inletTemperature = 573;

%compute the receiver distribution for the 2D case
receiverDistribution = ReceiverIntensityDistribution(simulation,trough,receiver,sun,atmosphere);

%Compute the total flux for a 3D case
[PowerReceiver, PowerTrough,InterceptFactor] = Flux3D(receiverDistribution,trough,receiver,sun,simulation);

%Output temperature from receiver
collectorCycle.outletTemperature = ReceiverTemperatureOutput(receiver, PowerReceiver, collectorCycle, atmosphere);

Tinc(i) = collectorCycle.outletTemperature - collectorCycle.inletTemperature;
efficiency(i) = Tinc(i)*collectorCycle.flowRate*collectorCycle.fluid.heatCapacity/PowerReceiver;

intFac(i) = InterceptFactor;

i = i+1;

end

plot(radius,Tinc,'LineWidth', 2)
title('Single pass temperature increase at 200^o C')
xlabel('Radius/m');
ylabel('Temperature/K');

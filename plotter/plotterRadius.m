clear all; clc; %close all;
figure; hold on;hold all;
legendText = char();

%get user simulation constants
constants;


%Set up vectors of changed paramters
radius = [0.005:0.005:0.06];
temp = 50:50:200;

for T=temp

i = 1;
for r = radius;
    
    %reset random number stream
    defaultStream = RandStream.getDefaultStream;
    load('Z:\matlab\solar\randstream');
    defaultStream.State = savedState;

    %rest of simulation parameters
    calculations;

    %post calculation paramters
    collectorCycle.inletTemperature = 273 + T;

    %optical model
    [InterceptFactor,PowerReceiver, PowerTrough, receiver.effectiveLength] = OpticalModelLinear(simulation,trough,receiver,sun,atmosphere);

    %Output temperature from receiver
    collectorCycle.outletTemperature = ReceiverTemperatureLinear(receiver, PowerReceiver, collectorCycle, atmosphere,simulation);

    %Store important outputs
    Tinc(i) = collectorCycle.outletTemperature - collectorCycle.inletTemperature;
    efficiency(i) = Tinc(i)*collectorCycle.flowRate*collectorCycle.fluid.heatCapacity/PowerReceiver;
    intFac(i) = InterceptFactor;
    i = i+1;
end

%Plot
plot(radius,Tinc,'LineWidth', 2);
legendText = char(legendText,['Temperature = ' num2str(T) '^o C']);
end


title('Single pass temperature increase vs Radius at various liquid input temperatures')
xlabel('Radius/m');
ylabel('Temperature/K');
legendText(1,:) = [];
legend(legendText,-1,'Location' , 'SouthWest');

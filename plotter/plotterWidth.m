clear all; clc; %close all;
figure; hold on;hold all;
legendText = char();

%get user simulation constants
constants;


%Set up vectors of changed paramters
width = 0.1:0.1:1.5;




i = 1;
for x = width;
    
    %reset random number stream
    defaultStream = RandStream.getDefaultStream;
    load('/media/Abd/home/Dropbox/Solar/Code/randstream');
    defaultStream.State = savedState;

    trough.width = x;
    %rest of simulation parameters
    calculations;

    %post calculation paramters
%     collectorCycle.inletTemperature = 273 + T;

    %compute the receiver distribution for the 2D case
    receiverDistribution = ReceiverIntensityDistribution(simulation,trough,receiver,sun,atmosphere);
    %Compute the total flux for a 3D case
    [PowerReceiver(i), PowerTrough,InterceptFactor(i)] = Flux3D(receiverDistribution,trough,receiver,sun,simulation);
    %Output temperature from receiver
%     collectorCycle.outletTemperature = ReceiverTemperatureOutput(receiver, PowerReceiver, collectorCycle, atmosphere);

    %Store important outputs
%     Tinc(i) = collectorCycle.outletTemperature - collectorCycle.inletTemperature;
%     efficiency(i) = Tinc(i)*collectorCycle.flowRate*collectorCycle.fluid.heatCapacity/PowerReceiver;
%     intFac(i) = InterceptFactor;
    i = i+1;
end

%Plot
% plot(width,InterceptFactor,'LineWidth', 2);
% legendText = char(legendText,'Intercept factor');
% ylabel('InterceptFactor/%');


plot(width,PowerReceiver,'LineWidth',2);
% legendText = char(legendText,'Power on Receiver');
ylabel('Power on receiver');


title('Intercept Factor vs width')
xlabel('Width/m');
legendText(1,:) = [];
legend(legendText,-1,'Location' , 'SouthWest');

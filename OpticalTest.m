clear all;

% inputs
trackingErrors = [0 4.73 9.72 14.99 20.04 25.01];
ambientTemperature = [38.4 28.1 26.4 24.9 24.4 23.7];
inletTemperature = [29.5 29.5 29.4 29.2 29.1 28.9];
insolation = [925.1 919.9 910.0 893.9 888.2 881];
flowRate = [20.7 20.7 20.5 20.5 20.5 20.5];

% predictions
resultOutletTemp = [47.3 47.6 47.0 45.8 44.7 43.5];
resultInterceptFactor = [73.68 73.40 72.79 71.29 68.91 66.06];


%get user simulation constants
opticalModelConstants;

for i=1:6
    trough.trackingError = deg2rad(trackingErrors(i));
    collectorCycle.inletTemperature = celcius2kelvin(inletTemperature(i));
    atmosphere.temperature = celcius2kelvin(ambientTemperature(i));
    collectorCycle.flowRate = flowRate(i)/1000/60;
    
    %rest of simulation parameters
    calculations;
    
    
    sun.irradiance = insolation(i);
    
    %optical model
    [InterceptFactor(i),PowerReceiver, PowerTrough, receiver.effectiveLength] = OpticalModelLinear(simulation,trough,receiver,sun,atmosphere);
    
    %Output temperature from receiver
    outletTempPrediction(i) = ReceiverTemperatureLinear(receiver, PowerReceiver, collectorCycle, atmosphere,simulation);
    
    
    
end
figure;
plot(InterceptFactor,'g-');
hold on;
plot(resultInterceptFactor,'ro');
figure;
plot(kelvin2celcius(outletTempPrediction),'g-');
hold on;
plot(resultOutletTemp,'ro');

clear all
clc

% testType = 'efficiency';
testType = 'thermal';

% material = 'cermet'; 
material = 'cermet';

% gas = 'vacuum';
gas = 'vacuum';


ExperimentalData;
%get user simulation constants
constants

for i = 1:n
    collectorCycle.inletTemperature = celcius2kelvin(inletTemp(i));
    atmosphere.windspeed = windSpeed(i);
    atmosphere.temperature = celcius2kelvin(ambTemp(i));
    collectorCycle.flowRate = flowRate(i)/1000/60;
    
    calculations;
    [InterceptFactor,PowerReceiver, PowerTrough, receiver.effectiveLength] = OpticalModelLinear(simulation,trough,receiver,sun,atmosphere);
    [collectorCycle.outletTemperature T]= ReceiverTemperatureLinear(receiver, 0, collectorCycle, atmosphere,simulation);
    
    predictionOutletTemp(i) = collectorCycle.outletTemperature;
    TempFall  =   collectorCycle.inletTemperature - collectorCycle.outletTemperature;
    
    
    massflowRate = collectorCycle.flowRate*materialProperty(collectorCycle.fluid.densityTable,collectorCycle.inletTemperature);
    
    predHeatLoss(i) = 0;
    dt = (collectorCycle.inletTemperature+collectorCycle.outletTemperature)/10000;
    lost(i) = TempFall*massflowRate*materialProperty(collectorCycle.fluid.heatCapacityTable,collectorCycle.outletTemperature);
end


figure;
plot(outletTemp-kelvin2celcius(predictionOutletTemp), 'ko')

figure
plot(outletTemp, 'ko')
hold on
plot(kelvin2celcius(predictionOutletTemp), 'rx')
xlabel('Days')
ylabel('Outlet Temperature (C)')
legend('SEGS data', 'Model prediction')

figure
plot(inletTemp-ambTemp,heatLoss,'ko')
hold on
plot(inletTemp-ambTemp,predHeatLoss/trough.aperature,'r-')
plot(inletTemp-ambTemp,lost/trough.aperature,'bo')
xlabel('Inlet Temperature (Degrees C above Ambient)')
ylabel('Heat loss (W/m^2)')
legend('SEGS data', 'Model prediction')
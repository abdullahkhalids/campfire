clear all;
clc

% testType = 'efficiency';
testType = 'thermal';

material = 'chrome';
% material = 'cermet';

% gas = 'air';
gas = 'vacuum';

ExperimentalData;
%get user simulation constants
constants;
receiver.gas = vacuum;

for i=1:n

    collectorCycle.inletTemperature = celcius2kelvin(inletTemp(i));
    atmosphere.temperature = celcius2kelvin(ambTemp(i));
    collectorCycle.flowRate = flowRate(i)/(60*1000);
    atmosphere.windSpeed = windSpeed(i);
    
    %rest of simulation parameters
    calculations;
    
    %reset random number stream
    defaultStream = RandStream.getDefaultStream;
    load('randstream');
    defaultStream.State = savedState;
    
    if strcmp(testType,'efficiency')
        
        sun.irradiance = insolation(i);
        %optical model
        [InterceptFactor,PowerReceiver, PowerTrough, receiver.effectiveLength] = OpticalModelLinear(simulation,trough,receiver,sun,atmosphere);
        
        %Output temperature from receiver
        [predictionOutletTemp(i) T] = ReceiverTemperatureLinear(receiver, PowerReceiver, collectorCycle, atmosphere,simulation);
        TempRise  =   predictionOutletTemp(i) - collectorCycle.inletTemperature;
        
        AvgTemp = (predictionOutletTemp(i) + collectorCycle.inletTemperature)/2;
        heatGain(i) = 0;
        dt = (collectorCycle.inletTemperature+predictionOutletTemp(i))/2000;
        %flow rate
        massflowRate = collectorCycle.flowRate*materialProperty(collectorCycle.fluid.densityTable,collectorCycle.inletTemperature);
        for j= collectorCycle.inletTemperature:dt:predictionOutletTemp(i)
            heatCap = materialProperty(collectorCycle.fluid.heatCapacityTable,j);
            heatGain(i) = heatGain(i) + massflowRate*heatCap*dt;
        end
        
        predEfficiency(i) =   100*heatGain(i)/(sun.irradiance*trough.aperature);
        
    elseif strcmp(testType,'thermal')
        
        receiver.effectiveLength = trough.length;
        [predictionOutletTemp(i) T] = ReceiverTemperatureLinear(receiver, 0, collectorCycle, atmosphere,simulation);
        
        massflowRate = collectorCycle.flowRate*materialProperty(collectorCycle.fluid.densityTable,collectorCycle.inletTemperature);
        TempFall = collectorCycle.inletTemperature - predictionOutletTemp(i);
        heatCap = materialProperty(collectorCycle.fluid.heatCapacityTable,predictionOutletTemp(i));
        predHeatLoss(i) = massflowRate*TempFall*heatCap;
    end
end

% figure;
% plot(inletTemp-ambTemp,kelvin2celcius(predictionOutletTemp)-outletTemp,'go');

if strcmp(testType,'efficiency')
figure;
plot((kelvin2celcius(predictionOutletTemp)+inletTemp)/2-ambTemp,efficiency,'ko');
hold on;
% plot((kelvin2celcius(predictionOutletTemp)+inletTemp)/2-ambTemp,predEfficiency,'x');
xlabel('Average temperature above ambient')
ylabel('Total Efficiency %')
legend('SEGS data Vacuum', 'Model prediction Vacuum','SEGS data Air', 'Model prediction Air')

elseif strcmp(testType,'thermal')
% figure
plot(inletTemp-ambTemp,heatLoss,'ko')
hold on
plot(inletTemp-ambTemp,predHeatLoss/trough.aperature,'bx')
xlabel('Inlet Temperature (Degrees C above Ambient)')
ylabel('Heat loss (W/m^2)')
legend('SEGS data', 'Model prediction')

end
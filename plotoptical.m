%plotter optical efficiency
close all
xis = (inletTemperature+ resultOutletTemp)/2 - ambientTemperature;
yis = measuredefficiency;
preyis = efficiency;

yis2 = resultOutletTemp - inletTemperature;
preyis2 = kelvin2celcius(predictionOutletTemp) - inletTemperature;
yis3 = resultOutletTemp;
preyis3 = kelvin2celcius(predictionOutletTemp);

figure
%for vacum
plot(xis,yis,'ro')
hold on
% plot(xis,preyis,'rx')
plot(x,y2,'r-')
%for air
plot((inletTemperature+ resultOutletTemp)/2 - ambientTemperature,measuredefficiency,'go')
hold on
% plot((inletTemperature+ resultOutletTemp)/2 - ambientTemperature,efficiency,'gx')plot(x,y,'g-')
plot(x,y,'g-')
ylabel('Efficiency %')
xlabel('Average Fluid Temperature Above Ambient (Degrees C)')
legend('SEGS results w/ vacuum','Model prediction w/ vacuum','SEGS results w/o vacuum','Model prediction w/o vacuum')


% figure
% plot(xis,yis2,'o'); hold on
% plot(xis,preyis2,'x')
% ylabel('Delta T')
% xlabel('average temperature above ambient')

figure
plot(xis,yis3,'o'); hold on
plot(xis,preyis3,'x')
ylabel('Outlet Temp')
xlabel('average temperature above ambient')


% 
% deltaT = resultOutletTemp - inletTemperature;
% mflow = collectorCycle.flowRate*materialProperty(collectorCycle.fluid.densityTable,collectorCycle.outletTemperature);
% preGain = mflow*materialProperty(collectorCycle.fluid.heatCapacityTable,collectorCycle.inletTemperature)*deltaT;
% eff = preGain/sun.irradiance;
%plotter heat loss
%with vacum
% x1 = inletTemp-atmTemp;
% prey1 = avgHeatloss/trough.aperature;
% y1 = heatLoss;

%without vacum
figure
plot(inletTemp-atmTemp,heatLoss,'ko') 
hold on
plot(inletTemp-atmTemp,avgHeatloss/trough.aperature,'r-')
plot(x1,y1,'o')
plot(x1,prey1,'g-')
xlabel('Inlet Temperature (Degrees C above Ambient)')
ylabel('Heat loss (W/m^2)')
legend('SEGS data with vacum', 'Model prediction with vacum','SEGS data without vacum', 'Model prediction without vacum')

%plotter efficiency
%with air
x1 = inletTemperature-ambientTemperature;
prez1 = kelvin2celcius(predictionOutletTemp);
z1 = resultOutletTemp;

figure;

plot(kelvin2celcius(predictionOutletTemp),'ko');
hold on;
plot(resultOutletTemp,'ro');
plot(resultOutletTemp,'ko');
plot(resultOutletTemp,'ro');

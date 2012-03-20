function T = ReceiverTemperature(receiver, flux, collectorCycle, atmosphere)
%Computes the temperature of the fluid going out of the receiver


frac = 0.9;
C = 2*pi*receiver.radius; %circumference of surface
A = pi*receiver.radius^2; %area of crosssection
D = 2*receiver.radius;
Nu = 4.36; %for pipes
h = Nu*collectorCycle.fluid.heatConductivity/D;

%Flux per unit area of the pipe
fluxIntensity = flux/(receiver.troughLength*C);

%heat absorbed by fluid
qFluidAbsorbed = frac*flux;

%Guess of the temperature output of the fluid
TFluidOut = TFluidIn + qFluidAbsorbed/(collectorCycle.flowRate*collectorCycle.fluid.heatCapacity);

%average temperature of the fluid
Tavg = (TFluidOut + TFluidIn)/2;

%
TsurfaceIn = fluxIntensity/h + TFluidIn;
TsurfaceOut = fluxIntensity/h + TFluidOut;

TsurfaceMean = (TsurfaceIn + TsurfaceOut)/2;

[rho Cp k alpha mu vis Pr Beta] = nearestSelector(temp,material)

Ra = (g*(Tms-Tamb)*Pr*D1^3)/(TsurfaceMean*vis^2);


Qrad = epsilon1*sigma*areaCopperPipe*(Tms^4-Tamb^4);
 Qconv = h*areaCopperPipe*(Tms-Tamb);


 Nu = (0.6 + 0.387*Ra^(1/6)/(1+(0.559/Pr)^(9/16))^(8/27))^2;
 h = k*Nu/D1;
epsilon2 = 0.92; sigma = 5.670810^-8;



end


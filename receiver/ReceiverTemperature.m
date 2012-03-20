function [Tout,T] = ReceiverTemperature(receiver, flux, collectorCycle, atmosphere)
%Computes temperature of the output

segmentLength = 0.1;
m = ceil(receiver.troughLength/segmentLength);

fluxLengthIntensity = flux/receiver.length;
Tin = collectorCycle.inletTemperature;
T = zeros(m,5);
Tguess = atmosphere.temperature*ones(1,5);


for i = 1:m+1
    
    %Given the input temp and a guess, compute the temperatures of this
    %segment    
    options=optimset('Display','off');
    h = @(T) heatBalanceEquations(T,Tin,fluxLengthIntensity,receiver,collectorCycle,atmosphere,segmentLength);
    T(i,:) = fsolve(h,Tguess,options);
    
    %Compute input temperature of next segment
    Tin = 2*T(i,1) - Tin;
    
    %Take current temperatures as guesses for the next segment
    Tguess = T(i,:);  
end

%At the end the output temperature is just given by the output of the last
%segment
Tout = Tin;

end

%%
function F = heatBalanceEquations(T,Tin,fluxLengthIntensity,receiver,collectorCycle,atmosphere,segmentLength)

%1:fluid
%2:absorber inner
%3:absorber outer
%4:glass inner
%5:glass outer
%6:air
%7:sky

g = atmosphere.gravity;
sigma = 5.67e-8;
D2 = receiver.innerDiameterAbsorber;
D3 = receiver.outerDiameterAbsorber;
D4 = receiver.innerDiameterGlassSleeve;
D5 = receiver.outerDiameterGlassSleeve;


%e2 = 0.88;
e3 = 0.88;
e4 = 0.86;
e5 = 0.86;

absorptanceGlass = 0.15;
absorptanceAbsorber = 0.9;

q5sun = fluxLengthIntensity*absorptanceGlass;
q3sun = fluxLengthIntensity*(1-absorptanceGlass)*absorptanceAbsorber;


%Convection from absorber to the fluid
Nu1 = 4.36;
%Nu1 changes when inner tube
k1 = materialProperty(collectorCycle.fluid.thermalConductivityTable,T(1));
h1 = Nu1*k1/D2;

q12conv = h1*D2*pi*(T(2)-T(1));

%Conduction in absorber from outer to inner
k23 = receiver.absorber.thermalConductivity;
q23cond = 2*pi*k23*(T(3) - T(2))/log(D3/D2);


%Convection from aborber outer to glass inner
T34 = average(T(3),T(4));
beta34 = 1/T34;
alpha34 = materialProperty(receiver.gas.thermalDiffusivityTable,T34);
viscosity34 = materialProperty(receiver.gas.viscosityTable,T34);
Pr34 = materialProperty(receiver.gas.prandtlNumberTable,T34);
k34 = materialProperty(receiver.gas.thermalConductivityTable,T34);

RaD3 = g*(T(3) - T(4))*D3^3*beta34/(alpha34*viscosity34);
q43conv = 2.425*k34*(T(3) - T(4))*(Pr34*RaD3/(0.861 + Pr34))^(1/4)/(1 + (D3/D4)^(3/5))^(5/4);


%Radiation from absorber outer to glass inner
q43rad = sigma*pi*D3*(T(3)^4 - T(4)^4)/(1/e3 + (1 - e4)*D3/(e4*D4));


%Conduction within glass from inner to outer
k45 = 1.1; %pyrex
q54cond = 2*pi*k45*(T(4) - T(5))/log(D5/D4);


%Convection from glass to air

vis6 = materialProperty(atmosphere.viscosityTable,atmosphere.temperature);
Pr5 = materialProperty(atmosphere.prandtlNumberTable,T(5));
Pr6 = materialProperty(atmosphere.prandtlNumberTable,atmosphere.temperature);
v = atmosphere.windSpeed;
Re = v*D5/vis6;
if Re<=40
    C = 0.75;
    m = 0.4;
elseif Re<=1000
    C = 0.51;
    m = 0.5;
elseif Re<=200e3
    C = 0.26;
    m = 0.6;
else
    C = 0.076;
    m = 0.7;
end

if Pr5<=10
    n = 0.37;
else
    n = 0.36;
end

Nu56Wind = C*Re^m*Pr6^n*(Pr6/Pr5)^(1/4);

T56 = average(T(5),atmosphere.temperature);
k56 = materialProperty(atmosphere.thermalConductivityTable,T56);
h56 = Nu56Wind*k56/D5;

q65conv = h56*pi*D5*(T(5) - atmosphere.temperature);

%Radiation from glass to sky
Tsky = atmosphere.temperature - 8;
q75rad = sigma*D5*pi*e5*(T(5)^4 - Tsky^4);

%% Equations
F(1) = q12conv - q23cond;
F(2) = q3sun - q23cond - q43conv - q43rad;
F(3) = q43rad + q43conv - q54cond;
F(4) = q5sun + q54cond - q75rad - q65conv;
F(5) = (q3sun - q43rad - q43conv)*segmentLength/(collectorCycle.flowRate*collectorCycle.fluid.heatCapacity) + 2*(Tin - T(1));

F = real(F);

end
%%
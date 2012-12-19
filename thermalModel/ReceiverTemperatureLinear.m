function [Tout,T] = ReceiverTemperatureLinear(receiver, flux, collectorCycle, atmosphere,simulation)
%Computes temperature of the output

segmentLength = simulation.receiverSegmentLength;
m = ceil(receiver.effectiveLength/segmentLength);

fluxLengthIntensity = flux/receiver.effectiveLength;
Tin = collectorCycle.inletTemperature;
T = zeros(m,5);
Tguess = collectorCycle.inletTemperature*ones(1,5);
options=optimset('Display','Off','TolFun',1e-4,'TolX',1e-4);

% mass flow rate remains constant because of pump
collectorCycle.massFlowRate = collectorCycle.flowRate*materialProperty(collectorCycle.fluid.densityTable,collectorCycle.inletTemperature);
for i = 1:m+1
    
    %Given the input temp and a guess, compute the temperatures of this
    %segment
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
D2 = receiver.absorber.innerDiameter;
D3 = receiver.absorber.outerDiameter;
D4 = receiver.sleeve.innerDiameter;
D5 = receiver.sleeve.outerDiameter;
Da = receiver.annulus.diameter;

% e2 = receiver.absorber.emissivity;
e3 = receiver.absorber.emissivity;
e4 = receiver.sleeve.emissivity;
e5 = receiver.sleeve.emissivity;

%radiation from sky to glass and to absorber
q5sun = fluxLengthIntensity*receiver.sleeve.absorptance;
q3sun = fluxLengthIntensity*(1 - receiver.sleeve.absorptance)*receiver.absorber.absorptance;

%Convection from absorber to the fluid

viscosity = materialProperty(collectorCycle.fluid.viscosityTable,T(1));
fluidDensity = materialProperty(collectorCycle.fluid.densityTable,T(1));

massflowRate = collectorCycle.massFlowRate;
DH = D2 - Da;

speed = massflowRate/(fluidDensity*collectorCycle.area);
ReD2 = speed*fluidDensity*DH/viscosity;

if ReD2>2300
    f2 = (1.82*log10(ReD2)-1.64)^-2; %frictional factor for the inner surface of absorber
    
    Cp1 = materialProperty(collectorCycle.fluid.heatCapacityTable,T(1));
    k1 = materialProperty(collectorCycle.fluid.heatConductivityTable,T(1));
    Pr1 = Cp1*viscosity/k1;
    
    Cp2 = materialProperty(collectorCycle.fluid.heatCapacityTable,T(2));
    k2 = materialProperty(collectorCycle.fluid.heatConductivityTable,T(2));
    Pr2 = Cp2*viscosity/k2;
    
    Nu1 = ((f2/8)*(ReD2 - 1000)*Pr1)/(1 + 12.7*sqrt(f2/8)*(Pr1^(2/3)-1))*(Pr1/Pr2)^0.11;
    h1 = Nu1*k1/DH;
else
    annulusRatio = Da/receiver.absorber.innerDiameter;
    Nu1 = interp1([0 0.05 0.1 0.2 0.4 0.6 0.8 1], [4.364 4.792 4.834 4.833 4.979 5.099 5.24 5.385],annulusRatio);
    k1 = materialProperty(collectorCycle.fluid.heatConductivityTable,T(1));
    h1 = Nu1*k1/D2;
end

q12conv = h1*D2*pi*(T(2)-T(1));

%Conduction in absorber from outer to inner
k23 = receiver.absorber.thermalConductivity;
q23cond = 2*pi*k23*(T(3) - T(2))/log(D3/D2);


%Convection from aborber outer to glass inner
if strcmp(receiver.gas.material,'air')
    %for air in annulus
    T34 = average(T(3),T(4));
    beta34 = 1/T34;
    alpha34 = materialProperty(receiver.gas.thermalDiffusivityTable,T34);
    viscosity34 = materialProperty(receiver.gas.viscosityTable,T34);
    Pr34 = materialProperty(receiver.gas.prandtlNumberTable,T34);
    k34 = materialProperty(receiver.gas.thermalConductivityTable,T34);
    RaD3 = g*(T(3) - T(4))*D3^3*beta34/(alpha34*viscosity34);
    q43conv = 2.425*k34*(T(3) - T(4))*(Pr34*RaD3/(0.861 + Pr34))^(1/4)/(1 + (D3/D4)^(3/5))^(5/4);
elseif strcmp(receiver.gas.material,'vacuum')
    %for vacum in annulus
    h34 = 0.0001115; %for air for pressures <0.0001 torr\
    q43conv = pi*D3*h34*(T(3)-T(4));
elseif strcmp(receiver.gas.material,'hydrogen')
    h34 = 0.0003551; %for hyrdogen for pressures <0.0001 torr
    q43conv = pi*D3*h34*(T(3)-T(4));
end

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

%heat loss from bracket
Tbase = T(3)-10;
Teffective = (Tbase + atmosphere.temperature)/3;
vis_bracket = materialProperty(atmosphere.viscosityTable,Teffective);
Pr5_bracket = materialProperty(atmosphere.prandtlNumberTable,Teffective);
Pr6_bracket = materialProperty(atmosphere.prandtlNumberTable,atmosphere.temperature);
D_bracket = 0.0508; %2inches
Re = v*D_bracket/vis_bracket;
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

if Pr5_bracket<=10
    n = 0.37;
else
    n = 0.36;
end

Nu_bracket= C*Re^m*Pr6_bracket^n*(Pr6_bracket/Pr5_bracket)^(1/4);
Peri_b =0.2032; A_cs = 1.613e-4; kb = 48e-3; 

h_bracket = Nu_bracket*kb/D_bracket;
qbracket = receiver.nBrackets*sqrt(h_bracket*Peri_b*kb*A_cs)*(Tbase - atmosphere.temperature)/segmentLength;

%% Equations
F(1) = q12conv - q23cond;
F(2) = q3sun - q23cond - q43conv - q43rad;
F(3) = q43rad + q43conv - q54cond;
F(4) = q5sun + q54cond - q75rad - q65conv;
F(5) = (q12conv*segmentLength - qbracket)/(massflowRate*materialProperty(collectorCycle.fluid.heatCapacityTable,T(1))) + 2*(Tin - T(1));

F = real(F);


end

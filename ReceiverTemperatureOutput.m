function [T, MassFlowRate] = ReceiverTemperatureOutput(receiver, flux, receiverFluid, atmosphere)


sigma = 5.7*10^-8;
dt=0.01;
fluxIntensity = flux/receiver.troughLength;

C = 2*pi*receiver.radius; %circumference of surface
A = pi*receiver.radius^2; %area of crosssection
D = 2*receiver.radius;

T = atmosphere.temperature;
for  x = 0:dt:receiver.troughLength/receiverFluid.speed
    
    %air film temperature
    Ts = (T + atmosphere.temperature)/2;
    [k mu viscosity Pr] = nearestSelector(Ts);
    
    %Reynold Number
    Re = atmosphere.windSpeed*D/viscosity;
        
    %Nusselt Number for cylinder by Churchill-Bernstein
    Nu = 0.3 + (0.62*sqrt(Re)*Pr^(1/3))/(1 + (0.4/Pr)^(2/3))^(1/4)*(1 + (Re/282000)^(5/8))^(4/5);
    
    %Convection Coefficient
    h = k*Nu/D;
    
    convectiveLoss = h*C*(T - atmosphere.temperature);
    radiativeLoss = receiver.emissivity*sigma*C*(T^4 - atmosphere.temperature^4);
    
    dT = ((fluxIntensity - convectiveLoss - radiativeLoss)/(receiverFluid.density*A*receiverFluid.heatCapacity))*dt;
    
    %Add to temperature
    T = T + dT;

end

%Convert to celcius
T = T - 273;

MassFlowRate = pi*receiver.radius^2*receiverFluid.speed*1000;


end

%Nearest selector function
function [k1 mu1 vis1 Pr1] = nearestSelector(temp)
%

%with forced convection and radiation losses
t = [300 310 320 330 340 350 400 450 500 550 600 700 800];
k = [261 268 275 283 290 297 331 363 395 426 456 513 569]*10^-4;
mu =[185 190 194 199 203 208 229 249 268 286 303 335 364]*10^-7;
vis=[187 167 177 186 196 206 260 318 380 445 515 664 825]*10^-7;
Pr =[712 711 710 708 707 706 703 700 699 698 698 702 704]*10^-3;

for i=1:length(t)
    if temp<(t(i) + t(i+1))/2
        k1 = k(i);
        mu1= mu(i);
        vis1=vis(i);
        Pr1=Pr(i);
        break
    end
end
end
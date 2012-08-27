function [InterceptFactor,PowerReceiver, PowerReflector] = Flux3DCircular(intersectionIndexes,isIntersection,intensitiesReflection,dish,receiver,sun,simulation)
%FLUX3DCIRCULAR Given the intersection points on a receiver of rays and
%their intensities, computes the 3D total flux etc.

% Computes power on receiver by ratios
stripArea = 2*dish.radius*simulation.grainLength;
dishArea = pi*(dish.radius)^2;

PowerReceiver = dishArea/stripArea*sum(intensitiesReflection);

%Compute the total power that the trough received
PowerReflector = pi*(dish.radius)^2*sun.irradiance; %*cosd(sun.widthAngle - rad2deg(dish.rotAngle));

%Compute efficiency
InterceptFactor = PowerReceiver/PowerReflector;


end


function crosssection = DishCrosssection(dish,sun,simulation)
%DISHCROSSSECTION Computes the crossection of the dish that reduces the
%dish problem to an almost linear problem. 


crosssection.trackingError = acosd(dot(dish.axisVector,sun.vector));
crosssection.focalLength = 0.2;
crosssection.focusCoordinates = [0 0];
crosssection.width = 2*dish.radius;
crosssection.refractiveIndex = dish.refractiveIndex;
crosssection.surfaceStdDev = 10e-3; %rad
crosssection.specularity = 0.85;
crosssection.specularityStdDev = 5e-3;
crosssection.halfQuantization = 1;
crosssection.rotAngle = deg2rad(sun.widthAngle) + crosssection.trackingError;
crosssection.coordinates = TroughCoordinates(crosssection, simulation);
crosssection.gradients = TroughGradient(crosssection.coordinates,crosssection.surfaceStdDev);
crosssection.coordinates = crosssection.coordinates(:,2:end-1); %throw away the coordinates no longer needed
crosssection.fullQuantization = 2*crosssection.halfQuantization + 1;
if crosssection.halfQuantization == 0; crosssection.specularity = 1; end;


end



dish = struct();
dish.focalLength = 0.2;
dish.focusCoordinates = [0 0];
% dish.orientationAngle = 0;
dish.radius = 0.5;
% dish.length = 10;
dish.refractiveIndex = aluminium.refractiveIndex;
dish.surfaceStdDev = 10e-3; %rad
dish.specularity = 0.85;
dish.specularityStdDev = 5e-3;
dish.halfQuantization = 1;
% dish.trackingError = deg2rad(0);

% have to define conventions for these angles
dish.yaw = 0; % x-y plane
dish.pitch = 0; % z-y plane
dish.roll = 0; % not needed

dish.refractiveIndex = aluminium.refractiveIndex;




sun.vector = SunVector(sun);
% dish.axisVector = DishAxisVector(dish);
dish.axisVector = sun.vector;

dish.crosssection.trackingError = acosd(dot(dish.axisVector,sun.vector));
dish.crosssection.focalLength = 0.2;
dish.crosssection.focusCoordinates = [0 0];
dish.crosssection.width = 2*dish.radius;
dish.crosssection.refractiveIndex = aluminium.refractiveIndex;
dish.crosssection.surfaceStdDev = 10e-3; %rad
dish.crosssection.specularity = 0.85;
dish.crosssection.specularityStdDev = 5e-3;
dish.crosssection.halfQuantization = 1;





dish.crosssection.rotAngle = deg2rad(sun.widthAngle) + dish.crosssection.trackingError;
% crosssection.height = TroughHeight(crosssection.focalLength,crosssection.width);
% crosssection.rimAngle = TroughRimAngle(crosssection.focalLength, crosssection.width);
dish.crosssection.coordinates = TroughCoordinates(dish.crosssection, simulation);
dish.crosssection.gradients = TroughGradient(dish.crosssection.coordinates,dish.crosssection.surfaceStdDev);
dish.crosssection.coordinates = dish.crosssection.coordinates(:,2:end-1); %throw away the coordinates no longer needed
dish.crosssection.fullQuantization = 2*dish.crosssection.halfQuantization + 1;
if dish.crosssection.halfQuantization == 0; dish.crosssection.specularity = 1; end;

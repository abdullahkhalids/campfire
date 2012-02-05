function pointsIntersections = LineCircleIntersection(coordinates,gradients,radius,center)
%Computes the first interesection between a set of lines and a circle

%compute the determinent of the quadratic equation of intersection.
c = coordinates(2,:) - gradients.*coordinates(1,:);
det = (gradients.*(c - center(2)) - center(1)).^2 - (1 + gradients.^2).*((center(2) - c).^2 + (center(1)^2 - radius^2));

%check which lines intersect
isIntersection = det >=0;

%compute both points of intersection 
x1 = isIntersection.*(-(gradients.*(c-center(2)) - center(1)) + sqrt(det)./(1 + gradients.^2));
x2 = isIntersection.*(-(gradients.*(c-center(2)) - center(1)) - sqrt(det)./(1 + gradients.^2));
y1 = gradients.*x1 + c;
y2 = gradients.*x2 + c;

%compute the squared distance between trough point and receiver point
dis1 = SquareDistance([x1; y1],coordinates);
dis2 = SquareDistance([x2; y2],coordinates);

%figure out the closer one.
pointsIntersections = [x1 ; y1];
shouldSwitch = dis2 < dis1;
pointsIntersections(1,shouldSwitch) = x2(shouldSwitch);
pointsIntersections(2,shouldSwitch) = y2(shouldSwitch);

end

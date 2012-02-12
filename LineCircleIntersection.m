function pointsIntersections = LineCircleIntersection(coordinates,gradients,radius,center)
%Computes the first interesection between a set of lines and a circle

%compute the determinent of the quadratic equation of intersection.
c = coordinates(2,:) - gradients.*coordinates(1,:);
det = (gradients.*(c - center(2)) - center(1)).^2 - (1 + gradients.^2).*((center(2) - c).^2 + (center(1)^2 - radius^2));

%check which lines intersect
isIntersection = det >=0;

%compute both points of intersection 
intersections1 = isIntersection.*(-(gradients.*(c-center(2)) - center(1)) + sqrt(det)./(1 + gradients.^2));
intersections2 = isIntersection.*(-(gradients.*(c-center(2)) - center(1)) - sqrt(det)./(1 + gradients.^2));
intersections1(2,:) = gradients.*intersections1 + c;
intersections2(2,:) = gradients.*intersections2 + c;

%compute the squared distance between trough point and receiver point
dis1 = SquareDistance(intersections1,coordinates);
dis2 = SquareDistance(intersections2,coordinates);

%figure out the closer one.
pointsIntersections = intersections1;
shouldSwitch = dis2 < dis1;
shouldSwitch = repmat(shouldSwitch,2,1);
pointsIntersections(shouldSwitch) = intersections2(shouldSwitch);

end

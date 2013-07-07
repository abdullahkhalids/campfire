function pointsIntersection = LineCircleIntersection(trough,gradientsReflected,receiver)
%Computes the first interesection between a set of lines and a circle


m = 7;
coordinates = cell2mat(arrayfun(@(x)repmat(x,1,m),trough.coordinates,'UniformOutput', false));

%compute the determinent of the quadratic equation of intersection.
c = coordinates(2,:) - gradientsReflected.*coordinates(1,:);
det = 4*gradientsReflected.^2.*c.^2 - 4*(1 + gradientsReflected.^2).*(c.^2 - receiver.radius^2);

%check which lines intersect
isIntersection = det >=0;

%compute both points of intersection 
x1 = isIntersection.*(-2*gradientsReflected.*c + sqrt(det))./(2*(1 + gradientsReflected.^2));
x2 = isIntersection.*(-2*gradientsReflected.*c - sqrt(det))./(2*(1 + gradientsReflected.^2));
y1 = gradientsReflected.*x1 + c;
y2 = gradientsReflected.*x2 + c;

%compute the squared distance between trough point and receiver point
dis1 = SquareDistance([x1; y1],coordinates);
dis2 = SquareDistance([x2; y2],coordinates);

%figure out the closer one.
pointsIntersection = [x1 ; y1];
shouldSwitch = dis2 < dis1;
pointsIntersection(1,shouldSwitch) = x2(shouldSwitch);
pointsIntersection(2,shouldSwitch) = y2(shouldSwitch);

end

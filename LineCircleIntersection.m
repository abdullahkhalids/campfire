function [x,y] = LineCircleIntersection(trough,gradientReflected,receiver)
%Computes the first interesection between a set of lines and a circle

%compute the determinent of the quadratic equation of intersection.
c = trough.coordinates(2,:)' - gradientReflected'.*trough.coordinates(1,:)';
det = 4*gradientReflected'.^2.*c.^2 - 4*(1 + gradientReflected'.^2).*(c.^2 - receiver.radius^2);
%check which lines intersect
isIntersection = det >=0;
%compute both points of intersection 
x1 = isIntersection.*(-2*gradientReflected'.*c + sqrt(det))./(2*(1 + gradientReflected'.^2));
x2 = isIntersection.*(-2*gradientReflected'.*c - sqrt(det))./(2*(1 + gradientReflected'.^2));
y1 = gradientReflected'.*x1 + c;
y2 = gradientReflected'.*x2 + c;

%compute the squared distance between trough point and receiver point
dis1 = SquareDistance([x1 y1],trough.coordinates');
dis2 = SquareDistance([x2 y2],trough.coordinates');

%figure out the closer one.
x = x1;
y = y1;
shouldSwitch = dis2 < dis1;
x(shouldSwitch) = x2(shouldSwitch);
y(shouldSwitch) = y2(shouldSwitch);

end
%computes the squares distances pairwise between two n x 2 matrices
function dis = SquareDistance(points1, points2)
    dis = sum((points1 - points2).^2, 2);
end
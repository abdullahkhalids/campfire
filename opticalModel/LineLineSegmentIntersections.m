function [pointsIntersections,isIntersection] = LineLineSegmentIntersections(coordinates,gradients,Length,center)
%LINELINESEGMENTINTERSECTIONS Computes the intersections between a line
%segment and a set of lines

% the x coordinate of the intersection level
xReceiverLevel = (center(2) - coordinates(2,:) + gradients.*coordinates(1,:))./gradients;

% is there an actual intersection
isIntersection1 = xReceiverLevel <= (center(1) + Length/2);
isIntersection2 = xReceiverLevel >= (center(1) - Length/2);

isIntersection = isIntersection1 & isIntersection2;

% the y coordinates
y = gradients.*xReceiverLevel + coordinates(2,:) - gradients.*coordinates(1,:);

pointsIntersections = [xReceiverLevel; y];
pointsIntersections = pointsIntersections.*repmat(isIntersection,2,1);



end


function [indexes,isIntersection] = ReceiverIntersections(gradientsReflected,trough,receiver,sun)
%Computes the indexes of the points on the receiver where the rays from the
%trough are incident

%expand out coordinates to account for 
coordinates = expand(trough.coordinates,@(x)repmat(x,1,sun.fullQuantization*trough.fullQuantization));

%Computes intersection with the receiver
[pointsIntersections,isIntersection] = LineCircleIntersection(coordinates,gradientsReflected,receiver.radius,receiver.position);

%compute the intersection coordinates using a nearest neighbour approach
l = length(pointsIntersections);
indexes = zeros(1,l);

for i=1:l
    if pointsIntersections(1,i) ~= 0 && pointsIntersections(2,i) ~= 0 && ~isnan(pointsIntersections(1,i)) && ~isnan(pointsIntersections(2,i)) && ~isinf(pointsIntersections(1,i)) && ~isinf(pointsIntersections(2,i))
        indexes(i) = NearestNeighbour(receiver.coordinates, pointsIntersections(:,i));
    end
end


end


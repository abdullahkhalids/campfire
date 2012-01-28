function indexes = IntersectionIndexes(coordinates,pointsIntersections)
%computes the intersection coordinates using a nearest neighbour approach

l = length(pointsIntersections);

indexes = zeros(1,l);

for i=1:l
    if pointsIntersections(1,i) ~= 0 && pointsIntersections(2,i) ~= 0
        indexes(i) = NearestNeighbour(coordinates, pointsIntersections(:,i));
    end
end

end


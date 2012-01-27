function nearestNeighbourIndex = NearestNeighbour(searchSpace, points)
%Computes the index of the nearest neighbour of the 'point' by looking at
%point in the searchSpace. Uses Euclidean Distance
%searchSpace: d x k where there are k vectors in a d dimensional space
%point: d x p are p d dimensional vectors

p = size(points,2);
r = size(searchSpace,2);
nearestNeighbourIndex = zeros(1,p);

for i = 1:p
    %compute square distances of each point 
    squareDistances = sum((searchSpace - repmat(points(:,i),1,r)).^2,1);
    
    %get the nearest neighbour index
    nearestNeighbourIndex(i) = find(squareDistances == min(squareDistances),1);
end


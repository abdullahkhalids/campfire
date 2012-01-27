function nearestNeighbourIndex = NearestNeighbour(searchSpace, points)
%Computes the index of the nearest neighbour of the 'point' by looking at
%point in the searchSpace. Uses Euclidean Distance
%searchSpace: k x d where there are k vectors in a d dimensional space
%point: p x d are p d dimensional vectors

s = size(points,1);

nearestNeighbourIndex = zeros(s);

for i = 1:s
    %compute square distances of each point 
    squareDistances = sum((searchSpace - repmat(points(i,:),size(searchSpace,1),1)).^2,2);
    
    %get the nearest neighbour index
    nearestNeighbourIndex(i) = find(squareDistances == min(squareDistances));
end


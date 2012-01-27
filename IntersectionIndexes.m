function indexes = IntersectionIndexes(coordinates,x,y)
%computes the intersection coordinates 

indexes = zeros(size(x));

for i=1:length(x)
    if x(i) ~= 0 && y(i) ~= 0
        indexes(i) = NearestNeighbour(coordinates', [x(i) y(i)]);
    end
end

end


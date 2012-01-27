function dis = SquareDistance(points1, points2)
%computes the squares distances pairwise between two 2 x n matrices
dis = sum((points1 - points2).^2, 1);
end


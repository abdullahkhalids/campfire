function B = normalize(A,dim)
%NORMALIZE Normalizes a set of vectors. dim can be 1 for column norm and 2
%for row norm

if nargin < 2
    dim = 1;
end

if dim == 1
    n = size(A,1);
    repDim = [n 1];
else
    n = size(A,2);
    repDim = [1 n];
end

B = A./repmat(sqrt(sum(A.^2,dim)),repDim);



end


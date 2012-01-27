function A = expandmat(mat,fun)
%Expand a matrix by applying operations to each column of the matrix

[r c] = size(mat);

cel = mat2cell(mat,r,ones(1,c));

A = cell2mat(cellfun(fun,cel,'UniformOutput', false));



end


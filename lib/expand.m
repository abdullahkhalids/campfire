function A = expand(mat,fun)
%Expands a matrix by expanding by applying an operation given by fun on
%each element

A = cell2mat(arrayfun(fun,mat,'UniformOutput', false));

end


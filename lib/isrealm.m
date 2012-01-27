function isInt = isrealm(A)
%

for i=1:size(A,1)
    for j=1:size(A,2)
        isInt(i,j) = isreal(A(i,j));
    end
end

end


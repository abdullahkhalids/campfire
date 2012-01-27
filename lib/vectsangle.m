function angle = vectsangle(v1,v2)
%Given two vectors, computes the angle between them using the dot product

angle = acos(norm(v1.*v2)/(norm(v1)*norm(v2)));

end


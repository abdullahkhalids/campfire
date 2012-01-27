function vectorsOut = RotateVectorsMat(vectorsIn,n,maxRotations)
%Given a set of vectors and angles, it rotates each one 2*n+1 times.

%expand out the vectors
v = expandmat(vectorsIn,@(x)repmat(x,1,2*n+1));

%expand out the angles
angles = expand(maxRotations,@(x)x*(-n:n));

%find rotation matrix
c = cos(angles);
s = sin(angles);
vectorsOut = sum([c;s].*v);
vectorsOut(2,:) = sum([-s;c].*v);



end


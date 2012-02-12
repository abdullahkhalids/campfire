function vectorsOut = RotateVectors(vectorsIn,n,maxRotation)
%Given a set of vectors, rotates each one about itself to get a new set of
%expanded vectors. The angles given.


%lengths
m = 2*n+1;
vn = size(vectorsIn,2);

%base rotation matrix
base = ExpandAngles(0,n,maxRotation);

%expand out the input vectors
v = expand(vectorsIn,@(x)repmat(x,1,m));

%get rotation matrices
c = repmat(cos(base),1,vn);
s = repmat(sin(base),1,vn);

vectorsOut = sum([c;s].*v);
vectorsOut(2,:) = sum([-s;c].*v);


end


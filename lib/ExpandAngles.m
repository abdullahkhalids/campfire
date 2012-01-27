function anglesOut = ExpandAngles(anglesIn,n,maxRotation)
%Given a set of angles, finds a new set of angles by adding and subtracting
%from them

%find the incremental angle
incAngle = maxRotation/n;

if n == 0
    incAngle = 0;
end

%set up a base matrix using which to expand the matrix
base = (-n:n)*incAngle;

%set up a function that expands a single angle
fun = @(x)x+base;

%expand out all angles
anglesOut = expand(anglesIn,fun);

end
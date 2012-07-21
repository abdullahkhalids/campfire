function s = TroughArcLength(trough)
%Computes arc length of trough

a = 1/(4*trough.focalLength);
x= trough.width/2;

b = 2*a*x;

s = 2*(b*sqrt(b^2+1)+ asinh(b))/(4*a);

end


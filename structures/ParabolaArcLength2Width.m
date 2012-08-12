function width = ParabolaArcLength2Width(arcLength,focalLength)
%Find the width given an arclength

options=optimset('Display','off');
h = @(x) ArcLengthFor(focalLength,x,arcLength);
width = fsolve(h,arcLength,options);

end

function ds = ArcLengthFor(focalLength,x,arcLength)


ds = arcLength - ParabolaArcLength(focalLength,x);

end

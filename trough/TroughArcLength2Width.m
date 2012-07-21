function width = TroughArcLength2Width(trough,arcLength)
%Find the width given an arclength
options=optimset('Display','off');
h = @(x) ArcLengthFor(trough,x,arcLength);
width = fsolve(h,arcLength,options);

end

function ds = ArcLengthFor(trough,x,arcLength)

trough.width = x;

ds = arcLength - TroughArcLength(trough);
end

function rimAngle = TroughRimAngle(focalLength, width)
%Computes the rim angle of the trough using focal length and full width

rimAngle = atan(8*(focalLength/width)/(1 - 16*(focalLength/width)^2));

end


function rimAngle = TroughRimAngle(focalLength, width)
%Computes the rim angle of the trough using focal length and full width

rimAngle = atan(8*(focalLength/width)/(16*(focalLength/width)^2 - 1));

end


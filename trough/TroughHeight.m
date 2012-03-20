function height = TroughHeight(focalLength, width)
%Computes the height of the trough using the focal length and full width
height = (16*focalLength^2 - width^2)/(16* focalLength);

end


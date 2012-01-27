function angles = grad2angle(gradients)
%Converts gradients to angles with the vertical axis

angles = atan(1./gradients);

end


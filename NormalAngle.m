function normalAngles = NormalAngle(gradients)
%Computes the the angles of the normal with the vertical axis given the
%gradient of a function

normalAngles = zeros(1,length(gradients));

normalAngles(2:end-1) = atan(-gradients(2:end-1));


end


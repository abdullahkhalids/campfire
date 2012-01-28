function normalGradients = GradientNormal(coordinates)
%Computes the gradient of the normal

normalGradients = - (coordinates(1,3:end) - coordinates(1,2:end-1))./(coordinates(2,3:end) - coordinates(2,2:end-1));

end


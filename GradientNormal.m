function normalGradients = GradientNormal(coordinates)
%Computes the gradient of the normal

normalGradients = zeros(1,length(coordinates));

for i=2:length(coordinates) - 1
    normalGradients(i) = -(coordinates(1,i+1) - coordinates(1,i-1))/(coordinates(2,i+1) - coordinates(2,i-1));
end

end


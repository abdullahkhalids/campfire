function gradients = Gradient(coordinates)
%Numerically computes the old school dy/dx derivative. The first row of
%coordinates is x, the second row y.

gradients = zeros(1,length(coordinates));

for i=2:length(coordinates) - 1
    gradients(i) = (coordinates(2,i+1) - coordinates(2,i-1))/(coordinates(1,i+1) - coordinates(1,i-1));
end



end


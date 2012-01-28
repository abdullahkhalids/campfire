function gradients = Gradient(coordinates)
%Numerically computes the old school dy/dx derivative. The first row of
%coordinates is x, the second row y.

gradients =  (coordinates(2,3:end) - coordinates(2,2:end-1))./(coordinates(1,3:end) - coordinates(1,2:end-1));

end


function gradients = Gradient(coordinates)
%Numerically computes the old school dy/dx derivative. The first row of
%coordinates is x, the second row y.

means = (coordinates(:,1:end-1) + coordinates(:,2:end))/2; 

g1 = (coordinates(2,3:end) - coordinates(2,1:end-2))./(coordinates(1,3:end) - coordinates(1,1:end-2));

g2 = (means(2,2:end) - means(2,1:end-1))./(coordinates(1,3:end) - coordinates(1,2:end-1));


gradients = (4*g2 - g1)/3;



end



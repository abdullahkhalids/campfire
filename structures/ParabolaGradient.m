function gradientsNew = ParabolaGradient(coord,sigma)
%Computes the surface of the trough

%first compute the gradient of the surface, along the width
gradientsWidth = Gradient(coord([1 2],:));

%then add some surface errors
gradientsNew = SurfaceErrors(gradientsWidth,sigma(1));

%the length function is just constant, so gradient is zero
gradientsLength = zeros(1,length(coord)-2);

%then add some surface errors
gradientsNew(2,:) = SurfaceErrors(gradientsLength,sigma(2));

end


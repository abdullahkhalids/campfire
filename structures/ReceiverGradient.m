function gradients = ReceiverGradient(coord,sigma)
%Computes the gradients of the receiver making sure it's a closed surface.
%There are errors on the edges

coord = [coord(:,end) coord coord(:,1)];

%first compute the gradient of the surface, along the width
gradients = Gradient(coord);

% [receiver.coordinates(:,end) receiver.coordinates receiver.coordinates(:,1)]

gradients = SurfaceErrors(gradients,sigma);

end


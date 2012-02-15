function gradients = SurfaceErrors(coord,sigma,simulation)
%Introduces surface deformities into a surface

%first compute the gradient of the surface
[gradients(:,:,1) gradients(:,:,2)] = gradient(coord(:,:,2),simulation.grainLength);

%compute gradients of the normal
gradientsNormal = -1./gradients(:,:,1);

%compute angles with the vertical of the normal gradients
anglesNormal = grad2angle(gradientsNormal);

%randomly perturbate angles
anglesNormal = anglesNormal + random('normal',0,sigma,size(anglesNormal));

%compute new normal gradients
gradientsNormalNew = angle2grad(anglesNormal);

%compute new gradients
gradientsNew = -1./gradientsNormalNew;

%Put them together
gradients(:,:,1) = gradientsNew;

end


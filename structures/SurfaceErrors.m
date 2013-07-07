function gradientsNew = SurfaceErrors(gradients,sigma)
%Introduces surface deformities into a surface

%compute gradients of the normal
gradientsNormal = -1./gradients;

%compute angles with the vertical of the normal gradients
anglesNormal = grad2angle(gradientsNormal);

%randomly perturbate angles
anglesNormal = anglesNormal + random('normal',0,sigma,1,length(anglesNormal));

%compute new normal gradients
gradientsNormalNew = angle2grad(anglesNormal);

%compute new gradients
gradientsNew = -1./gradientsNormalNew;

end


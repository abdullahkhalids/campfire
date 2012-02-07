function gradientsNew = SurfaceErrors(coord,sigma)
%Introduces surface deformities into a surface

%first compute the gradient of the surface
gradients = Gradient(coord);

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

%compute new coordinates using new gradients
% coordNew = coord(1,:);
% coordNew(2,:) = 0;
% coordNew(2,[1 end]) = coord(2,[1 end]);
% coordNew(2,2:end-1) = gradientsNew.*(coord(1,3:end) - coord(1,2:end-1)) + coord(2,2:end-1);

% coordNew = coord(1,:);
% coordNew(2,:) = 0;
% coordNew(2,[1 2 end]) = coord(2,[1 2 end]);
% coordNew(2,3:end-1) = gradientsNew(1:end-1).*(coord(1,3:end-1) - coord(1,1:end-3)) + coord(2,1:end-3);


end


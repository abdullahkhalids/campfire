function R = createRotation(theta,axes)
%Given an angle (deg) and an axes, creates an appropriate rotation matrix.

% treat char cases
if axes == 'x'
    axes = [1 0 0];
elseif axes == 'y'
    axes = [0 1 0];
elseif axes == 'z'
    axes = [0 0 1];
end

% make sure axis is a row vector and normalized
u = reshape(axes,1,3)/norm(axes);

% computes the angles just once
C = cos(theta);
S = sin(theta);

uCrossProductMatrix = [ 0 -u(3) u(2); u(3) 0 -u(1); -u(2) u(1) 0];
uSelfTensor = kron(u,u');

R = eye(3,3)*C + uCrossProductMatrix*S + (1 - C)*uSelfTensor;

end


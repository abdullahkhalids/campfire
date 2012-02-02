function gradientsReflected = SunConeReflections(anglesIncidence,trough,sun)
%Computes the gradients of the reflected rays of all the cone rays

incAngle = sun.halfAngle/sun.halfQuantization;
anglesCones = zeros(1,length(anglesIncidence)*sun.fullQuantization);
incMat = 1:length(anglesCones);
pos = mod(incMat-1,sun.fullQuantization) - sun.halfQuantization;
anglesSun = pos*incAngle + sun.positionAngle;
positionsSun = sin(anglesSun);
positionsSun(2,:) = cos(anglesSun);

gradients = cell2mat(arrayfun(@(x)repmat(x,1,sun.fullQuantization),trough.gradients,'UniformOutput', false));


%gradient of reflected ray
gradientsReflected = (positionsSun(2,:).*(1 + gradients.^2) - 2*(positionsSun(2,:) - positionsSun(1,:).*gradients))./(positionsSun(1,:).*(1 + gradients.^2) + 2*(positionsSun(2,:) - positionsSun(1,:).*gradients).*gradients);


end


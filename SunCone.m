function anglesCones = SunCone(anglesIncidence,sun)
%Given a list of incident angles of the center of the cones from the sun,
%this compute the output an output list of angles where the first 1:2*n+1
%angles correspond to the first cone and so on. i.e. each cone gets split
%into 2*n+1 rays

incAngle = sun.halfAngle/sun.halfQuantization;

anglesCones = zeros(1,length(anglesIncidence)*sun.fullQuantization);
anglesCones(sun.halfQuantization+1:sun.fullQuantization:end) = anglesIncidence;

incMat = 1:length(anglesCones);

pos = mod(incMat-1,sun.fullQuantization) - sun.halfQuantization;
anglesCones = pos*incAngle + anglesCones(incMat-pos);



end
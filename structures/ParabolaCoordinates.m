function coord3D = ParabolaCoordinates(trough, simulation)
%Computes the coordinates of all the points on the trough

%rotation matrix
rotMat = [cos(trough.rotAngle) sin(trough.rotAngle); ...
    -sin(trough.rotAngle) cos(trough.rotAngle)];

%Get all possible x
coord = -trough.width/2-simulation.grainLength:simulation.grainLength:trough.width/2+simulation.grainLength;

%Compute corresponding y for horizontal parabola
coord(2,:) = coord.^2/(4*trough.focalLength);

%move focus to origin
coord(2,:) = coord(2,:) - trough.focalLength;

%rotate the parabola around focus
rotCoord = rotMat*coord;

%move it
movRotCoord = rotCoord + repmat(trough.focusCoordinates',1,size(rotCoord,2));

%add a z coordinate
coord3D = [movRotCoord; zeros(1,length(movRotCoord))];


end


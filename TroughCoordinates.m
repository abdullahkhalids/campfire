function coordinates = TroughCoordinates(trough, simulation)
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

% plot(coord(1,:),coord(2,:));

%rotate the parabola around focus
rotCoord = rotMat*coord;

%move it
movRotCoord = rotCoord + repmat(trough.focusCoordinates',1,size(rotCoord,2));

%z coordinate
z = -trough.length/2-simulation.grainLength:simulation.grainLength:trough.length/2+simulation.grainLength;

x = repmat(movRotCoord(1,:),length(z),1);
y = repmat(movRotCoord(2,:),length(z),1);
z = repmat(z',1,size(coord,2));

coordinates(:,:,1) = x;
coordinates(:,:,2) = y;
coordinates(:,:,3) = z;




end


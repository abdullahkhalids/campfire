function movRotCoord = TroughCoordinates(trough, simulation)
%Computes the coordinates of all the points on the trough

%rotation matrix
rotMat = [cos(trough.rotAngle) sin(trough.rotAngle); ...
    -sin(trough.rotAngle) cos(trough.rotAngle)];

%Get all possible x
coord = -trough.width/2-simulation.grainSize:simulation.grainSize:trough.width/2+simulation.grainSize;

%Compute corresponding y for horizontal parabola
coord(2,:) = coord.^2/(4*trough.focalLength);

% figure;
% hold on;
% axis equal
% axis([-simulation.size(1) simulation.size(1)  -simulation.size(2) simulation.size(2)]);
% plot(coord(1,:),coord(2,:));

%move focus to origin
coord(2,:) = coord(2,:) - trough.focalLength;

% plot(coord(1,:),coord(2,:));


%rotate the parabola around focus
rotCoord = rotMat*coord;

% plot(rotCoord(1,:),rotCoord(2,:));


%move it
movRotCoord = rotCoord + repmat(trough.focusCoordinates',1,size(rotCoord,2));

% figure;
% hold on;
% axis equal
% axis([-simulation.size(1) simulation.size(1)  -simulation.size(2) simulation.size(2)]);
% plot(movRotCoord(1,:),movRotCoord(2,:));
%plot(trough.focusCoordinates(1),trough.focusCoordinates(2),'ko');


end


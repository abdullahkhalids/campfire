function receiverCoordinates = RecieverCoordinates(receiver, simulation)
%Computes all the coordinates of the receiver

%the receiver is a circle
x = -receiver.radius:simulation.grainLength:receiver.radius;
y = sqrt(receiver.radius^2 - x.^2);

%both halfs of the circle
coord = [x x; -y y];

%move to the correct position
receiverCoordinates = coord + repmat(receiver.position',1,size(coord,2));

%add random perturbations
receiverCoordinates = receiverCoordinates + 1e-3*rand(size(receiverCoordinates));

% plot(receiverCoordinates(1,:), receiverCoordinates(2,:));
% axis equal;

end


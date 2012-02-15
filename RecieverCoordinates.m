function coordinates = RecieverCoordinates(receiver, simulation)
%Computes all the coordinates of the receiver

% %the receiver is a circle
% x = -receiver.radius:simulation.grainLength:receiver.radius;
% y = sqrt(receiver.radius^2 - x.^2);
% 
% %both halfs of the circle
% coord = [x x; -y y];

x = 0:simulation.grainLength:receiver.radius;
y = sqrt(receiver.radius^2 - x.^2);
coord = [x fliplr(x(1:end-1)) -x(2:end) -fliplr(x(1:end-1)); y -fliplr(y(1:end-1)) -y(2:end) fliplr(y(1:end-1))];

%move to the correct position
receiverCoordinates = coord + repmat(receiver.position',1,size(coord,2));

%z coordinate
z = -receiver.length/2-simulation.grainLength:simulation.grainLength:receiver.length/2+simulation.grainLength;


x = repmat(receiverCoordinates(1,:),length(z),1);
y = repmat(receiverCoordinates(2,:),length(z),1);
z = repmat(z',1,size(receiverCoordinates,2));

coordinates(:,:,1) = x;
coordinates(:,:,2) = y;
coordinates(:,:,3) = z;

% plot(receiverCoordinates(1,:), receiverCoordinates(2,:));
% axis equal;

end


function isIntersection = ReceiverIntersectionsCylinder(vectorsReflection,parabola,receiver,sun)
%RECEIVERINTERSECTIONSCYLINDER Computes which of the reflected vectors are
%incident on the receiver. It does not compute the point of intersection
%for now
% the size of the coordinates expansion
m = 4*(4*sun.halfQuantization+1);

%expand the coordinates
coord = expand(parabola.coordinates,@(x)repmat(x,1,m));
% coord = repmat(parabola.coordinates,1,m);

%the condition for intersection is governed by geometry
isIntersection = ...
    (coord(1,:).*vectorsReflection(1,:) + coord(2,:).*vectorsReflection(2,:)).^2 ...
    - (vectorsReflection(1,:).^2+vectorsReflection(2,:).^2).*(coord(1,:).^2 + coord(2,:).^2-receiver.radius^2);

isIntersection = isIntersection>0;
end


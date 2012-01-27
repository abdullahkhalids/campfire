figure;
hold on;
axis equal
axis([-simulation.size(1) simulation.size(1)  -simulation.size(2) simulation.size(2)]);

%draw trough
plot(trough.coordinates(1,:),trough.coordinates(2,:));

%draw receiever
plot(receiver.coordinates(1,:), receiver.coordinates(2,:));

%draw the point for which to draw the ray
plot(trough.coordinates(1,p),trough.coordinates(2,p), 'ro');
x = -1:0.1:1;
%incident ray
y = 1/tan(sun.positionAngle)*x + (trough.coordinates(2,p) - 1/tan(sun.positionAngle)*trough.coordinates(1,p));
plot(x,y,'r');
%normal at the point
y = 1/tan(trough.normalAngles(p))*x + (trough.coordinates(2,p) - 1/tan(trough.normalAngles(p))*trough.coordinates(1,p));
plot(x,y,'k');
%tangent at the point
y = trough.gradients(p)*(x - trough.coordinates(1,p)) + trough.coordinates(2,p);
plot(x,y,'k')
clear x y


%Compute all possible reflected lines
l = length(trough.coordinates);
xr = repmat(trough.coordinates(1,:),l,1);
mr = repmat(gradientReflected', 1,l);
x1r = repmat(trough.coordinates(1,:)',1,l);
y1r = repmat(trough.coordinates(2,:)',1,l);
yr = mr.*(xr - x1r) + y1r;
%draw one reflected line
plot(xr(p,:),yr(p,:),'c');
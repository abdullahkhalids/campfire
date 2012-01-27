% p = 500;
% x =  trough.coordinates(1,:);
% y = gradientReflected(p)*x + (trough.coordinates(2,p) - gradientReflected(p)*trough.coordinates(1,p));
% y = gradientReflected(p)*(x - trough.coordinates(1,p)) + trough.coordinates(2,p);
% plot(x,y, 'y-');

% det = sqrt((2*gradientReflected'.*c).^2 - 4*(1+gradientReflected').*(c.^2 - receiver.radius^2));
% isInt = isrealm(det);
% x1 = isInt.*(- 2*gradientReflected'.*c + det)./(2*(1+gradientReflected'));
% x2 = isInt.*(- 2*gradientReflected'.*c - det)./(2*(1+gradientReflected'));
% y1 = gradientReflected'.*(x1 - trough.coordinates(1,:)') + trough.coordinates(2,:)';
% y2 = gradientReflected'.*(x2 - trough.coordinates(1,:)') + trough.coordinates(2,:)';
% 
% y = min(y1,y2);
% x = 1./gradientReflected' * (y - trough.coordinates(2,:)') - 




% det = 4*receiver.radius^2*gradientReflected'.^2.*c.^2 - 4*receiver.radius^2(gradientReflected'.^2+1)(c.^2 - receiver.radius^2);
% isThereIntersection = det >= 0;
% 
% theta = acos(-2*receiver.radius*gradientReflected'.*c + 

% c = trough.coordinates(2,:)' - gradientReflected'.*trough.coordinates(1,:)';
% det = 4*c.^2 - 4*(1+gradientReflected').*(c.^2 - receiver.radius^2*gradientReflected');
% isIntersection = det >=0;
% y1 = isIntersection.*(2*c + sqrt(det))./(2*(1+gradientReflected'));
% y2 = isIntersection.*(2*c - sqrt(det))./(2*(1+gradientReflected'));
% x1 = isIntersection.*(1./gradientReflected'.*(y1 - trough.coordinates(2,:)') - trough.coordinates(1,:)');
% x2 = isIntersection.*(1./gradientReflected'.*(y2 - trough.coordinates(2,:)') - trough.coordinates(1,:)');
% 
% dis1 = SquareDistance([x1 y1],trough.coordinates');
% dis2 = SquareDistance([x2 y2],trough.coordinates');
% 
% x = x1;
% y = y1;
% 
% shouldSwitch = dis2 < dis1;
% x(shouldSwitch) = x2(shouldSwitch);
% y(shouldSwitch) = y2(shouldSwitch);
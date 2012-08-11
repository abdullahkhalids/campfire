function axisVector = DishAxisVector(dish)
%DISHAXISVECTOR Uses the yaw, pitch and roll to compute the axis Vector.

a = dish.yaw;
b = dish.pitch;

axisVector = [cosd(a)*sind(b);
    cosd(a)*cosd(b);
    cosd(b)*sind(a)];

end


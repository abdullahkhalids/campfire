function value = materialProperty(materialTable,temperature)
% Uses interpolation to get the value of a property of a material a
% particular temperature.

% value = interp1(materialTable.temperature,materialTable.(materialTable.name),temperature,'spline');
value = polyval(materialTable.poly,temperature);


end


function value = materialProperty(materialTable,temperature)
%

value = interp1(materialTable.temperature,materialTable.(materialTable.name),temperature);


end


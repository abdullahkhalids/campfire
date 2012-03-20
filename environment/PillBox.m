function distribution = PillBox(sun,simulation)
%Computes a pillbox model of the sun

distribution = linspace(-sun.halfAngle,sun.halfAngle,1/simulation.grainLength);

distribution(2,:) = sun.irradiance/(2*sun.halfAngle);

end


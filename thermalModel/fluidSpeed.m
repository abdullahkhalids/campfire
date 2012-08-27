function v = fluidSpeed(flowRate,radius,density)
%Given a fluid with a density flowing through a cylindrical pipe with a
%radius at a flowRate, computes the fluid speed.

v = flowRate/(pi*radius^2*density);

end


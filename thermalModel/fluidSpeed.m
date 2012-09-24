function v = fluidSpeed(flowRate,diameter,density,annulusCheck,annulusDiameter)
%Given a fluid with a density flowing through a cylindrical pipe with a
%radius at a flowRate, computes the fluid speed.

radius = diameter/2;
if annulusCheck
    v = 4*flowRate/(pi*(diameter^2 - annulusDiameter^2));
else
    v = flowRate/(pi*radius^2*density);
end

end


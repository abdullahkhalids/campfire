function transmissionAngles = snellLaw(incidentAngles,incidentIndex,transmissionIndex)
%SNELLLAW Computes the transmission angle given the incident angle

transmissionAngles = asin(incidentIndex*sin(incidentAngles)/transmissionIndex);


end


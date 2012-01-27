function R= frenelReflectionCoefficient(incidenceAngles,transmissionAngles,incidentIndex,transmissionIndex,polarization)
%Computes the frenel reflection coefficient given the input parameters. The
%value of polarization can either be 's' or 'p' or 'mixed'.

R = 0;

if strcmp(polarization,'mixed')
    R = (s(incidenceAngles,transmissionAngles,incidentIndex,transmissionIndex) + p(incidenceAngles,transmissionAngles,incidentIndex,transmissionIndex))/2;
elseif strcmp(polarization,'s')
    R = s(incidenceAngles,transmissionAngles,incidentIndex,transmissionIndex);
elseif strcmp(polarization,'p')
    R = p(incidenceAngles,transmissionAngles,incidentIndex,transmissionIndex);
end


end

function Rs = s(incidenceAngles,transmissionAngles,incidentIndex,transmissionIndex)
rs = (incidentIndex.*cos(incidenceAngles) - transmissionIndex.*cos(transmissionAngles))./(incidentIndex.*cos(incidenceAngles) + transmissionIndex.*cos(transmissionAngles));
Rs = rs.*conj(rs);
end

function Rp = p(incidenceAngles,transmissionAngles,incidentIndex,transmissionIndex)
rp = ((incidentIndex.*cos(transmissionAngles) - transmissionIndex.*cos(incidenceAngles))./(incidentIndex.*cos(transmissionAngles) + transmissionIndex.*cos(incidenceAngles))).^2;
Rp = rp.*conj(rp);
end

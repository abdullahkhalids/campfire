
% get list of troughs
collectorList = best;

for i=1:size(best,1)
    trough.width = best(i,1);
    trough.focalLength = best(i,2);
    receiver.absorber.diameter = best(i,3);
    receiver.absorber.thickness = best(i,8);
    receiver.sleeve.diameter = best(i,4);
    receiver.sleeve.thickness = best(i,9);
    
    [Tplus Tminus] = errorAnalysis('trough','focalLength','0.03');
    [Tplus Tminus] = errorAnalysis('receiver','mislocation','[0 0.01]');
    [Tplus Tminus] = errorAnalysis('atmosphere','windSpeed','1');
    [Tplus Tminus] = errorAnalysis('trough','surfaceStdDev','5');
    [Tplus Tminus] = errorAnalysis('trough','trackingError','2');
    
end
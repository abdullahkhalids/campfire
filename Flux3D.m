function [PowerReceiver, PowerTrough,InterceptFactor] = Flux3D(receiverDistribution,trough,receiver,sun,simulation)
%2DFLUX3D Given the 2D distribution of flux on a grain length width element
% of the receiver, computes the 3D total flux etc

%Set up coordinate system
te = trough.length/2;
ts = -te;
re = receiver.length/2;


%The total flux per strip of the receiver
powerPerStrip = sum(receiverDistribution);

%Length of trough that does not contribute to flux on the receiver directly
%above the trough
angleFactor = trough.focalLength*tand(abs(sun.lengthAngle));

if angleFactor + ts < re %if the sun is not too inclined
    len = angleFactor - (re-te);
    if len < 0
        lengthCorrection = 0;
    else
        lengthCorrection = abs(len);
    end
else
    lengthCorrection = trough.length;
end

%Compute total power on receiver
PowerReceiver = powerPerStrip*(trough.length - lengthCorrection)/simulation.grainLength;

%Compute the total power that the trough received
PowerTrough = trough.width*trough.length*sun.irradiance*cosd(sun.widthAngle - rad2deg(trough.rotAngle));

%Compute efficiency
InterceptFactor = PowerReceiver/PowerTrough;


end


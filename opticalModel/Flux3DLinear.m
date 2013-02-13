function [InterceptFactor,PowerReceiver, PowerTrough,receiverEffectiveLength] = Flux3DLinear(intersectionIndexes,isIntersection,intensitiesReflection,trough,receiver,sun,simulation)
%2DFLUX3D Given the intersection points on a receiver of rays and their
%intensities, computes the 3D total flux etc

% %add up all the intensities at the receiver for each point
% receiverDistribution = zeros(1,length(receiver.coordinates));
% for i=1:length(intensitiesReflection)
%     if isIntersection(i)
%         receiverDistribution(intersectionIndexes(i)) = receiverDistribution(intersectionIndexes(i)) + intensitiesReflection(i);
%     end
% end

receiverDistribution = sum(intensitiesReflection(isIntersection));

%Set up coordinate system.
%e:end
%s:start
%t:trough
%r:receiver
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

% The part of the receiver that receives concentrated light
receiverEffectiveLength = trough.length - lengthCorrection;

%Compute total power on receiver
PowerReceiver = powerPerStrip*receiverEffectiveLength/simulation.grainLength;

%Compute the total power that the trough received
PowerTrough = trough.width*trough.length*sun.irradiance*cosd(sun.widthAngle - rad2deg(trough.rotAngle));

%Compute efficiency
InterceptFactor = PowerReceiver/PowerTrough;


end


function anglesTransmission = Transmissions(anglesIncidence,medium1,medium2)
%Given incident angles computes the transmission angles

anglesTransmission = snellLaw(anglesIncidence,medium1.refractiveIndex,medium2.refractiveIndex);


end


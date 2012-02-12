% Version 4.0.
% Frozen February 12, 2012 05:00 pm.
%Implements the following features
%1.The simulation is only in 2D.
%2.The trough is a parabola. The receiver a circle with random
%perturbations on it. The geometerical properties including orientation and
%position of both objects is fully definable.
%3. The sun's position can be given. The sun cones of light.
%4. Light is reflected from the trough as per the reflection coefficient.
%However, the refractive index is still considered to be wavelength
%independent and the spectrum of the incoming sunlight is not considered.
%5. The intensity on every point on the receiver is available, but not the
%incident angles.
%6. Specularity has been implemented

%Bugs ang Technical
%1. Changes receiver coordinates so they start from the top. Helps to make
%it the distribution more continous.
%2. Massively rewrote code to implement specularity.
%3. Improved the gradient code.

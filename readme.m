% Version 3.1.
% Frozen February 05, 2012 01:00 pm.
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

%Bugs ang Technical
%1. Fixed the line-circle intersection code for circles not centered at the
%origin. Also, streamlined the code a bit

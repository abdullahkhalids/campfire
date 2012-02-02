% Version 2.3.
% Frozen February 02, 2012 10:30 pm.
%Implements the following features
%1.The simulation is only in 2D.
%2.The trough is a parabola. The receiver a circle with random
%perturbations on it. The geometerical properties including orientation and
%position of both objects is fully definable.
%3. The sun's position can be given. The sun only sends out single rays
%rather than cones.
%4. Light is reflected from the trough as per the reflection coefficient.
%However, the refractive index is still considered to be wavelength
%independent and the spectrum of the incoming sunlight is not considered.
%5. The intensity on every point on the receiver is available, but not the
%incident angles.

%Bugs ang Technical
%1. Fixed how gradients were being calculated. Now instead of the forward
%point being used for the computation, both the forward and backward points
%are being used.

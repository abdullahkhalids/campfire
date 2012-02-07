% Version 3.2.
% Frozen February 07, 2012 02:30 pm.
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
%1. Fixed a bug in the incidence angle code where I was getting greater
%than 90 deg angles
%2. Fixed a bug in Nearest Neighbour algorithm where accidently multiple
%points were at the same distance
%3.Implemented surface perturbations on trough
%4.Removed imaterial surface perturbations on the receiver surface and
%added gradient perturbations which will be useful later on. There are
%small problems on the edges

% Version 2.1.
% Frozen January 28, 2012 2:00 pm.
%Implements the following features
%1.The simulation is only in 2D.
%2.The trough is a parabola. The receiver a circle with random
%perturbations on it. The geometerical properties including orientation and
%position of both objects is full y definable.
%3. The sun's position can be given. The sun only sends out single rays
%rather than cones.
%4. Light is reflected from the trough as per the reflection coefficient.
%However, the refractive index is still considered to be wavelength
%independent and the spectrum of the incoming sunlight is not considered.
%5. The intensity on every point on the receiver is available, but not the
%incident angles.

%Bugs ang Technical
%1.Fixed a bug in the gradients computation. Gradients.m and GradientNormal.m
%2.Created functions to convert between angles and gradients and put them in
%the library.
%3.Made matrix dimensions uniform
%4.Made some variable renaming. Mainly 'angle' variables.
%simulation.grainSize went to simulation.grainLength.


%To be fixed
%1. Some problem is still there in receiver distribution

% Version 2.2.
% Frozen February 02, 2012 5:30 pm.
%Implements the following features
%1.The simulation is only in 2D.
%2.The trough is a parabola. The receiver a circle with random
%perturbations on it. The geometrical properties including orientation and
%position of both objects is fully definable.
%3. The sun's position can be given. The sun only sends out single rays
%rather than cones.
%4. Light is reflected from the trough as per the reflection coefficient.
%However, the refractive index is still considered to be wavelength
%independent and the spectrum of the incoming sunlight is not considered.
%5. The intensity on every point on the receiver is available, but not the
%incident angles.

%Bugs and Technical
%1. There were problems with how various angles were being calculated. I
%used the alternate method of vector dot products to compute the angles.
%Now seem to be getting the right results
%2.Created a database file dataValues in the library to store various
%material properties.

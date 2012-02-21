% Version 5.1.
% Frozen February 21, 2012 10:50 am.
%Implements the following features
%1.The simulation is only in3D.
%2.The trough is a parabola. The receiver a cyclinder with random
%perturbations on it. The geometerical properties including orientation and
%position of both objects is fully definable.
%3. The sun's position can be given. The sun cones of light.
%4. Light is reflected from the trough as per the reflection coefficient.
%However, the refractive index is still considered to be wavelength
%independent and the spectrum of the incoming sunlight is not considered.
%6. Specularity has been implemented

%Bugs ang Technical
%1. Made the model 3D using a 2D to 3D approximation.
%2. Fixed a bug in the Solar angles calculation and added finding out if
%it's daytime or not
%3. Added a very rough solar Intensity model

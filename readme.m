% Version 6.7.
% Frozen August 12, 2012 9:15 pm.

% This version is serious refactoring of the code, and is moving towards a
% public API version. It now implements an optical model for both a
% parabolic trough and a dish. A particular thermal model for the trough is
% also available.

% Specifically, refactored a few functions and moved around .m files within
% folders.

% Please start with constants.m. Define the properties of your system. Most
% properties are self explanatory.

% Then run either mainLinear.m or mainCircular.m depending on whether you
% have a structure with a constant cross-section or one with rotational
% symmetry.

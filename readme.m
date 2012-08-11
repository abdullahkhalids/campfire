% Version 6.6.
% Frozen August 11, 2012 11:30 pm.

% This version is serious refactoring of the code, and is moving towards a
% public API version. It now implements an optical model for both a
% parabolic trough and a dish. A particular thermal model for the trough is
% also available.

% Specifically, changed how materials were being defined and how objects
% were being defined.

% Please start with constants.m. Define the properties of your system. Most
% properties are self explanatory.

% Then run either mainLinear.m or mainCircular.m depending on whether you
% have a structure with a constant cross-section or one with rotational
% symmetry.

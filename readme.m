% Version 7.0.
% Frozen August 28, 2012 3:30 am.

% This version is serious refactoring of the code, and is moving towards a
% public API version. It now implements an optical model for both a
% parabolic trough and a dish, as well as thermal models.

% Please start with constants.m. Define the properties of your system. Most
% properties are self explanatory.

% Then run either mainLinear.m or mainCircular.m depending on whether you
% have a structure with a constant cross-section or one with rotational
% symmetry.

% New
% * A thermal model for the dish
% * Some primitive ability to compute costs
% * Two new functions LinearCollector and Circular Collector which allow
% the user to compute results with just these.

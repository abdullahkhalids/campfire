
% sheets
sheet = struct();
sheet(1).material = 'aluminium';
sheet(1).width = 1;
sheet(1).length = 1;
sheet(1).cost = 540;
sheet(2).material = 'alref1';
sheet(2).width = 1;
sheet(2).length = 1;
sheet(2).cost = 540+1500;
sheet(3).material = 'alref2';
sheet(3).width = 1;
sheet(3).length = 1;
sheet(3).cost = 540+3000;

% pipes
pipe = struct();
% galvanized iron, Light
materialname1 = 'cermet';
pipe(1).material = materialname1;
pipe(1).diameter = 0.015;
pipe(1).thickness = 0.0020;
pipe(1).length = 1;
pipe(1).cost = 114;
pipe(2).material = materialname1;
pipe(2).diameter = 0.020;
pipe(2).thickness = 0.0023;
pipe(2).length = 1;
pipe(2).cost = 164;
pipe(3).material = materialname1;
pipe(3).diameter = 0.025;
pipe(3).thickness = 0.0023;
pipe(3).length = 1;
pipe(3).cost = 230;
pipe(4).material = materialname1;
pipe(4).diameter = 0.032;
pipe(4).thickness = 0.0026;
pipe(4).length = 1;
pipe(4).cost = 302;
pipe(5).material = materialname1;
pipe(5).diameter = 0.040;
pipe(5).thickness = 0.0029;
pipe(5).length = 1;
pipe(5).cost = 387;
pipe(6).material = materialname1;
pipe(6).diameter = 0.050;
pipe(6).thickness = 0.0029;
pipe(6).length = 1;
pipe(6).cost = 485;
pipe(7).material = materialname1;
pipe(7).diameter = 0.065;
pipe(7).thickness = 0.0032;
pipe(7).length = 1;
pipe(7).cost = 666;
pipe(8).material = materialname1;
pipe(8).diameter = 0.80;
pipe(8).thickness = 0.0032;
pipe(8).length = 1;
pipe(8).cost = 781;

materialname2 = 'glass';
pipe(9).material = materialname2;
pipe(9).diameter = 0.030;
pipe(9).thickness = 0.002;
pipe(9).length = 1;
pipe(9).cost = 200;
pipe(10).material = materialname2;
pipe(10).diameter = 0.060;
pipe(10).thickness = 0.002;
pipe(10).length = 1;
pipe(10).cost = 400;
pipe(11).material = materialname2;
pipe(11).diameter = 0.110;
pipe(11).thickness = 0.002;
pipe(11).length = 1;
pipe(11).cost = 700;

materialname3 = 'ssrod';
pipe(12).material = materialname3;
pipe(12).diameter = 0.01;
pipe(12).thickness = 0.01;
pipe(12).length = 1;
pipe(12).cost = 400;


% fluids
fluid = struct();
fluid(1).material = 'oil';
fluid(1).volume = 1;
fluid(1).cost = 1000;
fluid(2).material = 'water';
fluid(2).volume = 1;
fluid(2).cost = 0;

% cost table
costTable = struct();
costTable.structure.sheet = 'width length';
costTable.structure.pipe = 'length';
costTable.structure.fluid = 'volume';
costTable.sheet = sheet;
costTable.pipe = pipe;
costTable.fluid = fluid;

clear pipe sheet fluid materialname1 materialname2 materialname3;
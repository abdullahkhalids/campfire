
% sheets
sheet = struct();
sheet(1).material = 'aluminium';
sheet(1).width = 1;
sheet(1).length = 5;
sheet(1).cost = 5000;
sheet(2).material = 'aluminium';
sheet(2).width = 1;
sheet(2).length = 3;
sheet(2).cost = 6000;


% pipes
pipe = struct();
pipe(1).material = 'copper';
pipe(1).diameter = 0.012;
pipe(1).thickness = 0.002;
pipe(1).length = 6;
pipe(1).cost = 2000;
pipe(2).material = 'copper';
pipe(2).diameter = 0.020;
pipe(2).thickness = 0.002;
pipe(2).length = 6;
pipe(2).cost = 3000;
pipe(3).material = 'glass';
pipe(3).diameter = 0.039;
pipe(3).thickness = 0.002;
pipe(3).length = 6;
pipe(3).cost = 600;

% fluids
fluid = struct();
fluid(1).material = 'oil';
fluid(1).volume = 1;
fluid(1).cost = 1000;

% cost table
costTable = struct();
costTable.structure.sheet = 'length';
costTable.structure.pipe = 'length';
costTable.structure.fluid = 'volume';
costTable.sheet = sheet;
costTable.pipe = pipe;
costTable.fluid = fluid;
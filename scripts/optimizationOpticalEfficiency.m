% We optimize over the following variables with the following limits for
% now.
% 0.1<trough.focalLength<1
% 0.2<trough.width<1.5
% 0.005<receiver.absorberDiameter = 0.02; %m
% 0.025<receiver.glassSleeveDiameter = 0.05; %m


fun = @(x) opticalEfficiencyError(x);

lu = [2 2 0.02 0.05];
lb = [0.1 0.2 0.005 0.025];

guess = [0.5 0.5 0.01 0.030];
options = optimset('Algorithm','interior-point');

[x fval] = fmincon(fun,guess,[],[],[],[],lb,lu,[],options);

disp(x);
disp(-fval);


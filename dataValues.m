%% Materials
%aluminium
aluminium = struct();
aluminium.material = 'aluminium';
aluminium.refractiveIndex = 1.26232 + 7.1855i; %at 0.6um
aluminium.density = 2700; %kg/m^3

%glass
glass2 = struct();
glass2.material = 'glass2';
glass2.refractiveIndex = 1.584 - 1.586i;

%water
water = struct();
water.material = 'water';
water.density = 1000; %kg/m^3
water.heatCapacity = 4200; %J/kg.K
water.latentHeatEvaporation = 2257e3; %J/kg
water.boilingPoint = 373.13; %K
water.heatCapacityVapor = 2000; %J/kg.K
water.viscosityTable.name = 'viscosity';
water.viscosityTable.temperature = celcius2kelvin(0:10:100);
water.viscosityTable.viscosity = [1.787 1.307 1.002 0.798 0.653 0.547 0.467 0.404 0.355 0.315 0.282]*1e-3; %Ps s
water.heatCapacityTable.name = 'heatCapacity';
water.heatCapacityTable.temperature = celcius2kelvin(0:20:100);
water.heatCapacityTable.heatCapacity = [4217 4182 4179 4184 4196 4216]; %J/kg K
water.densityTable.name = 'density';
water.densityTable.temperature = celcius2kelvin(0:20:100);
water.densityTable.density = [1000 998 992 983 971.8 958.4];%kg/m^3
water.heatConductivityTable.name = 'heatConductivity';
water.heatConductivityTable.temperature = 275:10:375;
water.heatConductivityTable.heatConductivity = [574 590 606 620 634 645 656 664 671 677 681]*1e-3; %W/m K


%Syltherm 800 Stabilized HTF
syltherm = struct();
syltherm.material = 'syltherm';
syltherm.density = 864; %kg/m^2
syltherm.heatCapacity = 1750; %J/kg K
syltherm.heatConductivity = 0.12; %W/m.K
syltherm.viscosityTable.name = 'viscosity';
syltherm.viscosityTable.temperature = celcius2kelvin(0:50:400);
syltherm.viscosityTable.viscosity = [15.33 5.96 2.99 1.70 1.05 0.69 0.47 0.33 0.25]*1e-3; %Ps s
syltherm.heatCapacityTable.name = 'heatCapacity';
syltherm.heatCapacityTable.temperature = celcius2kelvin(0:20:400);
syltherm.heatCapacityTable.heatCapacity = [1.574 1.608 1.643 1.677 1.711 1.745 1.779 1.813 1.847 1.882 1.916 1.950 1.984 2.018 2.052 2.086 2.121 2.155 2.189 2.223 2.257]*1e3; %J/kg K
syltherm.densityTable.name = 'density';
syltherm.densityTable.temperature = celcius2kelvin(0:50:400);
syltherm.densityTable.density = [953.16 908.18 864.05 819.51 773.33 724.24 670.99 612.33 547];%kg/m^3
syltherm.heatConductivityTable.name = 'heatConductivity';
syltherm.heatConductivityTable.temperature = celcius2kelvin(0:50:400);
syltherm.heatConductivityTable.heatConductivity = [1388 1294 1200 1106 1012 918 824 729 635]*1e-4; %W/m K

%oil
oil = struct();
oil.material = 'oil';
oil.density = 864; %kg/m^3
oil.heatCapacity = 1750; %J/kg.K
oil.heatConductivity = 0.12; %W/m.K
oil.thermalConductivityTable = struct();
oil.thermalConductivityTable.name = 'thermalConductivity';
oil.thermalConductivityTable.temperature = [293 313 333 353 373 393 413 433]; %K
oil.thermalConductivityTable.thermalConductivity = [0.145 0.144 0.140 0.138 0.137 0.135 0.133 0.132]; %W/ m K Thermal conductivity
oil.viscosityTable = struct();
oil.viscosityTable.name = 'viscosity';
oil.viscosityTable.temperature = [290 300 310 320 330 340 350 400 450 500 550 600 700 800 900 1000]; %K
oil.viscosityTable.viscosity = [901 242 83.9 37.5 20.3 12.4 8.0 5.6]*10^-6; %Kinematic viscosity m^2/s
oil.prandtlNumberTable = struct();
oil.prandtlNumberTable.name = 'prandtlNumber';
oil.prandtlNumberTable.temperature = [290 300 310 320 330 340 350 400 450 500 550 600 700 800 900 1000]; %K
oil.prandtlNumberTable.prandtlNumber = [10400 2870 1050 490 276 175 116 84];
oil.densityTable = struct();
oil.densityTable.name = 'density';
oil.densityTable.temperature = [290 300 310 320 330 340 350 400 450 500 550 600 700 800 900 1000]; %K
oil.densityTable.density = [888 876 864 852 840 829 817 806]; %kg.m^3


%Freon R-12
freon = struct();
freon.material = 'freon';
freon.density = 1400; %kg/m^3;
freon.heatCapacity = 1000; %J/kg.K
freon.latentHeatEvaporation = 165e3; %J/kg
freon.boilingPoint = 243; %K
%freon.heatCapacityVapor = 

%Ethanol
ethanol = struct();
ethanol.material = 'ethanol';
ethanol.density = 789; %kg/m^3
ethanol.heatCapacity = 2434; %J/kg.K
ethanol.latentHeatEvaporation = 846e3; %J/kg
ethanol.boilingPoint = 351; % K
ethanol.heatCapacityVapor = 1891; %J/kg.K

%Ammonia
ammonia = struct();
ammonia.material = 'ammonia';
ammonia.density = 789; %kg/m^3
ammonia.heatCapacity = 2434; %J/kg.K
ammonia.latentHeatEvaporation = 846e3; %J/kg
ammonia.boilingPoint = 351; % K
ammonia.heatCapacityVapor = 1891; %J/kg.K

%chrome
chrome.material = 'chrome';
chrome.emissivity = 0.24; %units
chrome.thermalConductivity = 17; %W/mK
chrome.absorptance = 0.95;

%bad chrome
badchrome.material = 'badchrome';
badchrome.emissivity = 0.4; %units
badchrome.thermalConductivity = 17; %W/mK
badchrome.absorptance = 0.80;


%cermat
cermet = struct();
cermet.material = 'cermet';
cermet.emissivity = 0.14;
cermet.thermalConductivity = 17; %W/mk
cermet.absorptance = 0.96;


%Stainless Steel
stainlessSteel.material = 'stainlessSteel';
stainlessSteel.emissivity = 0.85;
stainlessSteel.thermalConductivity = 17; %W/mK
stainlessSteel.density = 8030; %kg/m^3
stainlessSteel.heatCapacity = 500; %J/kg K

%air
air = struct();
air.material = 'air';
air.refractiveIndex = 1;
air.thermalConductivityTable = struct();
air.thermalConductivityTable.name = 'thermalConductivity';
air.thermalConductivityTable.temperature = [290 300 310 320 330 340 350 400 450 500 550 600 700 800 900 1000]; %K
air.thermalConductivityTable.thermalConductivity = [0.0253 0.0261 0.0268 0.0275 0.0283 0.0290 0.0297 0.0331 0.0363 0.0395 0.0426 0.0456 0.0513 0.0569 0.0625 0.0672]; %W/ m K Thermal conductivity
air.viscosityTable = struct();
air.viscosityTable.name = 'viscosity';
air.viscosityTable.temperature = [290 300 310 320 330 340 350 400 450 500 550 600 700 800 900 1000]; %K
air.viscosityTable.viscosity = [1.48 1.57 1.67 1.77 1.86 1.96 2.06 2.6 3.18 3.8 4.45 5.15 6.64 8.25 9.99 11.8]*10^-5; %Kinematic viscosity m^2/s
air.prandtlNumberTable = struct();
air.prandtlNumberTable.name = 'prandtlNumber';
air.prandtlNumberTable.temperature = [290 300 310 320 330 340 350 400 450 500 550 600 700 800 900 1000]; %K
air.prandtlNumberTable.prandtlNumber = [0.714 0.712 0.711 0.710 0.708 0.707 0.706 0.703 0.7 0.699 0.698 0.698 0.702 0.704 0.705 0.709];
air.thermalDiffusivityTable.name = 'thermalDiffusivity';
air.thermalDiffusivityTable.temperature = [290 300 310 320 330 340 350 400 450 500 550 600 700 800 900 1000]; %K
air.thermalDiffusivityTable.thermalDiffusivity = [2.08 2.21 2.35 2.49 2.64 2.78 2.92 3.70 4.54 5.44 6.39 7.37 9.46 11.7 14.2 16.7]*1e-5; %m^2/s

%vacuum
vacuum = struct();
vacuum.material = 'vacuum';

%hydrogen
hydrogen = struct();
hydrogen.material = 'hydrogen';

%butane
butane = struct();
butane.material = 'butane';
butane.density = 601; %kg/m^3
butane.heatCapacity = 2.31e3; %J/kg.K
butane.latentHeatEvaporation = 385.2e3; %J/kg
butane.boilingPoint = 272.66; %K
butane.heatCapacityVapor = 1694; %J/kg.K

%glass
glass = struct();
glass.material = 'glass';
glass.emissivity = 0.86;
glass.absorptance = 0.05;

%ceramic
ceramic = struct();
ceramic.material = 'ceramic';
ceramic.heatCapacity = 850; %J/kg K
ceramic.convectiveCoefficient = 100; %J/kg K
ceramic.emissivity = 0.4;
ceramic.density = 2000;

%% Environments and location
%lahore
lahore.latitude = [31 32 59]; %N
lahore.longitude = [74 20 37];%E
lahore.timezoneLongitude = 75; %E
lahore.monthlyIntensities = [180.96 221.22 238.40 272.16 281.71 297.76 266.31 246.74 270.63 235.60 201.71 169.01]*3.155; %kw/m^2
lahore.monthlyTemperatures = [18 22 27 34 39 38 35 34 34 32 27 21]+273.16; %K
lahore.windSpeed = 0.05; %m/s

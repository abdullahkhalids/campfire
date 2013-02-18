warning('off','MATLAB:polyfit:RepeatedPointsOrRescale');

%% Materials
%aluminium
materials.aluminium = struct();
materials.aluminium.material = 'aluminium';
materials.aluminium.refractiveIndex = 1.26232 + 7.1855i; %at 0.6um
materials.aluminium.density = 2700; %kg/m^3

%glass
materials.glass2 = struct();
materials.glass2.material = 'glass2';
materials.glass2.refractiveIndex = 1.584 - 1.586i;

%water
materials.water = struct();
materials.water.material = 'water';
materials.water.density = 1000; %kg/m^3
materials.water.heatCapacity = 4200; %J/kg.K
materials.water.latentHeatEvaporation = 2257e3; %J/kg
materials.water.boilingPoint = 373.13; %K
materials.water.heatCapacityVapor = 2000; %J/kg.K
materials.water.viscosityTable.name = 'viscosity';
x = celcius2kelvin(0:10:100); y =[1.787 1.307 1.002 0.798 0.653 0.547 0.467 0.404 0.355 0.315 0.282]*1e-3;
materials.water.viscosityTable.temperature = x;
materials.water.viscosityTable.viscosity = y; %Ps s
materials.water.viscosityTable.poly = polyfit(x,y,polydeg(x,y));
materials.water.heatCapacityTable.name = 'heatCapacity';
x = celcius2kelvin(0:20:100); y = [4217 4182 4179 4184 4196 4216];
materials.water.heatCapacityTable.temperature = x;
materials.water.heatCapacityTable.heatCapacity = y; %J/kg K
materials.water.heatCapacityTable.temperature = x;
materials.water.heatCapacityTable.poly = polyfit(x,y,polydeg(x,y));
materials.water.densityTable.name = 'density';
x = celcius2kelvin(0:20:100); y = [1000 998 992 983 971.8 958.4];
materials.water.densityTable.temperature = x;
materials.water.densityTable.density = y;%kg/m^3
materials.water.densityTable.poly = polyfit(x,y,polydeg(x,y));
materials.water.heatConductivityTable.name = 'heatConductivity';
x = 275:10:375; y = [574 590 606 620 634 645 656 664 671 677 681]*1e-3;
materials.water.heatConductivityTable.temperature = x;
materials.water.heatConductivityTable.heatConductivity = y; %W/m K
materials.water.heatConductivityTable.poly = polyfit(x,y,polydeg(x,y));


%Syltherm 800 Stabilized HTF
materials.syltherm = struct();
materials.syltherm.material = 'syltherm';
materials.syltherm.density = 864; %kg/m^2
materials.syltherm.heatCapacity = 1750; %J/kg K
materials.syltherm.heatConductivity = 0.12; %W/m.K
materials.syltherm.viscosityTable.name = 'viscosity';
materials.syltherm.viscosityTable.temperature = celcius2kelvin(0:50:400);
materials.syltherm.viscosityTable.viscosity = [15.33 5.96 2.99 1.70 1.05 0.69 0.47 0.33 0.25]*1e-3; %Ps s
materials.syltherm.heatCapacityTable.name = 'heatCapacity';
materials.syltherm.heatCapacityTable.temperature = celcius2kelvin(0:20:400);
materials.syltherm.heatCapacityTable.heatCapacity = [1.574 1.608 1.643 1.677 1.711 1.745 1.779 1.813 1.847 1.882 1.916 1.950 1.984 2.018 2.052 2.086 2.121 2.155 2.189 2.223 2.257]*1e3; %J/kg K
materials.syltherm.densityTable.name = 'density';
materials.syltherm.densityTable.temperature = celcius2kelvin(0:50:400);
materials.syltherm.densityTable.density = [953.16 908.18 864.05 819.51 773.33 724.24 670.99 612.33 547];%kg/m^3
materials.syltherm.heatConductivityTable.name = 'heatConductivity';
materials.syltherm.heatConductivityTable.temperature = celcius2kelvin(0:50:400);
materials.syltherm.heatConductivityTable.heatConductivity = [1388 1294 1200 1106 1012 918 824 729 635]*1e-4; %W/m K

%oil
materials.oil = struct();
materials.oil.material = 'oil';
materials.oil.density = 864; %kg/m^3
materials.oil.heatCapacity = 1750; %J/kg.K
materials.oil.heatConductivity = 0.12; %W/m.K
materials.oil.thermalConductivityTable = struct();
materials.oil.thermalConductivityTable.name = 'thermalConductivity';
materials.oil.thermalConductivityTable.temperature = [293 313 333 353 373 393 413 433]; %K
materials.oil.thermalConductivityTable.thermalConductivity = [0.145 0.144 0.140 0.138 0.137 0.135 0.133 0.132]; %W/ m K Thermal conductivity
materials.oil.viscosityTable = struct();
materials.oil.viscosityTable.name = 'viscosity';
materials.oil.viscosityTable.temperature = [290 300 310 320 330 340 350 400 450 500 550 600 700 800 900 1000]; %K
materials.oil.viscosityTable.viscosity = [901 242 83.9 37.5 20.3 12.4 8.0 5.6]*10^-6; %Kinematic viscosity m^2/s
materials.oil.prandtlNumberTable = struct();
materials.oil.prandtlNumberTable.name = 'prandtlNumber';
materials.oil.prandtlNumberTable.temperature = [290 300 310 320 330 340 350 400 450 500 550 600 700 800 900 1000]; %K
materials.oil.prandtlNumberTable.prandtlNumber = [10400 2870 1050 490 276 175 116 84];
materials.oil.densityTable = struct();
materials.oil.densityTable.name = 'density';
materials.oil.densityTable.temperature = [290 300 310 320 330 340 350 400 450 500 550 600 700 800 900 1000]; %K
materials.oil.densityTable.density = [888 876 864 852 840 829 817 806]; %kg.m^3


%Freon R-12
materials.freon = struct();
materials.freon.material = 'freon';
materials.freon.density = 1400; %kg/m^3;
materials.freon.heatCapacity = 1000; %J/kg.K
materials.freon.latentHeatEvaporation = 165e3; %J/kg
materials.freon.boilingPoint = 243; %K
%freon.heatCapacityVapor = 

%Ethanol
materials.ethanol = struct();
materials.ethanol.material = 'ethanol';
materials.ethanol.density = 789; %kg/m^3
materials.ethanol.heatCapacity = 2434; %J/kg.K
materials.ethanol.latentHeatEvaporation = 846e3; %J/kg
materials.ethanol.boilingPoint = 351; % K
materials.ethanol.heatCapacityVapor = 1891; %J/kg.K

%Ammonia
materials.ammonia = struct();
materials.ammonia.material = 'ammonia';
materials.ammonia.density = 789; %kg/m^3
materials.ammonia.heatCapacity = 2434; %J/kg.K
materials.ammonia.latentHeatEvaporation = 846e3; %J/kg
materials.ammonia.boilingPoint = 351; % K
materials.ammonia.heatCapacityVapor = 1891; %J/kg.K

%chrome
materials.chrome.material = 'chrome';
materials.chrome.emissivity = 0.24; %units
materials.chrome.thermalConductivity = 17; %W/mK
materials.chrome.absorptance = 0.95;

%bad chrome
materials.badchrome.material = 'badchrome';
materials.badchrome.emissivity = 0.4; %units
materials.badchrome.thermalConductivity = 17; %W/mK
materials.badchrome.absorptance = 0.80;


%cermat
materials.cermet = struct();
materials.cermet.material = 'cermet';
materials.cermet.emissivity = 0.14;
materials.cermet.thermalConductivity = 17; %W/mk
materials.cermet.absorptance = 0.96;


%Stainless Steel
materials.stainlessSteel.material = 'stainlessSteel';
materials.stainlessSteel.emissivity = 0.85;
materials.stainlessSteel.thermalConductivity = 17; %W/mK
materials.stainlessSteel.density = 8030; %kg/m^3
materials.stainlessSteel.heatCapacity = 500; %J/kg K

%air
materials.air = struct();
materials.air.material = 'air';
materials.air.refractiveIndex = 1;
materials.air.thermalConductivityTable = struct();
materials.air.thermalConductivityTable.name = 'thermalConductivity';
x = [290 300 310 320 330 340 350 400 450 500 550 600 700 800 900 1000];
y = [0.0253 0.0261 0.0268 0.0275 0.0283 0.0290 0.0297 0.0331 0.0363 0.0395 0.0426 0.0456 0.0513 0.0569 0.0625 0.0672];
materials.air.thermalConductivityTable.temperature = x; %K
materials.air.thermalConductivityTable.thermalConductivity = y; %W/ m K Thermal conductivity
materials.air.thermalConductivityTable.poly = polyfit(x,y,polydeg(x,y));
materials.air.viscosityTable = struct();
materials.air.viscosityTable.name = 'viscosity';
x = [290 300 310 320 330 340 350 400 450 500 550 600 700 800 900 1000];
y = [1.48 1.57 1.67 1.77 1.86 1.96 2.06 2.6 3.18 3.8 4.45 5.15 6.64 8.25 9.99 11.8]*10^-5;
materials.air.viscosityTable.temperature = x; %K
materials.air.viscosityTable.viscosity = y; %Kinematic viscosity m^2/s
materials.air.viscosityTable.poly = polyfit(x,y,polydeg(x,y));
materials.air.prandtlNumberTable = struct();
materials.air.prandtlNumberTable.name = 'prandtlNumber';
x = [290 300 310 320 330 340 350 400 450 500 550 600 700 800 900 1000];
y = [0.714 0.712 0.711 0.710 0.708 0.707 0.706 0.703 0.7 0.699 0.698 0.698 0.702 0.704 0.705 0.709];
materials.air.prandtlNumberTable.temperature = x; %K
materials.air.prandtlNumberTable.prandtlNumber = y;
materials.air.prandtlNumberTable.poly = polyfit(x,y,polydeg(x,y));
materials.air.thermalDiffusivityTable.name = 'thermalDiffusivity';
x = [290 300 310 320 330 340 350 400 450 500 550 600 700 800 900 1000];
y = [2.08 2.21 2.35 2.49 2.64 2.78 2.92 3.70 4.54 5.44 6.39 7.37 9.46 11.7 14.2 16.7]*1e-5;
materials.air.thermalDiffusivityTable.temperature = x; %K
materials.air.thermalDiffusivityTable.thermalDiffusivity = y; %m^2/s
materials.air.thermalDiffusivityTable.poly = polyfit(x,y,polydeg(x,y));

%vacuum
materials.vacuum = struct();
materials.vacuum.material = 'vacuum';

%hydrogen
materials.hydrogen = struct();
materials.hydrogen.material = 'hydrogen';

%butane
materials.butane = struct();
materials.butane.material = 'butane';
materials.butane.density = 601; %kg/m^3
materials.butane.heatCapacity = 2.31e3; %J/kg.K
materials.butane.latentHeatEvaporation = 385.2e3; %J/kg
materials.butane.boilingPoint = 272.66; %K
materials.butane.heatCapacityVapor = 1694; %J/kg.K

%glass
materials.glass = struct();
materials.glass.material = 'glass';
materials.glass.emissivity = 0.86;
materials.glass.absorptance = 0.05;

%ceramic
materials.ceramic = struct();
materials.ceramic.material = 'ceramic';
materials.ceramic.heatCapacity = 850; %J/kg K
materials.ceramic.convectiveCoefficient = 100; %J/kg K
materials.ceramic.emissivity = 0.4;
materials.ceramic.density = 2000;

%% Environments and location
%lahore
locations.lahore.latitude = [31 32 59]; %N
locations.lahore.longitude = [74 20 37];%E
locations.lahore.timezoneLongitude = 75; %E
locations.lahore.monthlyIntensities = [180.96 221.22 238.40 272.16 281.71 297.76 266.31 246.74 270.63 235.60 201.71 169.01]*3.155; %kw/m^2
locations.lahore.monthlyTemperatures = [18 22 27 34 39 38 35 34 34 32 27 21]+273.16; %K
locations.lahore.windSpeed = 0.05; %m/s

%% Fuels
%diesel
fuels.diesel.heatingValue = 43.1e6; %MJ/kg
fuels.diesel.massPrice = 109; %Rs/kg

%suigas
fuels.suigas.joulePrice = 460/1.06e9; %Rs/J


clear x y;

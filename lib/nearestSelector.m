function [rho1 Cp1 k1 alpha1 mu1 vis1 Pr1 Beta1] = nearestSelector(temp,material)

%for unsed engine oil ref page 955 Turner
if material == 'oil'
t   = [20 40 60 80 100 120 140 160] + 273; %Kelvn Temperature
rho = [888 876 864 852 840 829 817 806]; %kg.m^3 Density
Cp  = [1880 1964 2047 2131 2219 2307 2395 2483]; %J/kg K Specific Heat
k   = [0.145 0.144 0.140 0.138 0.137 0.135 0.133 0.132]; %W/ m K Thermal conductivity
alpha=[8.72 8.34 8.00 7.69 7.38 7.10 6.86 6.63]*10^-8; %m^2/s Thermal diffusivity
mu  = [800 212 72.5 32 17.1 10.2 6.53 4.49]*10^-3; %kg/m s Dynamic Viscosity
vis = [901 242 83.9 37.5 20.3 12.4 8.0 5.6]*10^-6; %Kinematic viscosity m^2/s
Pr  = [10400 2870 1050 490 276 175 116 84]; %Prandtl Number

    for i=1:length(t)
        if temp<(t(i) + t(i+1))/2
            rho1 = rho(i);
            Cp1 = Cp(i);
            k1 = k(i);
            alpha1 = alpha(i);
            mu1 = mu(i);
            vis1 = vis(i);
            Pr1 = Pr(i);
            Beta1=0;
            break
        end
    end
%for air ref page 956 Turner
elseif material == 'air'
t   = [290 300 310 320 330 340 350 400 450 500 550 600 700 800 900 1000]; %Kelvn Temperature
k   = [0.0253 0.0261 0.0268 0.0275 0.0283 0.0290 0.0297 0.0331 0.0363 0.0395 0.0426 0.0456 0.0513 0.0569 0.0625 0.0672]; %W/ m K Thermal conductivity
vis = [1.48 1.57 1.67 1.77 1.86 1.96 2.06 2.6 3.18 3.8 4.45 5.15 6.64 8.25 9.99 11.8]*10^-5; %Kinematic viscosity m^2/s
Pr  = [0.714 0.712 0.711 0.710 0.708 0.707 0.706 0.703 0.7 0.699 0.698 0.698 0.702 0.704 0.705 0.709]; %Prandtl Number
Beta = 1./t;

    for i=1:length(t)
        if temp<(t(i) + t(i+1))/2
            k1 = k(i);
            vis1 = vis(i);
            Pr1 = Pr(i);
            Beta1 = Beta(i);
            rho1=0;
            Cp1=0;
            alpha1=0;
            mu1=0;
            break
        end
    end
else
    disp('screw you');
end






end




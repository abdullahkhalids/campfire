% testType = 'thermal'; %efficiency;
% material = 'cermet'; %chrome
% gas = 'air'; %vacuum

if strcmp(testType,'thermal')
    %% thermal data
    if strcmp(material,'cermet')
        if strcmp(gas,'vacuum')
            %cermat/vacuum/thermal
            inletTemp = [99.5 100.02 153.4 199.4 253.8 299.0   348.3];
            windSpeed = [3.2 2.9 1.1 0.1 1.5 2.0   0.6];
            ambTemp = [26.3 25.4 19.9 22.5 24.2 26.7   27.6];
            flowRate = [27.4 27.4 53.6 54.7 55.6 56.0   56.8]; %l/min
            outletTemp = [99.4 99.97 153.3 199.0 253.1 297.9  346.6];
            heatLoss = [0.3 0.85 5.3 14.04  23.4 36.7   55.8];
            
        elseif strcmp(gas,'air')
            
            %cermat/air/thermal
            inletTemp = [98.7 148.5 202.0 252.5 300.3 344.8];
            windSpeed = [5.2 4.5 0.8 0.6 1.5 1.1];
            ambTemp = [19.6 22.1 23.6 24.7 23.2 26.3];
            flowRate = [51.4 53.8 54.6 55.4 56.5 56.7]; %L/min
            outletTemp = [98.2 147.8 200.9 250.9 297.9 341.8];
            heatLoss = [13.7 24.7 36.3 54.8 78.3 98.6];
        end
    elseif strcmp(material,'chrome')
        if strcmp(gas,'vacuum')
            %chrome/vacuum/thermal
            inletTemp = [103.2 204.1 300.8 351.0 150.9 348.5 253.9];
            windSpeed = [0.6 1 1.7 2.5 0.3 2.8 1.5];
            ambTemp = [2.3 6.0 7.5 8.9 -5.2 1.1 1.1];
            flowRate = [50.3 54.1 55.8 56.7 52.5 56.7 55.1]; %L/min
            outletTemp = [102.9 203.4 299.0 348.2 150.6 345.7 252.8];
            heatLoss = [6.8 22.0 62.0 89.1 12.4 89.1 36.7];
        elseif strcmp(gas,'air')
            %chrome/air/thermal
            inletTemp = [302.4 349.4 251.9 201.7 150.4 101.6];
            windSpeed = [0.6 0.6 2.5 1.7 0.8 1]; %last data point is bad
            ambTemp = [3 1.5 2.7 3.5 3.9 2.9];
            flowRate = [55.6 56.6 54.9 53.5 52.0 43.0];
            outletTemp = [299.7 345.7 249.9 200.2 149.4 100.6];
            heatLoss = [99.6 118.5 70.7 50.5 32.7 14];
        end
    end
elseif strcmp(testType,'efficiency')
    %% efficiency data
    if strcmp(material,'cermet')
        if strcmp(gas,'vacuum')
            %cermat/vacuum/efficiency
            %Table D-1
            inletTemp = [102.2 151.0 197.5 250.7 297.8 299.0 379.5 355.9];
            ambTemp = [21.2 22.4 24.3 26.2 28.8 27.5 29.5 31.1];
            insolation = [933.7 968.2 982.3 909.5 937.9 880.6 920.9 903.2];
            flowRate = [47.7 47.8 49.1 54.7 55.5 55.6 56.8 56.3];
            windSpeed = [2.6 3.7 2.5 3.3 1.0 2.9 2.6 4.2];
            outletTemp = [124.0 173.3 219.5 269.4 316.4 317.2 398.0 374.0];
            efficiency = [72.51 70.9 70.17 70.25 67.98 68.92 62.34 63.82];
        elseif strcmp(gas,'air')
            %cermat/air/efficiency
            %Table D-3
            inletTemp = [251.1 344.9 345.5 101.2 154.3 202.4 250.7 299.5 348.9 376.6];
            ambTemp = [28.6 28.7 29.1 25.8 27.6 28.6 30.0 31.7 27.4 29.7];
            insolation = [889.7 874.1 870.4 813.1 858.4 878.7 896.4 906.7 879.5 898.6];
            flowRate = [55.3 56.2 56.1 50.3 52.9 54.6 55.2 55.4 55.4 56.2];
            windSpeed = [2.8 4.0 0.6 3.6 3.1 3.1 0.9 0.0 1.8 2.8];
            outletTemp = [268.3 361.1 361.6 119 171.7 219.4 267.8 316.5 365.2 393.1]; %air in annulus
            efficiency = [66.61 59.60 59.40 71.56 69.20 67.10 65.5 62.58 58.52 56.51];
        end
        
        
    elseif strcmp(material,'chrome')
        if strcmp(gas,'vacuum')
            %chrome/vacuum/efficiency
            %Table D-7
            inletTemp = [103.4 253.3 349.6 154.0 201.6 201.5 303.1 100.8 379.6];
            ambTemp = [3.6 -3.1 -0.7 6.4 0.2 1.6 2.6 -5.0 -0.9];
            insolation = [839.8 882.7 921.5 902.0 900.7 871.8 884.6 744.6 928.4];
            flowRate = [50.6 54.8 56.0 52.1 54.0 53.2 54.9 50.7 56.1];
            windSpeed = [1.3 1.1 2.1 0.0 0.0 1.3 4.0 3.0 1.1 2.4];
            outletTemp = [122.2 271.3 367.3 173.3 219.9 219.5 320.6 117.2 397.4]; %air in annulus
            efficiency = [73.56 69.58 61.49 72.1 69.91 69.69 65.36 72.47 57.7];
            
        elseif strcmp(gas,'air')
            %chrome/air/efficiency
            %Table D-9
            inletTemp = [379.7 101.9 203.2 301.6 251.8 350.2 154.2];
            ambTemp = [0.1 -1.0 -0.6 0.5 1.3 5.9 5.1];
            insolation = [919.5 755.0 850.9 899.7 909.6 908.1 902.6];
            flowRate = [56.2 50.3 54.3 56.2 55.0 55.6 52.1];
            windSpeed = [1.4 5.5 4.7 4.4 1.2 5.9 1.7];
            outletTemp = [395.8 117.9 219.0 317.6 268.7 366.3 172.4];
            efficiency = [53.71 69.07 64.14 60.08 63.32 56.17 67.88];
        end
    end
    
end

n = length(inletTemp);
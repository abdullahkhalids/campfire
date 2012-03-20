function [outPower, outTemperature] = turbine(inputPressure,outputPressure,temperature,massFlowRate,turbineEfficiency)
%Given the input state of the turbine, computes the output state. Pressure
%is in bar, temperature in celcius, and massFlowRate in kg/s.
%%ONLY WORKS FOR WATER


%Compute input state
inputSaturatedVapourEnthalpy = Xsteam('hV_p',inputPressure);
inputSaturatedVapourEntropy = Xsteam('sV_p', inputPressure);

%Output state
outputTotalEntropy = inputSaturatedVapourEntropy;

outputSaturatedVapourEntropy = Xsteam('sV_p',outputPressure);
outputSaturatedLiquidEntropy = Xsteam('sL_p',outputPressure);
%outputSaturatedVapourEnthalpy = Xsteam('hV_p',outputPressure);

Quality = (outputTotalEntropy - outputSaturatedLiquidEntropy)/(outputSaturatedVapourEntropy - outputSaturatedLiquidEntropy);

outputSaturatedLiquidEnthalpy = Xsteam('hL_p',outputPressure);
outputSaturatedVapourEnthalpy = Xsteam('hV_p',outputPressure);

outputEnthalpy = outputSaturatedLiquidEnthalpy + Quality*outputSaturatedVapourEnthalpy;

outputSaturationTemperature = Xsteam('Tsat_p', outputPressure);

idealPower = massFlowRate*(inputSaturatedVapourEnthalpy - outputEnthalpy);

actualPower = turbineEfficiency*idealPower;

%Exit variables
outPower = actualPower;
outTemperature = celcius2kelvin(outputSaturationTemperature);


end


ccc;

costLimit = 50000;

warning off;

systemInOut = zeros(1,7);

% load some default values
constants;

%costs
costs;

% parameters to vary
widthRange = 0.6:0.2:1.8;
focalLengthRange = [0.1:0.05:0.4 0.5:0.1:0.9];
%absorber
%sleeve

k = 1;
for w = widthRange
    trough.width = w;
    for f = focalLengthRange
        trough.focalLength = f;
        for a = 2:8
            
            receiver.absorber = mergeStructs(pipe(a),receiver.absorber);
            if receiver.absorber.diameter - 0.005 < receiver.annulus.diameter
                continue
            end
            
            for s = 9:11
                receiver.sleeve = mergeStructs(pipe(s),receiver.sleeve);
                if receiver.absorber.diameter + 0.005 > receiver.sleeve.diameter
                    continue
                end
                
                %compute rest of parameters
                calculations;
                
                [TotalCost individualCosts] = ComputeCosts(costTable,trough,receiver,collectorCycle,troughStructure);
                
                % impost total cost constraint
                if TotalCost > costLimit
                    continue;
                end                
             
                %reset random number stream
                defaultStream = RandStream.getDefaultStream;
                load('randstream');
                defaultStream.State = savedState;
                
                %optical model
                [InterceptFactor,PowerReceiver, PowerTrough, receiver.effectiveLength] = OpticalModelLinear(simulation,trough,receiver,sun,atmosphere);
                
                %Output temperature from receiver
                [collectorCycle.outletTemperature T] = ReceiverTemperatureLinear(receiver, PowerReceiver, collectorCycle, atmosphere,simulation);
                
                
                massFlowRate = collectorCycle.flowRate*materialProperty(collectorCycle.fluid.densityTable,collectorCycle.inletTemperature);
                Trise = collectorCycle.outletTemperature - collectorCycle.inletTemperature;
                thermalGain = massFlowRate*materialProperty(collectorCycle.fluid.heatCapacityTable,collectorCycle.inletTemperature)*Trise;
                
                
                % save some results
                systemInOut(k,1) = w;
                systemInOut(k,2) = f;
                systemInOut(k,3) = receiver.absorber.diameter;
                systemInOut(k,4) = receiver.sleeve.diameter;
                systemInOut(k,5) = thermalGain;
                systemInOut(k,6) = collectorCycle.outletTemperature;
                systemInOut(k,7) = TotalCost;
                systemInOut(k,8) = receiver.absorber.thickness;
                systemInOut(k,9) = receiver.sleeve.thickness;
                disp([num2str(TotalCost/thermalGain),'Rs/Watt']);
                k = k+1;
            end
        end
    end
end

save(optiData,'systemInOut');

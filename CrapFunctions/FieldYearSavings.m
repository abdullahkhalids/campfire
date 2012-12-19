function [Savings EnergySaved] = FieldYearSavings(field,simulation,location,trough,receiver,sun,collectorCycle,atmosphere,alternateFuel)
%FIELDYEARSAVINGS Gives the year long savings for a particular field +
%trough combination. This involves a daily number and then a monthly
%number.

Savings = 0;
EnergySaved = 0;
% for the given months, compute the savings
for month = field.performanceMonths;
    location.date = [15 month];
    for hour = field.performanceHours
        location.time = [hour 0];
        FinalTemperature = FieldPerformance(field,simulation,location,trough,receiver,sun,collectorCycle,atmosphere);

        [S E] = FieldInstantSavings(FinalTemperature,field,collectorCycle,alternateFuel);
        Savings = S+Savings;
        EnergySaved = EnergySaved+E;
    end
    
end


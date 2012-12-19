function [YearFieldEnergy YearBoilerEnergy,simulation,sun,atmosphere,trough,receiver,collectorCycle,field] = PlantYearEnergies(field,simulation,location,trough,receiver,sun,collectorCycle,atmosphere,alternateFuel)
%FIELDYEARSAVINGS Gives the year long savings for a particular field +
%trough combination. This involves a daily number and then a monthly
%number.

YearBoilerEnergy = 0;
YearFieldEnergy = 0;
% for the given months, compute the savings
for month = field.performanceMonths;
    location.date = [15 month];
    % for a given hour of the day
    DayFieldEnergy = 0;
    DayBoilerEnergy = 0;
    for hour = field.performanceHours
        location.time = [hour 0];
        [FinalTemperature,~,simulation,sun,atmosphere,trough,receiver,collectorCycle,field] = FieldPerformance(field,simulation,location,trough,receiver,sun,collectorCycle,atmosphere);
        
        [FE,BE] = FieldHourEnergies(FinalTemperature,field,collectorCycle,alternateFuel);
        
        DayFieldEnergy = DayFieldEnergy + FE*field.representativeHours*3600;
        DayBoilerEnergy = DayBoilerEnergy + BE*field.representativeHours*3600;

    end
        % compute the month saving by accounting for days of month
        YearBoilerEnergy = YearBoilerEnergy + DayBoilerEnergy*field.representativeMonths*30.4;
        YearFieldEnergy = YearFieldEnergy+ DayFieldEnergy*field.representativeMonths*30.4;
end


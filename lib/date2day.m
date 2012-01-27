function dayOfYear = date2day(day,month)
%Converts a date into a the day of year counting January 1 as 1;

DaysInMonths = [31 28 31 30 31 30 31 31 30 31 30 31];

dayOfYear = day + sum(DaysInMonths(1:month-1));


end


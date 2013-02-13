function intensitiesOut = ExpandIntensities(intensitiesIn,base)
%Given a set of intensites, expands them out using the percentages given in
%base.

n = length(base);
fun = @(x)repmat(x,1,n).*base;
intensitiesOut = expand(intensitiesIn,fun);

end


function [TotalCost, individualCosts] = ComputeCosts(costTable,varargin)
%COMPUTECOSTS Given a set of objects, computes the total cost and
%individual costs.

n = nargin;

% Compute individual costs
individualCosts = zeros(n-1,1);
for i=1:n-1
    individualCosts(i) = componentCosts(varargin{i},costTable);
end

TotalCost = sum(individualCosts);

end

function cost = componentCosts(component,costTable)
% Compute the cost of an individual component

cost = 0;

% Make sure input is a struct
if ~isstruct(component)
    error('Not a proper component');
end

% If there is a material field, then compute cost
if isfield(component,'type')
    cost = getCost(component,costTable);
end

% Recurse and find more components
fields = fieldnames(component);

for j=1:length(fields)
    if isstruct(component.(fields{j})) && isfield(component.(fields{j}),'type')
        cost = getCost(component.(fields{j}),costTable) + cost;
    end
end

end


function cost = getCost(component,costTable)
% Get the cost of a component which is confirmed to be a correct component

type = component.('type');

properties = fieldnames(costTable.(type));

% remove the cost column
materialProperties = removeCell(properties,'cost');


% Make sure component has all required properties
if ~hasProperties(component,materialProperties)
    error('A component does not have all required properties');
end

% Remove properties that don't need to be matched
exactMaterialProperties = materialProperties;
if ~strcmp(costTable.structure.(type),'')
    nonexactPropertiesList = textscan(costTable.structure.(type),'%s');
    nonexactPropertiesList = nonexactPropertiesList{1};
    for k=1:length(nonexactPropertiesList)
        exactMaterialProperties = removeCell(exactMaterialProperties,nonexactPropertiesList{k});
    end
end


% Find the corresponding entry in the cost table
for k=1:length(costTable.(type))
    if matchesCostEntry(component,costTable.(type)(k),exactMaterialProperties)
        % found a match. Compute number of units and multiply by cost
        unitCost = costTable.(type)(k).cost;
        numberUnits = 1;
        for i=1:length(nonexactPropertiesList)
            %             factor = ceil(component.(nonexactPropertiesList{i})/costTable.(type)(k).(nonexactPropertiesList{i}));
            factor = component.(nonexactPropertiesList{i})/costTable.(type)(k).(nonexactPropertiesList{i});            
            numberUnits = numberUnits*factor;
        end
        cost = unitCost*numberUnits;
        return;
    end
end

error('Could not find a cost entry for a component');

end

function check = hasProperties(component,properties)
% Makes sure that the component has all the required properties

check = true;
for k=1:length(properties);
    if ~isfield(component,properties{k})
        check = false;
    end
end

end

function check = matchesCostEntry(component,entry,materialProperties)
% Checks if the properties of a component matches those in the entry,
% except cost of course.

check = true;
for i=1:length(materialProperties)
    if ischar(component.(materialProperties{i}))
        if ~strcmp(component.(materialProperties{i}),entry.(materialProperties{i}))
            check = false;
            return
        end
    else
        if component.(materialProperties{i}) ~= entry.(materialProperties{i})
            check = false;
            return;
        end
    end
end

end

function Ccropped = removeCell(C,contents)
% Given a linear cell and a contents, removes matching cells from the cell.

m = length(C);
Ccropped = cell(m-1,1);
p = 1;
for k=1:m
    if ~strcmp(C(k),contents)
        Ccropped{p} = C{k};
        p = p+1;
    end
end

end


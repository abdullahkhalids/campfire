function TotalCost = FieldCost(field,trough,receiver,costTable)
%FIELDCOST Total cost of field

TroughCost = ComputeCosts(costTable,trough,receiver);
TroughCost = TroughCost + 3000;

TotalCost = field.nTroughs*TroughCost+50000;

end


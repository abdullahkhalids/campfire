function fieldValue = setValueStructField(S,fieldName,defaultValue)
%SETVALUE This sets a value of a parameter to default, unless it's value is
%already set. It also sets default value if field value is 'default'.
% S is a struct.
% fieldName is a quoted fieldname.
% defaultValue is the default value of the function

if ~isfield(S,fieldName) || strcmp(S.(fieldName),'default')
    fieldValue = defaultValue;
else
    fieldValue = S.(fieldName);
end
    


end


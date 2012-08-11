function sout = mergeStructs(S1,S2)
%MERGESTRUCTS Merges structs S1 and S2, with precedance by S1.
% Code stolen from 
% http://stackoverflow.com/questions/38645/what-are-some-efficient-ways-to-combine-two-structures-in-matlab
sout = S2;
for f = fieldnames(S1)'
    sout.(f{1}) = S1.(f{1});
end
end

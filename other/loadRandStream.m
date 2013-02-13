function loadRandStream(randCheck,randStreamName)
%LOADRANDSTREAM Loads a randstream as per needs

if ~randCheck
    %reset random number stream
    defaultStream = RandStream.getGlobalStream;
    load(randStreamName);
    defaultStream.State = savedState;
end

end


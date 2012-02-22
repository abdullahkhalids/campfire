%rand stream

%defaultStream = RandStream.getDefaultStream;
%savedState2 = defaultStream.State;
load('Z:\matlab\solar\randstream');
defaultStream.State = savedState;
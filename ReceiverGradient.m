function gradients = ReceiverGradient(receiver)
%Computes the gradients of the receiver making sure it's a closed surface.
%There are errors on the edges

gradients = SurfaceErrors([receiver.coordinates(:,end) receiver.coordinates receiver.coordinates(:,1)],receiver.surfaceStdDev);

end


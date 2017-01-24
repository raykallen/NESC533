function [outputatT1, outputatT2] = variable_threshold(inputvector, weightvector)
postexcitation = postexcite(inputvector, weightvector);
outputatT1 = spikegen(.9595, postexcitation);
if outputatT1 == 1
    outputatT2 = spikegen(.9922, postexcitation);
else
    outputatT2 = spikegen(.860, postexcitation);
end

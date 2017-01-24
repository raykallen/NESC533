function wMatrix = AssignSparseAsymmetricWeights(neurons, ...
number_of_connections)


wMatrix = zeros(number_of_connections, neurons);
for postsynaptic = 1:neurons
connections = zeros(neurons,1);
%Pretend that we’re already connected to ourselves, to
%prevent it from happening!
connections(postsynaptic, 1) = 1;
syn_count = 0;
while (syn_count < number_of_connections)
presynaptic = ceil(neurons * rand);
if (connections(presynaptic,1)==0)
connections(presynaptic,1)=1;
syn_count = syn_count + 1;
wMatrix(syn_count,postsynaptic) = presynaptic;
end
end
end

realwMatrix = zeros(neurons, neurons);
for i= 1:neurons
    for j = 1:number_of_connections
        if i == wMatrix(j,i)
            realwMatrix(i,j) = 0;
        else
            connect1 = wMatrix(j,i);
            connect2 = i;
            realwMatrix(connect1, connect2) = 1 + .001*rand(1,1);
        end
    end
end

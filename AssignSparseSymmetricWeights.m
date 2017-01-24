function AssignSparseSymmetricWeights(neurons, ...
number_of_connections)
clc
rand('state', 245);
neurons = 75;
number_of_connections = 20;
synapseA = 0;
synapseB = 0;
wMatrix = zeros(number_of_connections, neurons);
for postsynaptic = 1:neurons
connections = zeros(neurons,1);
%Pretend that we’re already connected to ourselves, to
%prevent it from happening!
connections(postsynaptic, 1) = 1;
%Find all the connections that were made to this neuron
%from previous neurons
syn_count = 0;
for i = 1:number_of_connections
if wMatrix(i,postsynaptic) == 0
break;
end
syn_count = i;
connections(wMatrix(syn_count,postsynaptic), 1) = 1;
end
%Now attempt to assign connections from remaining
%neurons (previous neurons are already full)
attempts = 0;
remainingneurons = neurons - postsynaptic;
while (syn_count < number_of_connections)
presynaptic = postsynaptic + ...
ceil(remainingneurons * rand);
attempts = attempts + 1;
if (attempts > neurons)
%Give up if we’ve tried too many times
break;
end
%If there is not already a connection to this
%neuron...
if connections(presynaptic,1) == 0
nextpresyn = NextSynapse(wMatrix, ...
presynaptic, number_of_connections);
%If this neuron still has a connection
%available...
if nextpresyn > 0
%Assign a connection from here to there
%and from there to here
connections(presynaptic, 1)=1;
syn_count = syn_count + 1;
wMatrix(syn_count,postsynaptic) = presynaptic;
wMatrix(nextpresyn,presynaptic) = postsynaptic;
end
end
end
%If we enter the next loop, there were no available
%connections to be found from the remaining neurons.
%Time to be creative!
while syn_count < number_of_connections
%We only need one more connection (therefore, we
%can not be the last neuron!)
if (syn_count == number_of_connections - 1)
%Find a neuron that is after the current one
sacrificer = postsynaptic + ...
ceil(remainingneurons * rand);
lastsacsyn = NextSynapse(wMatrix, ...
sacrificer, number_of_connections) - 1;
if (lastsacsyn == -1)
lastsacsyn = number_of_connections;
end
%Find a connection that is not shared by the
%current neuron
for synapse = 1:number_of_connections
if (connections(wMatrix(synapse, ...
sacrificer), 1) == 0)
sacrificerpre = wMatrix(synapse, ...
sacrificer);
if synapse < lastsacsyn
wMatrix(synapse, sacrificer) = ...
wMatrix(lastsacsyn, sacrificer);
end
%Cut off the synapse (it’ll grow back)
wMatrix(lastsacsyn, sacrificer) = 0;
break;
end
end
%Graft that synapse onto the current neuron
connections(sacrificerpre, 1) = 1;
syn_count = syn_count + 1;
wMatrix(syn_count,postsynaptic) = ...
sacrificerpre;
%Fix the symmetric connection to the sacrificer
%and replace it
for findsac=1:number_of_connections
if wMatrix(findsac, sacrificerpre) == ...
sacrificer
wMatrix(findsac, sacrificerpre) = ...
postsynaptic;
break;
end
end
else
%Choose a neuron from anywhere
neuronA = ceil(neurons * rand);
if connections(neuronA,1) == 0
%Find a neuron that this neuron is connected to
%that we’re not connected to
for synapse = 1:number_of_connections
neuronB = ...
wMatrix(synapse,neuronA);
if (connections(neuronB,1) == 0)
synapseA = synapse;
break;
end
end
for synapse = 1:number_of_connections
if (wMatrix(synapse,neuronB) == ...
neuronA)
synapseB = synapse;
break;
end
end
end
%a->b and b->a, but c is left out in the cold!
%try a->c, c->a and b->c, c->b
%This requires making TWO new connections for
%our new neuron
connections(neuronA, 1) = 1;
syn_count = syn_count + 1;
wMatrix(syn_count, postsynaptic) = ...
neuronA;
wMatrix(synapseA, neuronA) = ...
postsynaptic;
connections(neuronB, 1) = 1;
syn_count = syn_count + 1;
wMatrix(syn_count, postsynaptic) = ...
neuronB;
wMatrix(synapseB, neuronB) = ...
postsynaptic;
end
end
end

bin_matrix = zeros(neurons);


% for i = 1:neurons-1
%     for j = i:neurons
%        if wMatrix(i,j) = 
%             bin_matrix(i,j) = 1;
%             bin_matrix(j,i) = 1;
%        end
%     end
% end

for i = 1:neurons
    for j = 1:number_of_connections
        if i == wMatrix(j,i)
            bin_matrix(i,j) = 0;
            bin_matrix(j,i) = 0;
        else 
            connect1=wMatrix(j,i);
            connect2=i;
            bin_matrix(connect1,connect2)=1+rand(1)*.001;
            bin_matrix(connect2,connect1)=1+rand(1)*.001;
        end    
   
    end
end
bin_matrix;
activeNeurons=zeros(1,neurons);

for i=1:neurons
    if rand(1)>.9
        activeNeurons(i)=1;
    else
        activeNeurons(i)=0;
    end
end

time = 100;
for i = 1:time
newActiveNeurons=activeNeurons*bin_matrix;%storing activity in columns
%size(newActiveNeurons)
activeNeurons = thresholdsort(newActiveNeurons, 20);
size(activeNeurons);
save(:,i)=activeNeurons';
end
spy(save(:,:))
figure;
newSave=(save'*save)/20;
simpcol(newSave)


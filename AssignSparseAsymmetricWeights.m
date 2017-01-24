function wMatrix = AssignSparseAsymmetricWeights(neurons, ...
number_of_connections)

clc
rand('state', 2345);
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

bin_matrix=zeros(neurons);

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
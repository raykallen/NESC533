function [array_of_firings] = one_neuron_network(weights,inputs,threshold)
%this simulates the response of one post-synaptic neuron
%'weights' is a vector representing the the number of presynatpic inputs and their respective weights
%the number of presynaptic inputs will be determined by the number of rows
%in the 'weights' vector
% 'inputs' need to be column vectors
[num_input_neurons, colm_weights] = size(weights);
[num_dimensions, num_inputs] = size(inputs);
if colm_weights ~= 1
    beep
    disp('Weight vector must be one column')
else
    for i= 1: num_inputs
    columnvector(:,i) = inputs(:,i);
    array_of_excitations(:,i) = postexcite(columnvector(:,i),weights);
    end
    for i= 1: num_inputs
        array_of_firings(1,i)= array_of_excitations(1,i);
        array_of_firings(1,i) = spikegen(threshold, (array_of_excitations(1,i)));
    end
    
end
end

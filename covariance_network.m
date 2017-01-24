function [movingweights]= covariance_network(inputs, initialweights)
%inputs and initial weights must be in vector form where the dimensions of
%the inputs is equal to the dimensions of the weights
%change in weight is equal to epsilon*postexcite(new
%input-weight-Ave(input))
[input_dimensions, num_inputs] = size(inputs);
[weight_dimensions, colm_weights] = size(initialweights);
movingweights = initialweights;
if colm_weights ~= 1
    beep
    disp('Weight vector must be one column')
else if input_dimensions ~= weight_dimensions
        beep
        disp('Input dimensions must be equal to weight dimensions')
    else
        for i= 1: num_inputs
            for j = 1: input_dimensions
                y = postexcite(inputs(:,i), movingweights(:,i));
                movingweights(j, i+1) = movingweights(j, i) + (y*(inputs(j,i)-movingweights(j,i)-mean(inputs(j,1:i))));
            end
        end
    end
end


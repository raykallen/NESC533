function [movingweights, output]= binary_network(inputs, initialweights, epsilon, threshold)
%inputs and initial weights must be in vector form where the dimensions of
%the inputs is equal to the dimensions of the weights
%change in weight is equal to epsilon*(new input-weight), making all inputs
%above threshold equally weighted
[input_dimensions, num_inputs] = size(inputs);
[weight_dimensions, colm_weights] = size(initialweights);
output= [0];
movingweights = initialweights;
if colm_weights ~= 1
    beep
    disp('Weight vector must be one column')
else if input_dimensions ~= weight_dimensions
        beep
        disp('Input dimensions must be equal to weight dimensions')
    else
        for i= 1: num_inputs
            [row, lengthw] = size(movingweights);
            output(1,i) = postexcite(inputs(:,i), movingweights(:,lengthw));
            if output(1,i) <= threshold
                   output(1,i)= 0;
            end
            if output(1,i) > threshold
                for j = 1: input_dimensions
                    movingweights(j, lengthw+1) = movingweights(j, lengthw) + (epsilon*(inputs(j,i)-movingweights(j,lengthw)));
                    output(1,i)=1;
                end
            end
        end
    end
end
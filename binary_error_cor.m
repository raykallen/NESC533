function [output, thresholds]= binary_error_cor(weights, inputs, desiredoutput, initial_thresholds)
%for lab 4.5.3 uses binary error correction to change threshold and fixed
%weights
rate_constant = .01;
[num_inputs, inputdimensions]= size(inputs);
[neurondimensions, num_neurons]=size(weights);
thresholds = initial_thresholds;
for in= 1:num_inputs
    for i= 1:num_neurons
        excitation(in,i)= inputs(in,:)*weights(:,i);
        if excitation(in,i)> thresholds(in,i)
            output(in,i)=1;
        else
            output(in,i)=0;
        end
    end
    for i= 1:num_neurons
        error = output(in,i)-desiredoutput(in,1);
        if error == 0
            delta_T =0;
        else delta_T = rate_constant*(thresholds(in,i)-excitation(in,i));
        end
        thresholds(in+1,i) = thresholds(in,i)- delta_T;
    end
end

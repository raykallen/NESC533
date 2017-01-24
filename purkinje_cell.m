function [output, weight]= purkinje_cell(toneinputs, puffinputs)
%for lab 4.6 -cell predicts when puff will occur from tone and error
%correction
rate_constant = .03;
randseed(-1);
weight = rand(1,1); %random initial weight
threshold = .6;
[num_inputs, inputdimensions]= size(toneinputs);
for in= 1:num_inputs
    excitation(in,1)= toneinputs(in,1)*weight(in,1);
    if excitation(in,1)> threshold
            output(in,1)=1;
        else
            output(in,1)=0;
        end
    error = output(in,1)-puffinputs(in,1);
    delta_w= rate_constant* toneinputs(in,1)* error;
    weight(in+1,1)= weight(in,1)- delta_w;
end

function [weightsx1, weightsx2, output]= self_supervised_network(inputs, startx1, startx2, epsilon, threshold)
%weights as output are given for each input, not just final weights
weightsx1(1,1) = [startx1];
weightsx2(1,1)= [startx2];
output= [0];
[dimensions, num_inputs] = size(inputs);
for i= 1:num_inputs
    [row, lengthw] = size(weightsx1);
    output(1,i) = postexcite(inputs(1:2, i), [weightsx1(1, lengthw);weightsx2(1, lengthw)]);
    if output(1,i) <= threshold
        output(1,i)= 0;
    end
    if output(1,i) > threshold
        [x1, x2] = vector_moving_avg([weightsx1(1, lengthw);weightsx2(1,lengthw)], inputs(1:2, i), epsilon);
        weightsx1(1, lengthw + 1) = x1;
        weightsx2(1, lengthw + 1) = x2;
    end
end

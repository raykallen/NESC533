function [weights1, weights2, weights3]= supervised_network_training(input, epsilon)
%shows the change in weights with inputs, must have category stated as 3rd
%row of input
weights1 = [0;0];
weights2 = [0;0];
weights3 = [0;0]; %all weights are initialized to zero
[dimensions, num_inputs] = size(input);
for i= 1:num_inputs
    if input(3, i) == 1
        [row, length1] = size(weights1);
        [x1, x2] = vector_moving_avg(weights1(1:2, length1), input(1:2, i), epsilon);
        weights1(1, length1 + 1) = x1;
        weights1(2, length1 + 1) = x2;
    elseif input(3, i) == 2
        [row, length2] = size(weights2);
        [x1, x2] = vector_moving_avg(weights2(1:2, length2), input(1:2, i), epsilon);
        weights2(1, length2 + 1) = x1;
        weights2(2, length2 + 1) = x2;
    elseif input(3, i) == 3
        [row, length3] = size(weights3);
        [x1, x2] = vector_moving_avg(weights3(1:2, length3), input(1:2, i), epsilon);
        weights3(1, length3 + 1) = x1;
        weights3(2, length3 + 1) = x2;
    else disp('Category number not found')
    end
end
    
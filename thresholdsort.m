function new = thresholdsort(input, firetot)

new = zeros(size(input));
[input_s, position] = sort(input, 'descend');


for i = 1:firetot
    new(position(i)) = 1;
end
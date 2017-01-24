function [good_weight] = select_connection(desired_connection, avaliable_connections)

if desired_connection == 1;
    [sorted, index] = sort(avaliable_connections, 'descend');
else
    [sorted, index] = sort(avaliable_connections, 'ascend');
end
[end_of_one] = find_end(sorted, desired_connection, 1);
if end_of_one == 50
    good_weight = ceil(rand(1,1)*49);
else
    good_weight = index(ceil(rand(1,1)*(end_of_one)),1);
end

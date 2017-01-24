function [end_of_one]= find_end(sorted_list, desired, check_num)
if check_num == 49, end_of_one = 50;
else
if sorted_list(check_num,1) ~= desired
    end_of_one = check_num;
    else end_of_one = find_end(sorted_list, desired, (check_num + 1));
end
end

function [mutual_info, string_entropy] = mutual_information(pre, post)
%pre is alphabet code, post is output_code
[inputs, neurons] = size(post);
[B,I,uniqueindex]= unique(post, 'rows');
total_outcome_prob = zeros(1,26);
letter_prob = [.1,.02,.02,.02,.1,.02,.02,.02,.1,.02,.02,(1/30),(1/30),(1/30),.1,.02,.02,(1/30),(1/30),(1/30),.1,.02,.02,.02,.02,.02];
for outcomes = 1:26
    for index = 1:26
        if (uniqueindex(index, 1) == outcomes)
            total_outcome_prob(1,outcomes) = (total_outcome_prob(1,outcomes)+letter_prob(1,index));
        end
    end
end


for i = 1:26
    indexnum = uniqueindex(i,1);
    joint_prob = letter_prob(1,i)/(total_outcome_prob(1, indexnum));
    prob_of_y = total_outcome_prob(1, indexnum);
    mut_info(1,i)= joint_prob*(log2(joint_prob/((prob_of_y)*letter_prob(1,i))));
end
mutual_info = sum(mut_info);
%string entropy
string_entropy = 0;
for i = 1:26
    if (total_outcome_prob(1,i) ~= 0)
        string_entropy = string_entropy + (-(total_outcome_prob(1,i)*log2(total_outcome_prob(1,i))));
    end
end


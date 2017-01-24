function [avg_stat_dep, bit_entropy] = statistical_dep(inputs)
%for binary inputs only
[trials, bits] = size(inputs);
count11 = zeros(bits, bits);
count00 = zeros(bits, bits);
count01 = zeros(bits, bits);
count10 = zeros(bits, bits);
%calculate bit probabilities
prob1 = sum(inputs)/trials;
prob0 = 1-prob1;

%calculate joint probabilities/ number of times two bits are both 1 or both
%0-  count1 is a square matrix
for j = 1:trials
    for i = 1: bits
        for w = 1:bits
            if i~= w
                if (inputs(j,w) == 1 && inputs(j,i)==1)
                    count11(w,i)= (count11(w,i)+ 1);
                else if (inputs(j,w)==0 && inputs(j,i)== 0)
                        count00(w,i) = (count00(w,i)+1);
                    else if (inputs(j,w)==0 && inputs(j,i)== 1)
                            count01(w,i) = (count01(w,i)+1);
                            else if (inputs(j,w)==1 && inputs(j,i)== 0)
                            count10(w,i) = (count10(w,i)+1);
                                end
                        end
                    end
                end
            end
        end
    end
end

jointp11 = count11/trials;
jointp00 = count00/trials;
jointp01 = count01/trials;
jointp10 = count10/trials;
%calculate stat dependence, it's symmetrical so you only need to half the
%matrix
for i = 1:bits
    for w = 1:bits
        if (i == w || i > w)
            stat_dep11(w, i) = 0;
            stat_dep00(w, i) = 0;
            stat_dep10(w, i) = 0;
            stat_dep01(w, i) = 0;
        else
            if ((jointp11(w,i)== 0) ||((prob1(1,w)*prob1(1,i)) == 0))
                stat_dep11(w,i) = 0;
            else
                stat_dep11(w,i)= (jointp11(w,i)*log2((jointp11(w,i)/(prob1(1,w)*prob1(1,i)))));
            end
            if ((jointp00(w,i)==0) || ((prob0(1,w)*prob0(1,i)) == 0))
                stat_dep00(w,i) = 0;
            else
                stat_dep00(w,i)= (jointp00(w,i)*log2((jointp00(w,i)/(prob0(1,w)*prob0(1,i)))));
            end
            if ((jointp01(w,i)==0) || ((prob0(1,w)*prob1(1,i)) == 0))
                stat_dep01(w,i) = 0;
            else
                stat_dep01(w,i)= (jointp01(w,i)*log2((jointp01(w,i)/(prob0(1,w)*prob1(1,i)))));
            end
            if ((jointp10(w,i)==0) ||((prob1(1,w)*prob0(1,i)) == 0))
                stat_dep10(w,i) = 0;
            else
                stat_dep10(w,i)= (jointp10(w,i)*log2((jointp10(w,i)/(prob1(1,w)*prob0(1,i)))));
            end
        end
    end
end

%calculate average statistical dependence overall the bits
avg_stat_dep = sum((sum(stat_dep11))+(sum(stat_dep00))+(sum(stat_dep10))+(sum(stat_dep01)));

%bit entropy
bitent = 0;
for i = 1:bits
prob = sum(inputs(:,i))/trials;
if (prob == 0 || prob ==1)
    bitent(1,i) = 0;
else
    bitent(1,i) = -prob*log2(prob)-(1-prob)*log2(1-prob);
end
end

bit_entropy = sum(bitent);

        
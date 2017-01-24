function [movingavgs]= moving_avg(data, epsilon)
%calculates the moving average based on the data, which must be in either a
%row or column array, and the rate constant(epsilon)
[m,n]= size(data);
movingavgs = [0];% this is the initial value of the moving averager
if m == 1,
    for i= 1:n
    movingavgs(1,i+1) = movingavgs(1, i) + epsilon * (data(1,i) - movingavgs(1,i));
    end
elseif n == 1,
    for i= 1:m
    movingavgs(i+1,1) = movingavgs(i, 1) + epsilon * (data(i,1) - movingavgs(i,1));
    end
%error detection
else disp('Samples must be all in one column or all in one row.')
end
end

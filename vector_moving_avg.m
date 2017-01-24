function [newmovingavgx1, newmovingavgx2]= vector_moving_avg(currentvec, newdata, epsilon)
newmovingavgx1 = currentvec(1,1) + epsilon*(newdata(1,1)-currentvec(1,1));
newmovingavgx2 = currentvec(2,1) + epsilon*(newdata(2,1)-currentvec(2,1));
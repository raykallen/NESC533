function [histdata] = output_for_hist(firingat2times)
for i = 1:1000
outputpair(:, i) = firingat2times(:,i);
if outputpair(:,i) == [0;0]
   histdata(1, i) = 5;
elseif outputpair(:, i) == [0;1]
   histdata(1, i) = 10;
elseif outputpair (:, i) == [1;0]
   histdata(1, i) = 15;
elseif outputpair (:, i) == [1;1]
   histdata(1, i) = 20;
end
end

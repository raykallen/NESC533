function out = simpcol(M)
%simpcol (M) makes a pcolor of M and adds an extra row and column padded
%with zeros to the end of the matrix to account for pcolor chopping off
%the last row and column of your matrix in the display.
[row, col] = size(M);
M = [M, zeros(row,1); zeros(1,col+1)];
M = 1 - M;
pcolor(M); %to learn more about pcolor just ask MatLab
%>> help pcolor
colormap('gray'); %this prints the graph in grayscale. 'default'
%would give you color.
v = [0 1]; %the range of values colored--0 is be white and %1
% is black.
caxis(v);
colorbar; %adds a key to the graph giving numerical values
% to the shades.
% shading faceted;
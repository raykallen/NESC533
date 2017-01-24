function [xdata_arc_points, ydata_arc_points]= rand_points_on_arc(xcenter, ycenter, start_radians, end_radians, num_points)
%num_point is the number of random
%points you wish to generate, start_radians must be the smaller of the
%two radians
arc_length = end_radians - start_radians;
points_adjusted_for_radians = (rand(1, num_points)*(arc_length))+ start_radians;
xdata_arc_points = ((cos(points_adjusted_for_radians))+ xcenter);
ydata_arc_points = ((sin(points_adjusted_for_radians))+ ycenter);

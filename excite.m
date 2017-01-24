function output = excite(input,B)

output = input*B; 

output = output + .01*(rand(size(input*B,1))-.5);
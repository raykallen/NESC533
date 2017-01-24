function [vec_means, mnmn, vrmn, stdmn] = repeated_samples(samp_size)
%this function creates 1000 means from a uniform random generator
%set seed before using this function

vec_means = mean(rand(samp_size, 1000));
[mnmn, vrmn, stdmn] = stats(vec_means);

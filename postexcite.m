 function [post_excitation] = postexcite(inputvector,weightvector)
%input vector and weight vector must use column vectors of the same
%dimension
[num_rows_weightvec,num_colms_weightvec] = size(weightvector); 
truth = checkfor_col_vector(inputvector, num_rows_weightvec, 'postexcite');
if truth == 1
    post_excitation = inputvector'* weightvector;
end

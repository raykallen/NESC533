function [truth] = checkfor_col_vector(input,desired_dim, func_name)
%function returns the binary integer truth
%truth is 1 if true or set to zero if false
%desired_dim must be a positive scalar
errorfound = ['Function checkfor_col_vector has detected an error in ', func_name];
truth = 1;
[numb_rows, numb_cols] = size(input);
if numb_cols ~= 1
    beep
    truth = 0;
    disp(errorfound)
    disp('Not a column vector')
elseif numb_rows ~= desired_dim %must be a column vector to get here
    beep
    truth = 0;
    disp(errorfound)
    disp('Column vector is not desired length')
end
end

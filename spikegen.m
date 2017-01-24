function [neuron_output] = spikegen(threshold, excitation)
           %threshold and excitation must be scalars

           %error detection
           if length(excitation) > 1
              disp('function spikegen takes a scalar not a vector or matrix')
           end

           %threshold function
           if excitation < threshold
              neuron_output = 0;
           else
              neuron_output = 1;
           end

function [threshold, output_code, w, q, output]= alphabet_network5(input, Alphabet)
%for synaptic modification in lab 5.3
%network parameters
input_size=1000;
number_in_neurons=49;
number_out_neurons=10;
number_letters=26;
cycles=3;
gamma =.001; %rate constant for threshold modification
desiredActivity = .1;	%desired activity level of output neurons
inhib_constant = .05; %inhibitory weights
hebbian_rate = .0001; %excitatory weights
anti_hebbian_rate = .01;
%set up threshold vector- initial threshold is 2
for i=1:number_out_neurons
    threshold(1,i)=2;
end

randseed(-1);


%training
%initialize hebbian weights
q = floor(rand(number_in_neurons,number_out_neurons)+ 1);%excitatory weights
w = zeros(number_out_neurons, number_out_neurons); %negative inhibitory weights

for t=1:cycles
    for in= 1:input_size
        inhibition =sum(input(in,:))*inhib_constant; %feedfoward inhib
        excitation(1,1:number_out_neurons)=input(in,:)/inhibition*q;
        %inhibition calculation
        for i= 1:number_out_neurons
            inhibitcalc(1,i)= excitation(1,:)*w(:,i);
        end
        inhibexcite(1,:)= excitation(1,:)+ inhibitcalc(1,:);
        %threshold
        for i = 1:number_out_neurons
            if inhibexcite(1,i)> threshold
                output_Train((t-1)*input_size + in,i) = 1;
            else
                output_Train((t-1)*input_size + in,i) = 0;
            end
        end
% %         %modify inhibitory weights- w
        for i= 1:number_out_neurons
            for j= 1:number_out_neurons
                delta_w= -anti_hebbian_rate*(output_Train((t-1)*input_size + in,i)*output_Train((t-1)*input_size + in,j)- desiredActivity^2); 
                w(i,j) = w(i,j) + delta_w;
                if (i==j || w(i,j) > 0)
                    w(i,j) = 0;
                end
            end
        end
        %modify excitatory weights - q
        for i=1:number_out_neurons
            for j=1:number_in_neurons
                if (q(j,i)== 0)
                    q(j,i)=0;
                else
                    delta_q = hebbian_rate *inhibexcite(1,i)* (input(in,j) - q(j,i));
                    q(j,i) = q(j,i) + delta_q;
                end
            end
        end
        %modify thresholds 
        for i=1:number_out_neurons
            deltaT(1,i)=gamma*(output_Train((t-1)*input_size + in,i) - desiredActivity);
            threshold((t-1)*input_size + in + 1,i)=threshold((t-1)* input_size + in,i)+deltaT(1,i);
        end
    end
end

% %testing = output
for t=1:input_size
        inhibition =sum(input(t,:))*inhib_constant; 
        excitation(1,1:number_out_neurons)=input(t,:)/inhibition*q;
	for i=1:number_out_neurons
            %inhibition calculation
         for j=1:number_out_neurons
                inhibitcalc(1,j)= excitation(1,j)*w(i,j);
         end
         total_inhibition= sum(inhibitcalc(1,:));
         excitation(1,i)= excitation(1,i)+ total_inhibition; 
    end
    for i=1:number_out_neurons
        [final_thresh, colms] = size(threshold);
        if excitation(1,i)> threshold(final_thresh, i)  
            output(t,i) = 1;
        else output(t,i) = 0;
        end
    end
end
    
%output_code = output for alphabet		
for t=1:26
        inhibition =sum(Alphabet(t,:))*inhib_constant; 
        excitation(1,1:number_out_neurons)=Alphabet(t,:)/inhibition*q;
        for i= 1:number_out_neurons
            %inhibition calculation
            inhibitcalc(1,i)= excitation(1,:)*w(:,i);
        end
        inhibexcite(1,:)= excitation(1,:)+ inhibitcalc(1,:);
        for i = 1:number_out_neurons
            [final_thresh, colms] = size(threshold);
         if inhibexcite(1,i)> threshold(final_thresh, i)  
             output_code(t,i) = 1;
         else output_code(t,i) = 0;
         end
        end
    end
end

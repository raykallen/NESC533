function [output_code, q, outputs]= alphabet_synaptogenesis(input, Alphabet)
%network parameters
input_size=1000;
number_in_neurons=49;
number_out_neurons=10;
number_letters=26;
cycles=100;
inhib_constant = .08; %feedfoward inhib constant
hebbian_rate = .01; %excitatory weights
threshold= .9;

randseed(-1);
%create initial connectivity matrix (connectivity is 5%)
ConnMatrix=floor(rand(number_in_neurons,number_out_neurons)+ .05);

%training
%initialize hebbian weights as Conn Matrix
q = ConnMatrix; %excitatory weights
for t=1:cycles
    for in= 1:1000
        inhibition =sum(input(in,:))*inhib_constant; %feedfoward inhib
        excitation(1,1:number_out_neurons)=input(in,:)/inhibition*q;
        %modify excitatory weights - q
        for i=1:number_out_neurons
            for j=1:number_in_neurons
                if q(j,i) == 0, delta_q = 0;
                else
                    delta_q = hebbian_rate *excitation(1,i)* (input(in,j) - q(j,i));
                end
                q(j,i) = q(j,i) + delta_q;
            end
        end
    end
    for in = 1:500
        inhibition =sum(input(in,:))*inhib_constant; %feedfoward inhib
        excitation(1,1:number_out_neurons)=input(in,:)/inhibition*q;
        for i = 1:number_out_neurons
            if excitation(1,i)> threshold
                big_activity(in,i) = 1;
            else
                big_activity(in,i) = 0;
            end
        end
    end
    %bigexcite(1:500,1:number_out_neurons) =  input(1:500,:)*q;
    %neuron_activity (1, 1:number_out_neurons) = sum(bigexcite);
    maxrange = .95-(.001*(t-1));
    minrange = .5 +(.001*(t-1));
    for i = 1:number_out_neurons
        if (sum(big_activity(:,i))/500) > maxrange
            [good_choice] = select_connection(1, q(:,i));
            q(good_choice,i) = 0;
        end
        if (sum(big_activity(:,i))/500) < minrange
            [good_choice] = select_connection(0, q(:,i));
            q(good_choice,i) = 1;
        end
    end
end
for t=1:26
        inhibition =sum(Alphabet(t,:))*inhib_constant; 
        excitation(1,1:number_out_neurons)=Alphabet(t,:)/inhibition*q;
        for i = 1:number_out_neurons
            if excitation(1,i)> threshold
                output_code(t,i) = 1;
            else
                output_code(t,i) = 0;
            end
        end
end
for t=1:1000
        inhibition =sum(input(t,:))*inhib_constant; 
        excitation(1,1:number_out_neurons)=input(t,:)/inhibition*q;
        for i = 1:number_out_neurons
            if excitation(1,i)> threshold
                outputs(t,i) = 1;
            else
                outputs(t,i) = 0;
            end
        end
end
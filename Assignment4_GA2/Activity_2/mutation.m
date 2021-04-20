function c = mutation(p,lb,ub)
    
    mutation_probability = 0.02;
    s = size(p);
    s = s(2);
    mutation_point = randi([1,s]);
    r = rand();
    if r<mutation_probability
        % This is interchange mutation, but because it wasn't giving good
        % results I have additionally implemeted another mutation :Gaussian
        % temp = p(1);
        %p(1) = p(2);
        %p(2) = temp;
        
        % gaussian mutation for real encoding
        p(mutation_point) = max(p(mutation_point)+0.9*(-1+(rand()*2)),lb(mutation_point));
        p(mutation_point) = min(p(mutation_point)+0.9*(-1+(rand()*2)),ub(mutation_point));
        c=p;
    else
        
        c = p;
    
    end
    

    
    
    
end
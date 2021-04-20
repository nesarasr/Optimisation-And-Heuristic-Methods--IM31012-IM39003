% CROSSOVER
function c = crossover(p1,p2)
   
    crossover_probability = 0.7;
    r = rand();
    if r<crossover_probability
        
        c1 = 0.5*(p1+p2);
        c2 = 1.5*p1-0.5*p2;
        c3 = 1.5*p2-0.5*p1;
        c = [c1;c2;c3];
        fit_ness = [fitness(c1),fitness(c2),fitness(c3)];
        [M,I] = max(fit_ness);
        c1 = c(I,:);
        fit_ness(I) = [];
        c(I,:) = [];
        [M,I] = max(fit_ness);
        c2 = c(I,:);  
    else
        c1 = p1;
        c2 = p2;
    end
    c = [c1;c2];
end
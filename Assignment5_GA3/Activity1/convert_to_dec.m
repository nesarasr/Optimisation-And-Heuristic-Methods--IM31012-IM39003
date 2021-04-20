% Convert 8-bit chromosome to 2 bit decimal vector

function c = convert_to_dec(chromosomes)
    
    dim = size(chromosomes);
    population_size = dim(1);
    
    c = [];
    for i=1:population_size
        
        x = chromosomes(i,:);
        x1 = x(1:4);
        x2 = x(5:end);
        
        x1 = bi2de(x1);
        x2 = bi2de(x2);
        c = [c;[x1 x2]];
    end
end
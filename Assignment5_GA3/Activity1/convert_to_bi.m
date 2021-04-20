% convert 2 bit decimal vector into 8-bit binary vector

function c = convert_to_bi(chromosomes)
    
    dim = size(chromosomes);
    population_size = dim(1);
    
    c = [];
    for i=1:population_size
        
        x1 = chromosomes(i,1);
        x2 = chromosomes(i,2);
        x = [de2bi(x1,4) de2bi(x2,4)];
        c = [c;x];
    end
end
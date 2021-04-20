% Mutation : Interchange

function c = mutation(p)
    
    bit_size = size(p);
    bit_size = bit_size(2);
    mutation_probability = 0.02;
    r = rand();
    if r<mutation_probability
        r1 = randi([1,bit_size]);
        r2 = randi([1,bit_size]);
        while(r1==r2)
            r1 = randi([1,bit_size]);
            r2 = randi([1,bit_size]);    
        end
        temp = p(r1);
        p(r1) = p(r2);
        p(r2) = temp;
        c = p;
    else
        c = p;
    end

end
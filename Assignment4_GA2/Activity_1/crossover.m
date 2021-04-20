% Single point crossover

function c = crossover(p1,p2)
    
    bit_size = size(p1);
    bit_size = bit_size(2);
    crossover_probability = 0.7;
    r = rand();
    if r<crossover_probability
        crossover_point = randi([2,bit_size]);
        c1 = [p1(1:crossover_point),p2(crossover_point+1:end)];
        c2 = [p2(1:crossover_point),p1(crossover_point+1:end)];
    else
        c1 = p1;
        c2 = p2;
    end
    c = [c1;c2]; %children
end
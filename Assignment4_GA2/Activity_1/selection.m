% Roulette Wheel Selection
function population_after_selection = selection(chromosomes)
       
    population_size = 10;
    r = bi2de(chromosomes);
    fitness_population = fitness(r);
    total_fitness = sum(fitness_population);
    probability_distribution = (fitness_population/total_fitness);
    cumulative_distribution  = cumsum(probability_distribution);
    
    cumulative_distribution = [0;cumulative_distribution];
    
    %generating population after roulette wheel selection
    population_after_selection = [];
    rand_generated = [];
    for i=1:population_size
        
        x = rand();
        rand_generated = [rand_generated x];
        selection_array = [];
        for j=1:population_size
            if x>cumulative_distribution(j) && x<=cumulative_distribution(j+1)
                index = j;
                break;
            end
        end
        
        population_after_selection = [population_after_selection; r(index)];
        
    end
end
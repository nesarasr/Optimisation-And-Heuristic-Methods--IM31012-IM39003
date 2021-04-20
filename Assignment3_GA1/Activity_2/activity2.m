% ACTIVITY 2 
% NAME : NESARA S R
% ROLL NO : 18IM30014

clc;
clear;

% proportionate selection
population_size = 10;

%generate initial population ( REAL ENCODED )
r = -5 + (5+5)*rand(10,2);

%compute fitness of the population

fitness_population = [];
for i=1:population_size
    fitness_population = [fitness_population fitness(r(i,:))];
end

%finding the probability of occurence of each chromosome after selection

total_fitness = sum(fitness_population);
probability_distribution = (fitness_population/total_fitness);
cumulative_distribution  = cumsum(probability_distribution);

cumulative_distribution = [0 cumulative_distribution];

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
    
    population_after_selection = [population_after_selection; r(index,:)];
    
end


%print maximum fitness of the initial population
max_fitness = max(fitness_population)
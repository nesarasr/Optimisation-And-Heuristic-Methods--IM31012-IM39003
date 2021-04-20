% ACTIVITY 1
% NAME : NESARA S R
% ROLL NO : 18IM30014

clc;
clear;

% proportionate selection
population_size = 10;

%generate initial population
r = randi([0,31],1,population_size);

chromosomes = de2bi(r);

%compute fitness of the population
fitness_population = fitness(bi2de(chromosomes));

%finding the number of times a solution from initial population will be
%present after selection ; using fitness value

average_fitness = mean(fitness_population);
population_distribution = round(fitness_population/average_fitness);


%generating population after selection
population_after_selection = [];

for i=1:population_size
    
    num_rep = population_distribution(i);
    for j=1:num_rep
        population_after_selection = [population_after_selection r(i)];
    end
    
end


%print maximum fitness of the initial population
max_fitness = max(fitness_population)
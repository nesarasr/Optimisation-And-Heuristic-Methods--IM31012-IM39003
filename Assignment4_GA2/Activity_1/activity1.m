% ACTIVITY 1
% NAME : NESARA S R
% ROLL NO : 18IM30014

clc;
clear;
% parameters
max_iterations = 50;
population_size = 10;
lb = 0;
ub = 31;

%generate initial population
r = randi([lb,ub],1,population_size);
chromosomes = de2bi(r);

%compute fitness of the population
fitness_population = fitness(bi2de(chromosomes));
[M,I] = max(fitness_population);
best_sol = r(I);
best = M;
obj = [best];

%GA 
 for i=1:max_iterations 
     chromosomes = de2bi(selection(chromosomes));
     population_after_crossover = [];
     for j=1:(population_size/2)
        r1 = randi([1,population_size]);
        r2 = randi([1,population_size]);
        while(r1==r2)
            r1 = randi([1,population_size]);
            r2 = randi([1,population_size]);
        end
        c = crossover(chromosomes(r1,:),chromosomes(r2,:)); %crossover
        population_after_crossover = [population_after_crossover;c]; 
     end
     population_after_mutation = [];
     for j=1:population_size
         population_after_mutation = [population_after_mutation;mutation(population_after_crossover(j,:))];  % mutation  
     end
     chromosomes = population_after_mutation;
     fitness_population = fitness(bi2de(chromosomes));

     [M,I] = max(fitness_population);
     new_best_sol = bi2de(chromosomes(I,:));
     new_best = M;
     if new_best>best
         best = new_best;
         best_sol = new_best_sol;
     end 
     obj = [obj,best];
 end



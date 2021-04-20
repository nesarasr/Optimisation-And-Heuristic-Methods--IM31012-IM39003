% ACTIVITY 2 
% NAME : NESARA S R
% ROLL NO : 18IM30014

clc;
clear;

% parameters
population_size = 10;


max_iterations=10000; %can be set to 50 as required in the question but it results in a poor convergence
lb = [-5,-5];
ub = [5,5];

%generate initial population ( REAL ENCODED )
r = -5 + (5+5)*rand(10,2);

%compute fitness of the population
fitness_population = [];
    for i=1:population_size
        fitness_population = [fitness_population fitness(r(i,:))];
    end

[M,I] = max(fitness_population);
best_sol = r(I,:);
best = M;
obj = [];
chromosomes = r;
 for i=1:max_iterations 
     chromosomes = selection(chromosomes,population_size);
     population_after_crossover = [];
     for j=1:(population_size/2)
        r1 = randi([1,population_size]);
        r2 = randi([1,population_size]);
        while(r1==r2)
            r1 = randi([1,population_size]);
            r2 = randi([1,population_size]);
        end
        c = crossover(chromosomes(r1,:),chromosomes(r2,:));
        population_after_crossover = [population_after_crossover;c]; 
     end
     population_after_mutation = [];
     for j=1:population_size
         population_after_mutation = [population_after_mutation;mutation(population_after_crossover(j,:),lb,ub)];    
     end
     chromosomes = population_after_mutation;
     fitness_population = [];
     for i=1:population_size
        fitness_population = [fitness_population fitness(chromosomes(i,:))];
     end

     [M,I] = max(fitness_population);
     new_best_sol = (chromosomes(I,:));
     new_best = M;
     if new_best>best
         best = new_best;
         best_sol = new_best_sol;
     end 
     obj = [obj,fobj(best_sol)];
 end

fprintf('Best objective function value = %.4f',fobj(best_sol))
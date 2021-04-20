% ACTIVITY 1
% NAME : NESARA S R
% ROLL NO : 18IM30014

clc;
clear;
% parameters
max_iterations = 1000; 
population_size = 30;  
lb = [0 0];
ub = [15 15];

length_of_chromosome = log2(ub(1)-lb(1)+1) + log2(ub(2)-lb(2)+1);
length_of_x = [log2(ub(1)-lb(1)+1) log2(ub(2)-lb(2)+1)] ;

%generate initial population
r = randi([0 pow2(length_of_chromosome)-1],1,population_size);
chromosomes = de2bi(r);
r = convert_to_dec(chromosomes);
%compute fitness of the population
fitness_population = fitness(convert_to_dec(chromosomes));
[M,I] = max(fitness_population);
best_sol = r(I,:);
best = M;
obj = [];

%GA 
 for i=1:max_iterations 
     chromosomes = convert_to_bi(selection(chromosomes)); %selection
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
     fitness_population = fitness(convert_to_dec(chromosomes));

     [M,I] = max(fitness_population);
     new_best_sol = convert_to_dec(chromosomes(I,:));
     new_best = M;
     if new_best>best
         best = new_best;
         best_sol = new_best_sol;
     end 
     obj = [obj,fobj(best_sol)];
 end

disp(obj(end));



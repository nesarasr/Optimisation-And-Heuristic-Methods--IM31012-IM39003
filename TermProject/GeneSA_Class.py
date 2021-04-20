#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Tue Apr  6 11:41:45 2021

@author: nesarasr
"""

"""
GENETIC SIMULATED ANEEALING ALGORITHM CLASS
"""


import numpy as np


class Gene_SA:

    # initializes the required paramers
    def __init__(self,df,D,K,N,PIC,rT,rD,population_size,generations,crossover_probability,mutation_probability):
        
        self.df = df
        self.D = D
        self.K = K
        self.N = N
        self.PIC = PIC
        self.rT = rT
        self.rD = rD
        self.population_size = population_size
        self.generations = generations
        self.crossover_probability = crossover_probability
        self.mutation_probability = mutation_probability
        
        self.best_fitness = -1000
        self.best_chromosome = []
        
        
        self.T_init = 1000 #Initial Temperature 
        self.max_run = 20 #Maximum Number of runs 
        self.k = 1 #Boltzman constant
        self.T_min = 1 #Minimum temperature for cooling
        self.alpha= 0.3 #cooling factor
        
        
    # computes fitness of a chromosome
    def fitness_chromo(self,chromosome):
    
        loan_revenue = np.sum(chromosome*(self.df['Interest']*self.df['Loan Size']-self.df['Loss (lambda)']))
        loan_cost = np.sum(chromosome*self.df['Loan Size']*self.PIC)

        T = (1-self.K)*self.D*np.sum(chromosome) - np.sum(self.df['Loan Size']*chromosome)
        total_transaction_cost = self.rT*T
        cost_demand_deposit = self.rD*self.D

        return max(0,loan_revenue+loan_cost+total_transaction_cost-cost_demand_deposit-np.sum(chromosome*self.df['Loss (lambda)']) + 10*min(0,(1-self.K)*self.D-np.sum(chromosome*self.df['Loan Size'])))

    # checks if a chromosome is a feasible solution
    def check_feasibility(self,chromosome):
        
        '''
        Always returns True if a penalty function is included in the fitness function
        '''
    
        T = (1-self.K)*self.D - np.sum(self.df['Loan Size']*chromosome)
        '''
        This section is to be uncommented if the fitness function does not include a penalty function
        '''
        # if T>=0:
        #     return True
        # else:
        #     return False
        
        return True
        
        
    # generates a random chromosome length N
    def generate_chromosome(self):
    
        # N is the number of customers
        chromosome = []
        for i in range(self.N):
            r = np.random.rand()
            if r>=0.5:
                chromosome.append(1)
            else:
                chromosome.append(0)
        return chromosome
    
    # generates a random population of specified size
    def generate_population(self):
    
        population = []
        count=0
        while count<self.population_size:
            chromosome = self.generate_chromosome()
            if self.check_feasibility(chromosome):
                population.append(chromosome)
                count+=1

        return population  
    
    # computes fitness of a population
    def evaluate_population(self,population):
    
        fitness = []
        for chromosome in population :
            fitness.append(self.fitness_chromo(chromosome))
        return fitness
    
    # performs roulette wheel selection
    def selection(self,population):
    
        population_size = self.population_size
        fitness = self.evaluate_population(population)
        cum_probability = np.cumsum(fitness/np.sum(fitness))
        population_selected = []
        for i in range(population_size):
            r = np.random.rand()
            for j in range(population_size):
                if(r<cum_probability[j]):
                    population_selected.append(population[j])
                    break
        return population_selected  
    
    # performs single-point crossover between two chromsomes
    def crossover(self,chromosome1,chromosome2):
    
        bit_size = self.N
        r = np.random.rand()
        if r<=self.crossover_probability:
            crossover_point = np.random.randint(1,bit_size)
            c1 =  chromosome1[:crossover_point]+chromosome2[crossover_point:]
            c2 =  chromosome2[:crossover_point]+chromosome1[crossover_point:]
        else:
            c1 = chromosome1
            c2 = chromosome2
        return c1,c2
    
    
    # performs bit-flip mutation
    def mutation(self,chromosome):
        
        bit_size = self.N
        r = np.random.rand()
        if r<=self.mutation_probability:
            mutation_point = np.random.randint(bit_size)
            chromosome[mutation_point] =  1-chromosome[mutation_point]
        return chromosome
    
    # run GeneSA algorithm
    def run_GeneSA(self):
        
        i = 0 
        totaleval = 0 
        T = self.T_init
        
        #population = initial_population
        population = self.generate_population() # generate initial population
        fitness = self.evaluate_population(population.copy())
        initial_E = np.median(fitness) # note median of the initial population
        old_E = initial_E 
        new_E = initial_E
        
        iter_best_fitness = []
        global_best_fitness = []
        iter_avg_fitness = []
        
        while T>self.T_min:
            i+=1
            totaleval = totaleval+1;
            
            # generate new generation
            population_selected = self.selection(population) # perform selection
            
            population_after_crossover = []
            
            for j in range(self.population_size//2): # perform crossover
                while True:
                    while True:
                        r1 = np.random.randint(self.population_size) 
                        r2 = np.random.randint(self.population_size)

                        if r1!=r2:
                            break;
                    c1,c2 = self.crossover(population_selected[r1].copy(),population_selected[r2].copy())
                    if self.check_feasibility(c1) and self.check_feasibility(c2):
                        population_after_crossover.append(c1)
                        population_after_crossover.append(c2)
                        break
                        
            population_after_mutation = []
            
            for j in range(self.population_size): # perform mutation
                
                while True:
                    m = self.mutation(population_after_crossover[j].copy())
                    if self.check_feasibility(m):
                        population_after_mutation.append(m)
                        break;
                        
            if i>=self.max_run:
                i=1
                T=self.alpha*T; # temperature update
            fitness = self.evaluate_population(population_after_mutation.copy())
            
            '''
            THIS PART COMPUTES MEDIAN OF THE NEW POPULATION AND DECIDED WHETHER
            IT IS TO BE ACCEPTED OR NOT USING THE RULES OF SIMULATED ANNEALING
            
            BY DOING SO, WE ARE ENSURING THAT ATLEAST 50% OF THE NEW GENERATION
            ARE BETTER THAN THE ATLEAST 50% OF THE OLD GENERATION
            '''
            new_E = np.median(fitness)
            delta_E = new_E - old_E
            
            if delta_E>0:
                population=population_after_mutation
                old_E = new_E
                
            if delta_E<=0 and np.exp(delta_E/(self.k*T))>np.random.rand():
                population=population_after_mutation
                old_E = new_E
            
            fitness_population = self.evaluate_population(population.copy())
            best_sol = np.argmax(fitness_population)
            
            if fitness_population[best_sol]>self.best_fitness:
                self.best_fitness = fitness_population[best_sol]
                self.best_chromosome = population[best_sol]
                
            iter_best_fitness.append(fitness_population[best_sol])
            global_best_fitness.append(self.best_fitness)
            iter_avg_fitness.append(np.mean(fitness_population))  
            
        return iter_best_fitness,global_best_fitness,iter_avg_fitness  
    
    
    

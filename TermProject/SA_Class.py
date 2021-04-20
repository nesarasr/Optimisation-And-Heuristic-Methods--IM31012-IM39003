#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Tue Apr  6 11:32:19 2021

@author: nesarasr
"""

"""
SIMULATED ANNEALING CLASS
"""

import numpy as np


class SA:

    # initializes the required paramers
    def __init__(self,df,D,K,N,PIC,rT,rD):
        
        self.df = df
        self.D = D
        self.K = K
        self.N = N
        self.PIC = PIC
        self.rT = rT
        self.rD = rD
        
        self.best_fitness = -1000
        self.best_chromosome = []
        
        
        self.T_init = 1000000 #Initial Temperature 
        self.max_run = 10 #Maximum Number of runs 
        self.k = 1 #Boltzman constant
        self.T_min = 1 #Minimum temperature for cooling
        self.alpha= 0.75 #cooling factor
    
    
    # checks if a chromosome is a feasible solution
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
    
    
    # run Simulated Annealing
    def run_SA(self):
        
        i = 0 
        totaleval = 0 
        T = self.T_init
        
        population = self.generate_chromosome() # initial solution
        fitness = self.fitness_chromo(population)
        initial_E = fitness 
        old_E = initial_E 
        new_E = initial_E
        
        iter_best_fitness = []
        global_best_fitness = []
        
        while T>self.T_min:
            i+=1
            totaleval = totaleval+1;           
            if i>=self.max_run:
                i=1
                T=self.alpha*T; # temp update

            
            
            while True: # local search
                r = np.random.randint(self.N)
                population_after_mutation  = population
                population_after_mutation[r] = 1-population_after_mutation[r]
                if self.check_feasibility(population_after_mutation):
                    break
                
            fitness = self.fitness_chromo(population_after_mutation)

            new_E = fitness
            delta_E = new_E - old_E
            
            # decide whether the new solution is accepted or not
            if delta_E>0:
                population=population_after_mutation
                old_E = new_E
                
            if delta_E<=0 and np.exp(delta_E/(self.k*T))>np.random.rand():
                population=population_after_mutation
                old_E = new_E
            
            if new_E>self.best_fitness:
                self.best_fitness = new_E
                self.best_chromosome = population_after_mutation
                
            iter_best_fitness.append(self.fitness_chromo(population)) # record iteration best
            global_best_fitness.append(self.best_fitness)  # record global best
            
        return iter_best_fitness,global_best_fitness
    
    

#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Wed Mar 31 12:37:07 2021

@author: nesarasr

NAME : NESARA S R
ROLL NO : 18IM30014
OHM ASSIGNMENT 2

"""

import numpy as np
import matplotlib.pyplot as plt
import seaborn as sns
sns.set()
import warnings
warnings.filterwarnings('ignore')

'''
Objective Function
'''

def fitness(X_ij ,X_jk,Y_ij,Y_jk,c_ij,c_jk ,f_ij,f_jk):
    
    fixed_1 = np.multiply(np.array(Y_ij),np.array(f_ij))
    fixed_2 = np.multiply(np.array(Y_jk),np.array(f_jk))
    
    variable_1 = np.multiply(np.array(X_ij),np.array(c_ij))
    variable_2 = np.multiply(np.array(X_jk),np.array(c_jk))
    EAC_ij = fixed_1+variable_1
    EAC_jk = fixed_2+variable_2
    cost = np.sum(fixed_1)+np.sum(fixed_2)+np.sum(variable_1)+np.sum(variable_2)
    
    return [cost,EAC_ij,EAC_jk] 

'''
Generate binary variables Y_ij and Y_jk, from X_ij and X_jk respectively
'''

def gen_y(X):
    Y = X
    for i in range(len(X)):
        for j in range(len(X[0])):
            Y[i][j] = 1 if X[i][j]>0 else 0 
    return Y  


'''
Generate probability matrix PM_ij & PM_jk
'''
def gen_PM(EAC_ij,EAC_jk,tau_ij,tau_jk,alpha,beta):
    
    n_ij = 1./(np.array(EAC_ij))
    n_jk = 1./(np.array(EAC_jk))
    
    tau_ij = np.array(tau_ij)**alpha
    tau_jk = np.array(tau_jk)**alpha
    
    n_ij = n_ij**beta
    n_jk = n_jk**beta
    
    P_ij = np.multiply(tau_ij,n_ij)
    P_jk = np.multiply(tau_jk,n_jk)
    
    
    
    PM_ij = P_ij.clip(0)
    PM_jk = P_jk.clip(0)
    
    
    
    for i in range(len(P_ij)):
        PM_ij[i] = P_ij[i]/np.sum(P_ij[i])
     
    for i in range(len(P_jk)):
        PM_jk[i] = P_jk[i]/np.sum(P_jk[i])

    return [PM_ij,PM_jk]


'''
Monte Carlo Simulation based Allocation
'''
def allocate(PM_ij,PM_jk,CD,S):
    
    PM_ij = np.cumsum(PM_ij,axis=1)
    PM_jk = np.cumsum(PM_jk,axis=1)
    M = list(PM_ij.shape)[1]
    D = list(PM_ij.shape)[0]
    R = list(PM_jk.shape)[0]
    
    X_ij = np.full((D, M), 0)   # Decision variables : units from plant 'i' to DC 'j'
    X_jk = np.full((R, D), 0)  # Decision variables : units from DC 'j' to Retailer 'k'

    for i in range(R):
        
        # allocate distributor
        
        r = np.random.rand()
        DC_allocated = 0
        for j in range(D):
            if(r<PM_jk[i][j]):
                DC_allocated = j
                break
        X_jk[i][DC_allocated] = CD[i]
        
        # allocate plant
        P_allocated = 0
        r = np.random.rand()
        for j in range(M):
            if(r<PM_ij[DC_allocated][j]):
                P_allocated = j
                break
        X_ij[DC_allocated][P_allocated] += min(S[P_allocated],CD[i])
        residue = CD[i]-min(S[P_allocated],CD[i])
        S[P_allocated]-=min(S[P_allocated],CD[i])
        if residue>0: 
            P_allocated = 1-P_allocated
            X_ij[DC_allocated][P_allocated] += min(S[P_allocated],residue)
            residue = residue-min(S[P_allocated],residue)
            S[P_allocated]-=min(S[P_allocated],residue)
    Y_ij = gen_y(X_ij.copy()) # Decision variables : 1 or 0 from plant 'i' to DC 'j'
    Y_jk = gen_y(X_jk.copy()) # Decision variables : 1 or 0 from DC 'j' to Retailer 'k'
    
    return [X_ij,X_jk,Y_ij,Y_jk]


'''
Initialization
'''
M = 2
D = 3
R = 4

c_ij = (np.array([[10,25,30],[5,35,14]])).T # variable cost per unit from plant 'i' to DC 'j'
c_jk = (np.array([[43,25,10,50],[20,5,1,30],[60,32,50,40]])).T # variable cost per unit from DC 'j' to Retailer 'k'
np.random.seed(0)
f_ij = (np.array([[1000,400,1150],[900,200,1300]])).T # fixed cost per unit from plant 'i' to DC 'j'
f_jk = (np.array([[500,1200,800,2000],[2250,1500,1,2000],[400,1800,2300,1000]])).T # fixed cost per unit from DC 'j' to Retailer 'k'

S = [250,350]  # Capacity of plants
CD = [150,80,100,270] # Demand of retailers


N = 200   # number of ants
IT = 500   # number of iterations
alpha = 2 # pheromone control parameter
beta = 5  # parameter controlling the magnitude of n_ij (the profitability of selecting jth partner from the next stage by the ith partner in the current stage)
rho = 0.9 # evaporation rate
Q = 500   # parameter controlling the pheromone increment amount (constant) 
tau_ij = np.full((D, M), 0.50)  # initial amount of pheromone in each edge in the graph : from plant 'i' to DC 'j'
tau_jk = np.full((R, D), 0.50)  # initial amount of pheromone in each edge in the graph : from DC 'j' to Retailer 'k'

'''
Ant Colony Optimization
'''

# Initial Random Allocation

EAC_ij = np.full((D, M), 0) 
EAC_jk = np.full((R, D), 0) 

for i in range(D):
    for j in range(M):
        EAC_ij[i][j] = S[j]*c_ij[i][j]+f_ij[i][j]
        
for i in range(R):
    for j in range(D):
        EAC_jk[i][j] = CD[i]*c_jk[i][j]+f_jk[i][j]

PM = gen_PM(EAC_ij,EAC_jk,tau_ij.copy(),tau_jk.copy(),alpha,beta)
random_allocation = allocate(PM[0].copy(),PM[1].copy(),CD.copy(),S.copy())
c = fitness(random_allocation[0] ,random_allocation[1],random_allocation[2],random_allocation[3],c_ij,c_jk ,f_ij,f_jk)
global_best_sol = c[0]
global_best_allocation_ij = random_allocation[0]
global_best_allocation_jk = random_allocation[1]
Y_ij = gen_y(global_best_allocation_ij.copy())
Y_jk = gen_y(global_best_allocation_jk.copy())


delta_tau = Q/(global_best_sol)
tau_ij = np.multiply(Y_ij,(rho*tau_ij)+delta_tau)+np.multiply(1-Y_ij,1*tau_ij)
tau_jk = np.multiply(Y_jk,(rho*tau_jk)+delta_tau)+np.multiply(1-Y_jk,1*tau_jk)

# Iterations
track_local = []
track_global = []
for i in range(IT):

    local_best_sol = 1000000
    local_best_allocation_ij = 0
    local_best_allocation_jk = 0
    for ant in range(N):
        PM = gen_PM(EAC_ij+0.1,EAC_jk+0.1,tau_ij.copy(),tau_jk.copy(),alpha,beta)
        A = allocate(PM[0].copy(),PM[1].copy(),CD.copy(),S.copy())
        sol = fitness(A[0],A[1],A[2],A[3],c_ij,c_jk ,f_ij,f_jk)
        if sol[0]<local_best_sol:
            local_best_sol = sol[0]
            local_best_allocation_ij = A[0]
            local_best_allocation_jk = A[1]
            Y_ij_local = gen_y(local_best_allocation_ij.copy())
            Y_jk_local = gen_y(local_best_allocation_jk.copy())
    track_local.append(local_best_sol)
    
    
    if global_best_sol>local_best_sol:
        global_best_sol = local_best_sol
        global_best_allocation_ij = local_best_allocation_ij
        global_best_allocation_jk = local_best_allocation_jk
        Y_ij = gen_y(global_best_allocation_ij.copy())
        Y_jk = gen_y(global_best_allocation_jk.copy())
    track_global.append(global_best_sol)
    cost_update = fitness(local_best_allocation_ij.copy() ,local_best_allocation_jk.copy(),Y_ij_local,Y_jk_local,c_ij,c_jk ,f_ij,f_jk)
    
    EAC_ij = cost_update[1]
    EAC_jk = cost_update[2]
    delta_tau = Q/(local_best_sol)
    
    tau_ij = np.multiply(Y_ij,(rho*tau_ij)+delta_tau)+np.multiply(1-Y_ij,tau_ij)
    tau_jk = np.multiply(Y_jk,(rho*tau_jk)+delta_tau)+np.multiply(1-Y_jk,tau_jk)
      

'''
Plot Results
'''
x = [1,IT]
y = [track_global[0],track_global[-1]]
fig, ax = plt.subplots()
ax.scatter(x, y,color="red")
ax.plot(track_global)

for i, txt in enumerate(y):
    ax.annotate(txt, (x[i], y[i]),color="red")
plt.title("Global Best v/s Iterations")
fig_size=(10,5)
plt.rcParams["figure.figsize"] = fig_size
plt.show() 

print("Best cost obtained :",track_global[-1])   
    

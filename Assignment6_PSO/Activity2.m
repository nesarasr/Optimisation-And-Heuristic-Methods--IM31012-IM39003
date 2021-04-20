% Name : Nesara S R
% Roll No : 18IM30014

%************************************************%
% ACTIVITY 2
%************************************************%

clc
clear all
close all
rng default %control for randome number generator
tic %Stopwatch timer

%%PSO Parsms : BEST FROM ACTIVITY 1
    n=40;          % population size
    w= 0.6;          % inertia weight
    wdamp = 0.99;    % inertia deamping
    c1=0.4;           % acceleration factor P_best
    c2=0.8;           % acceleration factor G_best
    maxite=100;      % set maximum number of iteration in each run
    maxrun=9;       % set maximum number of runs need to be

    
[solution,best_variables,bestrun,ffite,ffmin] = PSO(n,w,wdamp,c1,c2,maxite,maxrun); 


% PSO convergence characteristic
plot(ffmin(1:ffite(bestrun),bestrun),'-k');
xlabel('Iteration');
ylabel('Fitness function value (objective + penalty');
title('PSO convergence characteristic')


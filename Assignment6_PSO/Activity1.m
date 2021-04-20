% Name : Nesara S R
% Roll No : 18IM30014

%************************************************%
% ACTIVITY 1

% This file contains implementation of analyzing effect of parameter
% variation on the optimal value obtained 

% --- UNCOMMENT SECTION CORRESPONDING TO EACH PARAMETER TO SEE HOW THE
% OPTIMAL FUNCTION VALUE VARIES WITH THAT PARAMETER --------
%************************************************%

clc
clear all
close all
rng default %control for randome number generator
tic %Stopwatch timer

%%PSO Parsms : DEFAULT
    n=100;          % population size
    w= 0.1          % inertia weight
    wdamp = 0.99    % inertia deamping
    c1=1;           % acceleration factor P_best
    c2=2;           % acceleration factor G_best
    maxite=10;      % set maximum number of iteration in each run
    maxrun=1;       % set maximum number of runs need to be

% % Parameter variations
    N = (10:10:50);         % population size
    W = (0.1:0.1:0.9);      % inertia weight
    wdamp = 0.99            % inertia deamping
    Maxite = (10:10:100);   % maximum number of iteration in each run
    C1 = (0:0.2:1);         % acceleration factor P_best
    C2 = (0:0.2:1);         % acceleration factor G_best
    Maxrun=(1:1:10);        % set maximum number of runs need to be


% Change parameter

% POPULATION SIZE -------------------------------------------------------
population_size_variation = [];
population_size_variation_X = [];

for i=1:length(N)
    ni = N(i);
    [solution,best_variables] = PSO(ni,w,wdamp,c1,c2,maxite,maxrun); 
    population_size_variation = [population_size_variation solution];
    population_size_variation_X = [population_size_variation_X;best_variables];
end
% PSO convergence vs parameter
plot(N,population_size_variation,'-k');
xlabel('Population size');
ylabel('Fitness function value');
ylim([0 0.01])
xlim([N(1) N(end)])
title('PSO convergence variation with change in population size');

% % INERTIA WEIGHT-----------------------------------------------------------
% inertia_weight_variation = [];
% inertia_weight_variation_X = [];
% 
% for i=1:length(W)
%     wi = W(i);
%     [solution,best_variables] = PSO(n,wi,wdamp,c1,c2,maxite,maxrun); 
%     inertia_weight_variation = [inertia_weight_variation solution]
%     inertia_weight_variation_X = [inertia_weight_variation_X;best_variables]
% end
% % PSO convergence vs parameter
% plot(W,inertia_weight_variation,'-k');
% xlabel('Inertia Weight');
% ylabel('Fitness function value');
% %ylim([0 0.01])
% xlim([W(1) W(end)])
% title('PSO convergence variation with change in inertial weight');
% 
% % MAX ITERATIONS-----------------------------------------------------------
% maxiter_variations = [];
% maxiter_variations_X = [];
% 
% for i=1:length(Maxite)
%     maxite_i = Maxite(i);
%     [solution,best_variables] = PSO(n,w,wdamp,c1,c2,maxite_i,maxrun); 
%     maxiter_variations = [maxiter_variations solution]
%     maxiter_variations_X = [maxiter_variations_X;best_variables]
% end
% % PSO convergence vs parameter
% plot(Maxite,maxiter_variations,'-k');
% xlabel('Maximum Iterations');
% ylabel('Fitness function value');
% %ylim([0 0.01])
% xlim([Maxite(1) Maxite(end)])
% title('PSO convergence variation with change in Maximum Iterations');


% % C1-----------------------------------------------------------
% c1_variations = [];
% c1_variations_X = [];
% 
% for i=1:length(C1)
%     c1_i = C1(i);
%     [solution,best_variables] = PSO(n,w,wdamp,c1_i,c2,maxite,maxrun); 
%     c1_variations = [c1_variations solution]
%     c1_variations_X = [c1_variations_X;best_variables]
% end
% % PSO convergence vs parameter
% plot(C1,c1_variations,'-k');
% xlabel('C1');
% ylabel('Fitness function value');
% %ylim([0 0.01])
% xlim([C1(1) C1(end)])
% title('PSO convergence variation with change in C1');

% % C2-----------------------------------------------------------
% c2_variations = [];
% c2_variations_X = [];
% 
% for i=1:length(C2)
%     c2_i = C2(i);
%     [solution,best_variables] = PSO(n,w,wdamp,c1,c2_i,maxite,maxrun); 
%     c2_variations = [c2_variations solution]
%     c2_variations_X = [c2_variations_X;best_variables]
% end
% % PSO convergence vs parameter
% plot(C2,c2_variations,'-k');
% xlabel('C2');
% ylabel('Fitness function value');
% %ylim([0 0.01])
% xlim([C2(1) C2(end)])
% title('PSO convergence variation with change in C2');


% % C1 & C2-----------------------------------------------------------
% c12_variations = [];
% for i=1:length(C1)
%     
%     c2_variations = [];
%     for j=1:length(C2)
%         c1_i = C1(i);
%         c2_j = C2(j);
%         [solution,best_variables] = PSO(n,w,wdamp,c1_i,c2_j,maxite,maxrun); 
%         c2_variations = [c2_variations solution]
%     end
%     c12_variations = [c12_variations;c2_variations];
%     
%     
% end
% % PSO convergence vs parameter
% surf(c12_variations)
% xticks(c1)
% xticklabels({'0','0.2','0.4','0.6','0.8','1.0'})
% yticklabels({'0','0.2','0.4','0.6','0.8','1.0'})
% yticks(c2)
% xlabel('C1');
% ylabel('C2');


% % MAX RUN-----------------------------------------------------------
% maxrun_variations = [];
% maxrun_variations_X = [];
% 
% for i=1:length(Maxrun)
%     maxrun_i = Maxrun(i);
%     [solution,best_variables] = PSO(n,w,wdamp,c1,c2,maxite,maxrun_i); 
%     maxrun_variations = [maxrun_variations solution]
%     maxrun_variations_X = [maxrun_variations_X;best_variables]
% end
% % PSO convergence vs parameter
% plot(Maxrun,maxrun_variations,'-k');
% xlabel('Max Run');
% ylabel('Fitness function value');
% %ylim([0 0.01])
% xlim([Maxrun(1) Maxrun(end)])
% title('PSO convergence variation with change in Max Run');




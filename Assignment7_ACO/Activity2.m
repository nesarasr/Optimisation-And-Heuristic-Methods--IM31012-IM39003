%************************************************%
% Name : Nesara S R
% Roll No : 18IM30014
% Assignment 7 : Activity 2
%************************************************%
clc;
clear;
close all;


processing_time =[6 2 3 4 5];
due_date = [18 6 9 11 8];
n=length(processing_time);
n_jobs=n;


% ACO Parameters

MaxIt=10;      % Maximum Number of Iterations
nAnt=100;        % Number of Ants (Population Size)
tau0=100;	    % Initial Pheromone
alpha=1;        % Pheromone Exponential Weight
beta=1;         % Heuristic Exponential Weight
rho=0.0;       % Evaporation Rate
Q=1;

% Initialization

eta=1./due_date;             % Heuristic Information vector
tau=tau0*ones(n_jobs,n_jobs);   % Pheromone Matrix
tardiness=zeros(MaxIt,1);    % Array to hold Tardiness Values

% Empty Ant
empty_ant.Tour=[];
empty_ant.Cost=[];

% Ant Colony Matrix
ant=repmat(empty_ant,nAnt,1);

% Best Ant
BestSol.Cost=inf;

% ACO Main Loop

for it=1:MaxIt
    
    % Move Ants
    for k=1:nAnt
        
        ant(k).Tour=randi([1 n_jobs]);
        
        for l=2:n_jobs
            
            i=ant(k).Tour(end);
            
            P=tau(i,:).^alpha.*eta.^beta;
            
            P(ant(k).Tour)=0; %replce Inf by 0
            
            P=P/sum(P);
            
            % RouletteWheelSelection;
            r=rand;
            
            C=cumsum(P);
            
            j=find(r<=C,1,'first');
            
            ant(k).Tour=[ant(k).Tour j];
            
        end
        
    end
    
    % Update Pheromones
    for k=1:nAnt
        
        tour=ant(k).Tour;
        n=numel(tour);
        
        completion_time = processing_time(tour); 
        completion_time = cumsum(completion_time); % compute completion time vector of the tour
        L = sum(max(0,completion_time-due_date(tour))); % compute tardiness of the tour
        ant(k).Cost= L;
        for l=1:n_jobs-1
            i=tour(l);
            j=tour(l+1);
            tau(i,j)=tau(i,j)+Q/ant(k).Cost;   
        end
        if ant(k).Cost<BestSol.Cost
            BestSol=ant(k);
        end
        
    end
    
    % Evaporation
    tau=(1-rho)*tau;
    
    % Store Best Cost
    tardiness(it)=BestSol.Cost;
    
    % Show Iteration Information
    disp(['Iteration ' num2str(it) ': Best Cost = ' num2str(tardiness(it))]);
    
    
end


% Results

disp(['Optimal Schedule '])
disp([num2str(BestSol.Tour)])
disp(['Minimum Tardiness = ' num2str(BestSol.Cost)]);
figure;
plot(tardiness,'LineWidth',2);
xlabel('Iteration');
ylabel('Tardiness');
grid on;







%************************************************%
%OHM 39003
%ACO Algorithm: In-Class March 12, 2020
%Author: Internet Source
%************************************************%

clc;
clear;
close all;

    x=[82 91 12 92 63 09 28 55 96 97 15 98 96 49 80 14 42 92 80 96];
    
    y=[66 03 85 94 68 76 75 39 66 17 71 03 27 04 09 83 70 32 95 03];
    
    n=length(x);
    
    D=zeros(n,n);
    
    for i=1:n-1
        for j=i+1:n
            
            D(i,j)=sqrt((x(i)-x(j))^2+(y(i)-y(j))^2);
            
            D(j,i)=D(i,j);
            
        end
    end
    

    
nVar=n;
tour = [];


%% ACO Parameters

MaxIt=300;      % Maximum Number of Iterations

nAnt=40;        % Number of Ants (Population Size)

Q=1;

Q_multi=15;

tau0=Q_multi*Q/(nVar*mean(D(:)));	% Initial Phromone

alpha=1;        % Phromone Exponential Weight
beta=1;         % Heuristic Exponential Weight

rho=0.05;       % Evaporation Rate


%% Initialization

eta=1./D;             % Heuristic Information Matrix

tau=tau0*ones(nVar,nVar);   % Phromone Matrix

BestCost=zeros(MaxIt,1);    % Array to Hold Best Cost Values

% Empty Ant
empty_ant.Tour=[];
empty_ant.Cost=[];

% Ant Colony Matrix
ant=repmat(empty_ant,nAnt,1);

% Best Ant
BestSol.Cost=inf;


%% ACO Main Loop

for it=1:MaxIt
    
    % Move Ants
    for k=1:nAnt
        
        ant(k).Tour=randi([1 nVar]);
        
        for l=2:nVar
            
            i=ant(k).Tour(end);
            
            P=tau(i,:).^alpha.*eta(i,:).^beta;
            
            P(ant(k).Tour)=0; %replce Inf by 0
            
            P=P/sum(P);
            
% %            RouletteWheelSelection;
            r=rand;
    
            C=cumsum(P);
    
            j=find(r<=C,1,'first');
            
            ant(k).Tour=[ant(k).Tour j];
            
        end  
        
    end
    
    %% Update Phromones
    for k=1:nAnt
        
        tour=ant(k).Tour;
        n=numel(tour);
        
        tour=[tour tour(1)]; %#ok
        
         L=0;
            for i=1:n
             L=L+D(tour(i),tour(i+1));
            end
	ant(k).Cost= L;

        for l=1:nVar
            
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
    BestCost(it)=BestSol.Cost;
    
    % Show Iteration Information
    disp(['Iteration ' num2str(it) ': Best Cost = ' num2str(BestCost(it))]);
    
    % Plot Solution
    figure(1);
    %tour
    plot(x(tour),y(tour),'k-o',...
        'MarkerSize',10,...
        'MarkerFaceColor','y',...
        'LineWidth',1.5);
    
    
end

%% Results

figure;
plot(BestCost,'LineWidth',2);
xlabel('Iteration');
ylabel('Best Cost');
grid on;
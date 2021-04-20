% Name : Nesara S R
% Roll No : 18IM30014
% ACTIVITY 2.2 

clear
clc

%Lower and upper bounds
Lb = [-5 -5];
Ub = [5 5];

%Initial solution
u0 = [0 0] ;

%size of solution 
d = length(Lb);

%SA Parameters
T_init = 1000;  %Initial Temperature 
max_run = 100;  %Maximum Number of runs 
k = 1;   %Boltzman constant
T_min = 0.1; %Minimum temperature for cooling
alpha= 0.7; %cooling factor

% Introducing new parameters : Activity 2.2
max_rej = 2000 ;
max_accept = 80 ;
initial_search = 500;
step = 0.5;



%Initializing Counters and values
i = 0; 
j = 0; 
totaleval = 0; 
T = T_init;
E_init = Fun(u0); 
E_old = E_init; 
E_new= E_old;
best = u0;
accept = 0;



%Main Program 
while (T>T_min && j<max_rej)
    i=i+1;
    accept = accept+1;
    if(totaleval>initial_search)
        ns=localsearch(best,Lb,Ub,step); 
    else
        ns=newsolution1(u0,Lb,Ub);
    end
    
    
    if(i>=max_run || max_accept<=accept)
        %reset counters
        i=1;
        accept=1;
        %cooling according to cooling schedule
        T=cooling(alpha,T);
    end
    ns=newsolution1(u0,Lb,Ub);
    totaleval = totaleval+1;
    E_new=Fun(ns);
    DeltaE=E_new-E_old;
    if(DeltaE<0)
        best=ns;
        E_old = E_new;
    end
    if (DeltaE>=0 && exp(-DeltaE/(k*T))>rand)
        best = ns;
        E_old = E_new;
        
    else
        j=j+1;
    end
    f_opt=E_old;
    
end
bestsol=best;
f_val=f_opt;
N=totaleval;
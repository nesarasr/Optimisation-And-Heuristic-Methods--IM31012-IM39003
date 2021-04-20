% The code provided for particle swarm optimization has been converted to a
% function to ease the implementation of activity 1 & activity 2


function [bestfun,best_variables,bestrun,ffite,ffmin] = PSO(n,w,wdamp,c1,c2,maxite,maxrun)
    
    maxite
    %%Function Bounds
    m=3; % no vars
    LB=[0 0 0];
    UB=[10 10 10];
    solutions = []
    %%PSO loop
    for run=1:maxrun
        run
        % pso initialization----------------------------------------------start
        for i=1:n
            for j=1:m
                x0(i,j)=round(LB(j)+rand()*(UB(j)-LB(j)));
            end
        end
        x=x0;     % initial population
        v=0.1*x0; % initial velocity
        for i=1:n
            f0(i,1)=ofun(x0(i,:));
        end
        [fmin0,index0]=min(f0);
        pbest=x0;           % initial pbest
        gbest=x0(index0,:); % initial gbest
        % pso initialization------------------------------------------------end
        % pso algorithm---------------------------------------------------start
        ite=1;
        while ite<=maxite 
            w=w*wdamp       %updating inertia weight
            % pso velocity updates
            for i=1:n
                for j=1:m
                    v(i,j)=w*v(i,j)+c1*rand()*(pbest(i,j)-x(i,j))...
                        +c2*rand()*(gbest(1,j)-x(i,j));
                end
            end
            % pso position update
            for i=1:n
                for j=1:m
                    x(i,j)=x(i,j)+v(i,j);
                end
            end
            % handling boundary violations
            for i=1:n
                for j=1:m
                    if x(i,j)<LB(j)
                        x(i,j)=LB(j);
                    elseif x(i,j)>UB(j)
                        x(i,j)=UB(j);
                    end
                end
            end
            % evaluating fitness
            for i=1:n
                f(i,1)=ofun(x(i,:));
            end
            % updating pbest and fitness
            for i=1:n
                if f(i,1)<f0(i,1)
                    pbest(i,:)=x(i,:);
                    f0(i,1)=f(i,1);
                end
            end
            [fmin,index]=min(f0); % finding out the best particle
            ffmin(ite,run)=fmin;  % storing best fitness
            ffite(run)=ite;       % storing iteration count
            
            % updating gbest and best fitness
            if fmin<fmin0
                gbest=pbest(index,:);
                fmin0=fmin;
            end
            
            %displaying iterative results
            if ite==1
                disp(sprintf('Iteration Best particle Objective fun'));
            end
            disp(sprintf('%8g %8g %8.4f',ite,index,fmin0));
            ite=ite+1;
            
        end
        % pso algorithm-----------------------------------------------------end
        gbest;
        fvalue=ofun(gbest);
        fff(run)=fvalue;
        rgbest(run,:)=gbest;
        disp(sprintf('--------------------------------------'));
    end
    
    % pso main program------------------------------------------------------end
    [bestfun,bestrun]=min(fff)
    best_variables=rgbest(bestrun,:)   
    
end


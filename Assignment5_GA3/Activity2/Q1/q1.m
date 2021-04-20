function [x,fval,exitflag,output,population,score] = q1(nvars,Aineq,bineq,lb)
%% This is an auto generated MATLAB file from Optimization Tool.

%% Start with the default options
options = optimoptions('ga');
%% Modify options setting
options = optimoptions(options,'SelectionFcn', @selectionroulette);
options = optimoptions(options,'CrossoverFcn', @crossoverarithmetic);
options = optimoptions(options,'MutationFcn', @mutationadaptfeasible);
options = optimoptions(options,'Display', 'off');
[x,fval,exitflag,output,population,score] = ...
ga(@fitness,nvars,Aineq,bineq,[],[],lb,[],[],[],options);
disp(fval);
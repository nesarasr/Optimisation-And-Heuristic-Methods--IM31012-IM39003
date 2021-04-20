function [x,fval,exitflag,output,population,score] = q3(nvars,Aineq,bineq,lb,ub,intcon)
%% This is an auto generated MATLAB file from Optimization Tool.

%% Start with the default options
options = optimoptions('ga');
%% Modify options setting
options = optimoptions(options,'FitnessScalingFcn', @fitscalingprop);
options = optimoptions(options,'SelectionFcn', @selectionroulette);
options = optimoptions(options,'MutationFcn', @mutationadaptfeasible);
options = optimoptions(options,'Display', 'off');
[x,fval,exitflag,output,population,score] = ga(@fitness,nvars,Aineq,bineq,[],[],lb,ub,[],intcon,options);


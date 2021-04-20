function [x,fval,exitflag,output,population,score] = q2(nvars)
%% This is an auto generated MATLAB file from Optimization Tool.

%% Start with the default options
options = optimoptions('ga');
%% Modify options setting
options = optimoptions(options,'SelectionFcn', @selectionroulette);
options = optimoptions(options,'Display', 'off');
[x,fval,exitflag,output,population,score] = ...
ga(@fitness,nvars,[],[],[],[],[],[],[],[],options);

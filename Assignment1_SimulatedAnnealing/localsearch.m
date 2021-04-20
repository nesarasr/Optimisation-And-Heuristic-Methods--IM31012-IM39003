function s= localsearch(u,Lb,Ub,step)
% search around
o = -1*ones(size(u));  %o=[-1,-1,..]
if length(Lb)>0
    
    %ensures that the search direction is not restricted to just one direction
    s= u+o+2*rand(size(u))*step;  
end
s= bounds (s, Lb, Ub);
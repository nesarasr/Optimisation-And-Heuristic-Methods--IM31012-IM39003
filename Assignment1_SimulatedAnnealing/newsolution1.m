function s= newsolution1(u0,Lb,Ub)
% search around
if length(Lb)>0 
    s= Lb+(Ub-Lb).*rand(size(u0));
end
s= bounds (s, Lb, Ub);

    
function ns = bounds(ns, Lb, Ub)
if length (Lb)>0
    %apply the lower bound
    ns_tmp = ns;
    I = ns_tmp <Lb;
    ns_tmp (I) = Lb(I)
    %apply the upper bound 
    J=ns_tmp>Ub;
    ns_tmp(J)=Ub(J)
    %update the new move 
    ns=ns_tmp;
else
    ns=ns;
end
  
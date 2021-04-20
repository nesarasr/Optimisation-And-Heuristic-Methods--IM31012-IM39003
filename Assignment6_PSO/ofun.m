function f=ofun(x)
    
%objective function (minimization)

of=10*(x(1)-1)^2+20*(x(2)-2)^2+30*(x(3)-3)^2;
of = of+penalty(x);

f=of;


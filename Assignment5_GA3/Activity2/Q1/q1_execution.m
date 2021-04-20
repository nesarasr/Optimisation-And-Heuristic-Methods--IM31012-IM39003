nvars=3;
Aineq=[2 1 0; 1 0 1;-1 0 0;0 -1 0;0 0 -1];
bineq=[5 ;2 ;-1; -2; 0];
lb=[0 0 0];

[x,fval,exitflag,output,population,score] = q1(nvars,Aineq,bineq,lb);
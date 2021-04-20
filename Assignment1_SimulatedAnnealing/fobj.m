%objective function 
function z = fobj(u)
%z= 500-20*u(1)-26*u(2)-4*u(1)*u(2)+4*u(1).^2+3*u(2).^2;
z = (1-u(1)).^2 + 100*((u(2)-u(1).^2).^2);

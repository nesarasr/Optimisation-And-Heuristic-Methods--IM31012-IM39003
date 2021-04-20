function p = penalty(x)
    
    p=0;
    M = 10000;

% constraint 1
    c1 = x(1)*x(2)+x(1)-x(2)+1.5;
    if c1<=0
        p = p+0;
    else
        p = p+ M*c1;
        
    end
% constraint 2
    c2 = 10 - x(1)*x(2);
    if c2<=0
        p = p+0;
    else
        p = p+ M*c2;
        
    end

end
function z = fitness(x)
    
    z = 20+(x(1)*x(1))+(x(2)*x(2))-10*(cos(2*pi*x(1))+cos(2*pi*x(2))); 
    
end


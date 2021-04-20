function obj = fitness(x)
    
    
    y = [4 6 8 13;13 11 10 8;14 4 10 13;9 11 13 9];
    z = reshape(y.',1,[]);
    obj = sum(z.*x);

end
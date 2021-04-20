function q=DoInsertion(p,i1,i2)
    
    x = p(i1);
    q1 = p(1:i1-1);
    q2 = p(i1+1:end);
    q = [q1,q2];
    q = [q(1:i2-1),x,q(i2:end)];
    
end
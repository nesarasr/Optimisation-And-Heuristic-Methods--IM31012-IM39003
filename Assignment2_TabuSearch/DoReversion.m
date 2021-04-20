function q=DoReversion(p,i1,i2)
    x = p(i1:i2);
    x_rev = wrev(x);
    
    q = [p(1:i1-1),x_rev,p(i2+1:end)];
end
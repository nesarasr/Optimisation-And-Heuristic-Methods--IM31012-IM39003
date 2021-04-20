%objective function for activity 2

function z = fobj(x)
    
    z = ((1-x(1)).^2)+(100*((x(2)-(x(1).^2)).^2));


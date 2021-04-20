%objective function for activity 1

function z = fobj(chromosomes)
    
  dim = size(chromosomes);
  population_size = dim(1);
  z = [];
  
  for i=1:population_size
      x = chromosomes(i,:);
      obj = ((1-x(1)).^2)+(100*((x(2)-(x(1).^2)).^2));
      z = [z obj];
      
  end


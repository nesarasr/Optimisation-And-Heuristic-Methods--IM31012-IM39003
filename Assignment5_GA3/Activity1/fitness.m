% Fitness function for activity 1
% Considering minimization

function z = fitness(x)

  dim = size(x);
  population_size = dim(1);
  z = [];
  
  for i=1:population_size
      x1 = x(i,:);
      z = [z ((1000000/(fobj(x1)+penalty(x1)+1)))]; % penalty(x1)
      
  end
    


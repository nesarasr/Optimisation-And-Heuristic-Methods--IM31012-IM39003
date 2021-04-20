function model=CreateModel()

    n=5;
    d=zeros(n,n); 
    d = [0 132 217 164 158;
         132 0 290 201 79;
         217 290 0 113 303;
         164 201 113 0 196;
         158 79 303 196 0]  
   model.n=n;
   model.d=d;
    
end





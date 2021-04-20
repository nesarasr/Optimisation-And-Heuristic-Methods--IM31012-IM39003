
function q=DoAction(p,a)
    
    x = a(1);
    
    switch x
    case 1
        q=DoSwap(p,a(2),a(3));  %swap when a(1)=1
    case 2
        q=DoReversion(p,a(2),a(3)); %reverse when a(1)=2
    otherwise
        q=DoInsertion(p,a(2),a(3)); %insert when a(1)=3
    end
      
end
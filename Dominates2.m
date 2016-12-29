function dom=Dominates2(x,y,numOfObj,nn)

    
    if nn == 1
        index = numOfObj;
    else
        index = nn - 1;
    end

    if isstruct(x)
        x=x.Cost(index);
    end

    if isstruct(y)
        y=y.Cost(index);
    end

    dom=x<y;
end
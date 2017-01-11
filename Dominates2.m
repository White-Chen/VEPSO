function dom=Dominates2(x,y,numOfObj)

    if isstruct(x)
        x=x.Cost(numOfObj);
    end

    if isstruct(y)
        y=y.Cost(numOfObj);
    end

    dom=x<=y;
end
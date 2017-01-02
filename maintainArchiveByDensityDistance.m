function newRep = maintainArchiveByDensityDistance(rep,nRep)
    newRep = [];
    breakLine = 0;
    tempNumber = 0;
    removeNumber = 0;
    if numel(rep) <= nRep
        newRep = rep;
        return;
    end

    while(tempNumber <= nRep)
        breakLine = breakLine + 1;
        tempNumber = tempNumber + numel(rep([rep.numlies]==breakLine));
        removeNumber = tempNumber - nRep;
        newRep = [newRep
                  rep([rep.numlies]==breakLine)];
    end
    newRep([newRep.numlies]==breakLine) = [];
    newRep = [newRep
            removeFromLine(rep,breakLine,removeNumber)];
end

function repAtBreakLine = removeFromLine(rep,atLine,removeNumber)
    repIndexAtBreakLine    = [rep.numlies]==atLine;
    repAtBreakLine         = rep(repIndexAtBreakLine);
    while(removeNumber > 0)
        densityDistance = computeDensityDistance(repAtBreakLine);
        [~,tempIndex]= min(densityDistance);
        repAtBreakLine(tempIndex) = [];
        removeNumber = removeNumber - 1;
    end
end

function distance = computeDensityDistance(repAtBreakLine)
    global numOfObj;
    repNumberAtBreakLine = numel(repAtBreakLine);
    distance = zeros(1,repNumberAtBreakLine);
    objValueInDim = reshape([repAtBreakLine.Cost],[numOfObj,repNumberAtBreakLine]);
    maxValueInDim = repmat(max(objValueInDim,[],2),[1,repNumberAtBreakLine]);
    minValueInDim = repmat(min(objValueInDim,[],2),[1,repNumberAtBreakLine]);
    normalizedObjValueInDim = (objValueInDim - minValueInDim)./(maxValueInDim-minValueInDim);
    distanceVlaueInDim = zeros(size(objValueInDim));
    [~,objValueIndexInDim] = sort(objValueInDim,2,'ascend');
    for i = 1:numOfObj
        for j = 2:repNumberAtBreakLine-1
            distanceVlaueInDim(i,objValueIndexInDim(i,j)) = ...
                abs(normalizedObjValueInDim(i,objValueIndexInDim(i,j+1)) - normalizedObjValueInDim(i,objValueIndexInDim(i,j-1)));
        end
        distanceVlaueInDim(objValueIndexInDim(i,1)) = Inf;
        distanceVlaueInDim(objValueIndexInDim(i,repNumberAtBreakLine)) = Inf;
        distance = distance + distanceVlaueInDim(i,:);
    end
end
function rep = maintainArchiveByAverageDistance(rep,nRep)
    while(numel(rep) > nRep)
       [~,index] = min(computeAverageDistance(rep));
       rep(index) = [];
    end
end

function distance = computeAverageDistance(rep)
    global numOfObj;
    obj_1 = reshape([rep.Cost],[numOfObj,numel(rep)])';
    minObj = repmat(min(obj_1,[],1),numel(rep),1);
    maxObj = repmat(max(obj_1,[],1),numel(rep),1);
    obj_1 = (obj_1-minObj)./(maxObj-minObj);
    obj_2 = obj_1;
    distanceMatrix = pdist2(obj_1,obj_2);
    distanceMatrix(distanceMatrix == 0) = NaN;
    distance = mean(distanceMatrix,2,'omitnan');
end
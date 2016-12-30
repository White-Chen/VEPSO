function particle = initialSwarm(particle,numOfSwarm,initialRate)
    global nPop nVar VarMax VarMin CostFunction VarSize numOfObj;
    for nn = 1:numOfSwarm
        for i=(nn-1)*nPop+1:nn*nPop
            if rand() <= initialRate
                particle(i).Velocity=zeros(1,nVar);    
                tempPosition=unifrnd(0,1,VarSize);
                particle(i).Position = tempPosition .* (VarMax-VarMin) + VarMin;
                particle(i).Cost=CostFunction(particle(i).Position);   
                particle(i).Best.Position=particle(i).Position;
                particle(i).Best.Cost=particle(i).Cost;
            end
            particle(i).numOfObj = mod(numOfSwarm,numOfObj)+1;
            particle(i).subSwarmIndex = nn;
        end
    end
end
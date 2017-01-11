function offspring= parentCentricCrossover(particles,parentIndex,w)
    global nVar nPop VarMin VarMax;
    u = nPop + 2;
    offspring = particles(parentIndex);
    
    subSwarm = particles([particles.subSwarmIndex] == (particles(parentIndex).subSwarmIndex));
    subSwarm = [subSwarm;particles(parentIndex);headlessChickenOperator(1)]';
    if(nVar < u)
    	u = nVar;
    	subSwarm = subSwarm(randperm(u,nVar));
	end
	p_index = randperm(u,1);
    parent_p = subSwarm(p_index);
    subSwarm(p_index) = [];
    w = normrnd(0,w,1,u);
    w = repmat(w,nVar,1);
    
    g_mean_point = mean(reshape([subSwarm.Position],nVar,u-1)',1);
    d_direction_vector = parent_p.Position - g_mean_point;
    D_perpendicular_distance = zeros(1,u-1);
    e_orthonormal_bases = null(d_direction_vector);
    e_orthonormal_bases = e_orthonormal_bases(:,1:u-1);
    for i = 1:u-1
        D_perpendicular_distance(i) = norm([subSwarm(i).Position] - d_direction_vector);
    end
    D_mean_perpendicular_distance = mean(D_perpendicular_distance);
    offspring.Position = parent_p.Position...
                            + w(1)*norm(parent_p.Position)...
                            + [sum(D_mean_perpendicular_distance*w(:,2:u).*e_orthonormal_bases,2)]';
    offspring.Position = min(max(offspring.Position,VarMin),VarMax);
    clearvars p_index subSwarm g_mean_point...
        d_direction_vector D_perpendicular_distance...
        e_orthonormal_bases u D_mean_perpendicular_distance...
        w;
end

function randomParticles = headlessChickenOperator(number)
    global nVar VarMax VarMin VarSize;
    randomParticles = CreateEmptyParticle(number);
    for i = 1:number
            randomParticles(i).Velocity=zeros(1,nVar);    
            tempPosition=unifrnd(0,1,VarSize);
            randomParticles(i).Position = tempPosition .* (VarMax-VarMin) + VarMin;
    end
    
end
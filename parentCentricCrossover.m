function offspring= parentCentricCrossover(particles,parentIndex,gbest,w)
    global nVar nPop VarMin VarMax;
%     u = nPop + 2;
%     offspring = particles(parentIndex);
%     subSwarm = particles([particles.subSwarmIndex] == (particles(parentIndex).subSwarmIndex));
%     for i = 1:length(subSwarm)
%     	subSwarm(i).Position = subSwarm(i).Best.Position;
% 	end
% 	clear i;
%     subSwarm = [subSwarm;particles(parentIndex);headlessChickenOperator(1)]';
%     if(nVar < u)
%     	u = nVar;
%     	subSwarm = subSwarm(randperm(u,nVar));
% 	end
% 	p_index = randperm(u,1);
%     parent_p = subSwarm(p_index);
%     subSwarm(p_index) = [];
%     w = normrnd(0,w,1,u);
%     w = repmat(w,nVar,1);
%     g_mean_point = mean(reshape([subSwarm.Position],nVar,u-1)',1);
%     d_direction_vector = parent_p.Position - g_mean_point;
%     D_perpendicular_distance = zeros(1,u-1);
%     e_orthonormal_bases = null(d_direction_vector);
%     e_orthonormal_bases = e_orthonormal_bases(:,1:u-1);
%     for i = 1:u-1
%         D_perpendicular_distance(i) = norm([subSwarm(i).Position] - d_direction_vector);
%     end
%     D_mean_perpendicular_distance = mean(D_perpendicular_distance);
%     offspring.Position = parent_p.Position...
%                             + w(1)*norm(parent_p.Position)...
%                             + [sum(D_mean_perpendicular_distance*w(:,2:u).*e_orthonormal_bases,2)]';
%     offspring.Position = min(max(offspring.Position,VarMin),VarMax);
%     clearvars p_index subSwarm g_mean_point...
%         d_direction_vector D_perpendicular_distance...
%         e_orthonormal_bases u D_mean_perpendicular_distance...
%         w;
    positions = [particles(parentIndex).Position;
                gbest.Position;
                particles(parentIndex).Best.Position];
    offspring = particles(parentIndex);
    offspring.Position = PCX(positions,w,w);
    offspring.Position = min(max(offspring.Position,VarMin),VarMax);
end

function tempPosition = headlessChickenOperator()
    global VarMax VarMin VarSize;
    tempPosition=unifrnd(0,1,VarSize);
    tempPosition = tempPosition .* (VarMax-VarMin) + VarMin;
end

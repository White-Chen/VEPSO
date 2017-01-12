function offspring = PCX(positions,w1,w2)
    [u,nVar] = size(positions);
    if(u>nVar)
       u = nVar;
       positions = positions(randperm(u,nVar),:);
    end
    p_index = randperm(u,1);
    parent_p = positions(p_index,:);
    positions(p_index,:) = [];
    w1 = normrnd(0,w1^2,1);
    w2 = normrnd(0,w2^2,1,u-1);
    w2 = repmat(w2,nVar,1);
    
    g_mean_point = mean(positions,1);
    d_direction_vector = parent_p - g_mean_point;
    D_perpendicular_distance = zeros(1,u-1);
    e_orthonormal_bases = null(d_direction_vector);
    e_orthonormal_bases = e_orthonormal_bases(:,1:u-1);
    for i = 1:u-1
        D_perpendicular_distance(i) = norm(positions(i,:) - d_direction_vector);
    end
    D_mean_perpendicular_distance = mean(D_perpendicular_distance);
    offspring = parent_p...
                + w1*norm(parent_p)...
                + [sum(D_mean_perpendicular_distance*w2.*e_orthonormal_bases,2)]';
end
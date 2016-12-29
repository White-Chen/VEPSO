%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  MATLAB Code for                                                  %
%                                                                   %
%  Multi-Objective Particle Swarm Optimization (MOPSO)              %
%  Version 1.0 - Feb. 2011                                          %
%                                                                   %
%  According to:                                                    %
%  Carlos A. Coello Coello et al.,                                  %
%  "Handling Multiple Objectives with Particle Swarm Optimization," %
%  IEEE Transactions on Evolutionary Computation, Vol. 8, No. 3,    %
%  pp. 256-279, June 2004.                                          %
%                                                                   %
%  Developed Using MATLAB R2009b (Version 7.9)                      %
%                                                                   %
%  Programmed By: S. Mostapha Kalami Heris                          %
%                                                                   %
%         e-Mail: sm.kalami@gmail.com                               %
%                 kalami@ee.kntu.ac.ir                              %
%                                                                   %
%       Homepage: http://www.kalami.ir                              %
%                                                                   %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function pop=DetermineDomination(pop)   %确定支配关系函数，采用的方法是排除法

    npop=numel(pop); %the number of pop  numel方法返回的是pop也就是partical数组中元素的总数，所以元素总数是100
    
    for i=1:npop
        pop(i).Dominated=false;
        for j=1:i-1%（第一步为什么跳过去我终于知道了，原来这边的条件是i-1，所以说第一步j=1:0,肯定是不对的）
            if ~pop(j).Dominated  %表示当前没有比较过
                if Dominates(pop(i),pop(j)) 
                    pop(j).Dominated=true;
                elseif Dominates(pop(j),pop(i)) 
                    pop(i).Dominated=true;  
                    break;
                end
            end
        end
    end

end
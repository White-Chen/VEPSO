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

function pop=DetermineDomination(pop)   %ȷ��֧���ϵ���������õķ������ų���

    npop=numel(pop); %the number of pop  numel�������ص���popҲ����partical������Ԫ�ص�����������Ԫ��������100
    
    for i=1:npop
        pop(i).Dominated=false;
        for j=1:i-1%����һ��Ϊʲô����ȥ������֪���ˣ�ԭ����ߵ�������i-1������˵��һ��j=1:0,�϶��ǲ��Եģ�
            if ~pop(j).Dominated  %��ʾ��ǰû�бȽϹ�
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
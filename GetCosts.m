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

function costs=GetCosts(pop)

    nobj=numel(pop(1).Cost);  %ÿ������ Cost�ĸ���
    costs=reshape([pop.Cost],nobj,[]); %��pop.Costת���� nobj�е����飬[]��ʾ��������һ��
    
    %����
    % A(1).cost=[2,1];
    % A(2).cost=[3,4];
    % A(3).cost=[5,6];
    % A(4).cost=[7,8];
    % A.cost
    % 
    % ans =
    % 
    %      2     1
    % 
    % 
    % ans =
    % 
    %      3     4
    % 
    % 
    % ans =
    % 
    %      5     6
    % 
    % 
    % ans =
    % 
    %      7     8
    % 
    % costs=reshape([A.cost],2,[])
    % 
    % costs =
    % 
    %      2     3     5     7
    %      1     4     6     8

end
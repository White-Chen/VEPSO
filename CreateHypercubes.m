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

function G=CreateHypercubes(costs,ngrid,alpha)

    nobj=size(costs,1);
    
%    size(A,n)
%    �����size��������������������һ��n������1��2Ϊn��ֵ��
%    �� size�����ؾ��������������������r=size(A,1)����䷵�ص��Ǿ���A�������� c=size(A,2) ����䷵�ص��Ǿ���A������

    empty_grid.Lower=[];
    empty_grid.Upper=[];
    G=repmat(empty_grid,nobj,1);
    
    for j=1:nobj
        
        min_cj=min(costs(j,:));
        max_cj=max(costs(j,:));
        
        dcj=alpha*(max_cj-min_cj);
        
        min_cj=min_cj-dcj;
        max_cj=max_cj+dcj;
        
        %linspace��Matlab�е�һ��ָ����ڲ���x1,x2֮���N����ʸ��������x1��x2��N�ֱ�Ϊ��ʼֵ����ֵֹ��Ԫ�ظ���
        gx=linspace(min_cj,max_cj,ngrid-1);
        
        G(j).Lower=[-inf gx];%inf�������-inf������С
        G(j).Upper=[gx inf];
        
    end

end
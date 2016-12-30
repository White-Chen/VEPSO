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

clc;
clear;
close all;

%% Problem Definition
global dmethod itrCounter step window CostFunction nVar nPop VarMin VarMax numOfObj VarSize VelMax TestProblem dynamic MaxIt colors;
colors = {'bo','go','ro','co','mo','ko','bv','gv','rv','cv','mv','kv','bs','gs','rs','cs','ms','ks'};
TestProblem=33; 
dynamic = 1;
initialProblem();
dmethod = 'te';
step = 10;
window = 1000;
itrCounter = 0;
VarSize=[1 nVar]; 
VelMax=(VarMax-VarMin); 
nPop=20;
numOfSwarm = 6;
nRep=100;  
MaxIt=10000; 
phi1=2.05; 
phi2=2.05;
phi=phi1+phi2;  
chi=2/(phi-2+sqrt(phi^2-4*phi));
w=chi;              
wdamp=1;            
c1=chi*phi1;        
c2=chi*phi2;        
alpha=0.1;
nGrid=30;
beta=4;
gamma=2;
mu=0.1;
particle=CreateEmptyParticle(numOfSwarm*nPop);
gbest = CreateEmptyParticle(numOfObj);
[gbest.Cost] = deal(Inf*ones(1,numOfObj));
particle = initialSwarm(particle,numOfSwarm,2);
clear i nn ;
particle=DetermineDomination(particle); 
rep=GetNonDominatedParticles(particle); 
maintainArchiveByAverageDistance(rep,nRep);
for itrCounter=900:MaxIt
	for nn = 1:numOfSwarm
	    for i=(nn-1)*nPop+1:nn*nPop
	        rep_h=SelectLeader(rep,nn,numOfObj);
	        particle(i).Velocity=w*particle(i).Velocity ...
	                             +c1*rand*(particle(i).Best.Position - particle(i).Position) ...
	                             +c2*rand*(rep_h.Position -  particle(i).Position);
	        particle(i).Velocity=min(max(particle(i).Velocity,-VelMax),+VelMax);
	        particle(i).Position=particle(i).Position + particle(i).Velocity;
	        flag=(particle(i).Position<VarMin | particle(i).Position>VarMax);
	        particle(i).Velocity(flag)=-particle(i).Velocity(flag);
	        particle(i).Position=min(max(particle(i).Position,VarMin),VarMax);
	        particle(i).Cost=CostFunction(particle(i).Position);
	        pm=(1-(itrCounter-1)/(MaxIt-1))^(1/mu);
	        if rand<pm
	            NewSol = CreateEmptyParticle(1);
	            NewSol.numOfObj = particle(i).numOfObj;
	            NewSol.Position=Mutate(particle(i).Position,pm,VarMin,VarMax);
	            NewSol.Position=min(max(NewSol.Position,VarMin),VarMax);
	            NewSol.Cost=CostFunction(NewSol.Position);
	            if Dominates2(NewSol,particle(i),particle(i).numOfObj)
	                particle(i).Position=NewSol.Position;
	                particle(i).Cost=NewSol.Cost;

	            elseif Dominates2(particle(i),NewSol,particle(i).numOfObj)

	            else
	                if rand<0.5
	                    particle(i).Position=NewSol.Position;
	                    particle(i).Cost=NewSol.Cost;
	                end
	            end
	        end
	        if Dominates2(particle(i),particle(i).Best,particle(i).numOfObj)    
	            particle(i).Best.Position=particle(i).Position;
	            particle(i).Best.Cost=particle(i).Cost;
	        elseif ~Dominates2(particle(i).Best,particle(i),particle(i).numOfObj)
	            if rand<0.5
	                particle(i).Best.Position=particle(i).Position;
	                particle(i).Best.Cost=particle(i).Cost;
	            end
	        end
	    end
    end
    particle=DetermineDomination(particle);
    nd_particle=GetNonDominatedParticles(particle);
    rep=[rep
         nd_particle];
    rep=DetermineDomination(rep);
    rep=GetNonDominatedParticles(rep);
    maintainArchiveByAverageDistance(rep,nRep);
    disp(['Iteration ' num2str(itrCounter) ': Number of Repository Particles = ' num2str(numel(rep))]);
    w=w*wdamp;
    swarm2pic(rep);
    if mod(itrCounter,window) == 0 && dynamic == 1
        particle = initialSwarm(particle,numOfSwarm,0.3);
        [particle,rep] = reevalute(particle,rep);
    end
end
swarm2pic(rep,particle);
clearvars -except particle rep

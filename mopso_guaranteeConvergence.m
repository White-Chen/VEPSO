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
TestProblem=31; 
dynamic = 1;
initialProblem();
dmethod = 'te';
step = 200;
window = 5;
itrCounter = 0;
VarSize=[1 nVar]; 
VelMax=(VarMax-VarMin); 
nPop=20;
numOfSwarm = 8;
nRep=100;  
MaxIt=step*window; 
phi1=2.05; 
phi2=2.05;
phi=phi1+phi2;  
chi=2/(phi-2+sqrt(phi^2-4*phi));
w=chi;              
wdamp=1;            
c1=chi*phi1;        
c2=chi*phi2;
mu=0.1;
particle=CreateEmptyParticle(numOfSwarm*nPop);
gbest = CreateEmptyParticle(numOfSwarm);
[gbest.Cost] = deal(Inf*ones(1,numOfObj));
potential = ones(1,numOfSwarm);
successes=zeros(1,numOfSwarm);
failures=zeros(1,numOfSwarm);
epo_s =6;
epo_f = epo_s./3;
particle = initialSwarm(particle,numOfSwarm,2);
for nn = 1:numOfSwarm
    for i = 1:(nn-1)*nPop+1:nn*nPop
        if Dominates(particle(i),gbest(nn))
            particle(gbest(nn).particleIndex).isGbest = boolean(0);
            gbest(nn)=particle(i);
            gbest(nn).particleIndex = i;
            particle(gbest(nn).particleIndex).isGbest = boolean(1);
        elseif rand<0.5
            particle(gbest(nn).particleIndex).isGbest = boolean(0);
            gbest(nn)=particle(i);
            gbest(nn).particleIndex=i;
            particle(gbest(nn).particleIndex).isGbest = boolean(1);
        end
    end
end
clear i nn ;
particle=DetermineDomination(particle); 
% rep = nondom_sort(particle);
% rep = maintainArchiveByDensityDistance(rep,nRep);
rep=GetNonDominatedParticles(particle); 
history = CreateEmptyParticle(1);
for itrCounter=1:MaxIt
	for nn = 1:numOfSwarm
	    for i=(nn-1)*nPop+1:nn*nPop
            if particle(i).isGbest
                [rep_h,rep_h_index]=SelectLeader2(rep,nn,numOfSwarm);
                particle(i).Velocity=w*particle(i).Velocity ...
                                     +c1*rand(VarSize).*(particle(i).Best.Position - particle(i).Position) ...
                                     +c2*rand(VarSize).*(rep_h.Position -  particle(i).Position);
                particle(i).Velocity=min(max(particle(i).Velocity,-VelMax),+VelMax);
                particle(i).Position=particle(i).Position + particle(i).Velocity;
            else
                if successes(nn)>epo_s 
                    potential(nn) = 2*potential(nn);
                end
                if failures(nn)<epo_s
                    potential(nn) = 0.5*potential(nn);
                end
                history = particle(i);
                particle(i).Velocity=w*particle(i).Velocity ...
                                     + potential(nn).*(1-2*rand(VarSize));
                particle(i).Velocity=min(max(particle(i).Velocity,-VelMax),+VelMax);
                particle(i).Position=gbest(nn).Position + particle(i).Position + particle(i).Velocity;
            end
            flag=(particle(i).Position<VarMin | particle(i).Position>VarMax);
            particle(i).Velocity(flag)=-particle(i).Velocity(flag);
            particle(i).Position=min(max(particle(i).Position,VarMin),VarMax);
            particle(i).Cost=CostFunction(particle(i).Position);
            pm=(1-(itrCounter-1)/(MaxIt-1))^(1/mu);
            if ~particle(i).isGbest && rand<pm 
                NewSol = CreateEmptyParticle(1);
                NewSol.numOfObj = particle(i).numOfObj;
                NewSol.Position=Mutate(particle(i).Position,pm,VarMin,VarMax);
                NewSol.Position=min(max(NewSol.Position,VarMin),VarMax);
                NewSol.Cost=CostFunction(NewSol.Position);
                if Dominates2(NewSol,particle(i),particle(i).numOfObj)
                    particle(i).Position=NewSol.Position;
                    particle(i).Cost=NewSol.Cost;
                elseif rand<0.5
                        particle(i).Position=NewSol.Position;
                        particle(i).Cost=NewSol.Cost;
                end
            end
            
            if Dominates2(particle(i),particle(i).Best,particle(i).numOfObj)
                particle(i).Best.Position=particle(i).Position;
                particle(i).Best.Cost=particle(i).Cost;
            elseif rand<0.5
                    particle(i).Best.Position=particle(i).Position;
                    particle(i).Best.Cost=particle(i).Cost;
            end
            
	        if Dominates(particle(i),gbest(nn))
                if particle(i).isGbest  
                    successes(nn) = successes(nn)+1;
                    failures(nn)=0;
                end
                particle(gbest(nn).particleIndex).isGbest = boolean(0);
	            gbest(nn)=particle(i);
                gbest(nn).particleIndex = i;
                particle(gbest(nn).particleIndex).isGbest = boolean(1);
            elseif Dominates(gbest(nn),particle(i))
                if particle(i).isGbest  
                     failures(nn) = failures(nn)+1;
                     successes(nn)=0;
                end
            else
                if rand<0.5
                    if particle(i).isGbest  
                        successes(nn) = successes(nn)+1;
                        failures(nn)=0;
                    end
                    particle(gbest(nn).particleIndex).isGbest = boolean(0);
                    gbest(nn)=particle(i);
                    gbest(nn).particleIndex = i;
                    particle(gbest(nn).particleIndex).isGbest = boolean(1);
                else
                    if particle(i).isGbest  
                        failures(nn) = failures(nn)+1;
                        successes(nn)=0;
                    end
                end
            end
	    end
    end
    rep=[rep
         particle];
     particle=DetermineDomination(rep);
     rep=GetNonDominatedParticles(particle); 
%     rep = nondom_sort(rep);
%     rep = maintainArchiveByDensityDistance(rep,nRep);
    rep = maintainArchiveByAverageDistance(rep,nRep);
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

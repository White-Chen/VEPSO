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
TestProblem=6;  % Set to 1, 2, or 3 
   
switch TestProblem
    case 1
        CostFunction=@(x) MyCost1(x); 
        nVar=5;
        VarMin=-4*ones(1,nVar);
        VarMax=4*ones(1,nVar);
        numOfObj = 2;
    case 2
        CostFunction=@(x) MyCost2(x);
        nVar=3;
        VarMin=-5*ones(1,nVar);
        VarMax=5*ones(1,nVar);
        numOfObj = 2;
    case 3
        CostFunction=@(x) MyCost3(x); 
        nVar=2;
        VarMin=0;
        VarMax=1;
        numOfObj = 2;
    case 4
        CostFunction =@(x) MyCost4(x);
        nVar = 12;
        VarMin = 0;
        VarMax = 1;
        numOfObj = 3;
    case 5
        CostFunction =@(x) MyCost5(x);%zdt6
        nVar = 30;
        numOfObj = 2;
        VarMin=zeros(1,nVar);
        VarMax=ones(1,nVar);
    case 6
        CostFunction = @(x) MyCost6(x);%zdt3
        nVar = 30;
        VarMin=zeros(1,nVar);
        VarMax=ones(1,nVar);
        numOfObj = 2;
    case 7
        CostFunction=@(x) MyCost7(x); %zdt1
        nVar=30;
        VarMin=zeros(1,nVar);
        VarMax=ones(1,nVar);
        numOfObj = 2;

    case 8
        CostFunction=@(x) MyCost8(x); %zdt2
        nVar=30;
        VarMin=zeros(1,nVar);
        VarMax=ones(1,nVar);
        numOfObj = 2;
    case 9
        CostFunction=@(x) MyCost9(x); %zdt4
        nVar=10;
        VarMin=-5*ones(1,nVar);
        VarMax=5*ones(1,nVar);
        VarMin(1) = 0;
        VarMax(1) = 1;
        numOfObj = 2;
    case 10
        CostFunction=@(x) MyCost10(x); 
        nVar=2;
        VarMin=-5;
        VarMax=5;
        numOfObj = 2;
    case 12
        CostFunction=@(x) MyCost12(x); %cec09-1
        nVar=30;
        VarMin=-1*ones(1,nVar);
        VarMax=ones(1,nVar);
        VarMin(1) = 0;
        VarMax(1) = 1;
        numOfObj = 2;
    case 13
        CostFunction=@(x) MyCost13(x); %cec09-2
        nVar=30;
        VarMin=-1*ones(1,nVar);
        VarMax=ones(1,nVar);
        VarMin(1) = 0;
        VarMax(1) = 1;
        numOfObj = 2;
     case 14
        CostFunction=@(x) MyCost14(x); %cec09-3
        nVar=30;
        VarMin=zeros(1,nVar);
        VarMax=ones(1,nVar);
        numOfObj = 2;
     case 15
        CostFunction=@(x) MyCost15(x); %cec09-7
        nVar=30;
        VarMin=-1*ones(1,nVar);
        VarMax=ones(1,nVar);
        VarMin(1) = 0;
        VarMax(1) = 1;
        numOfObj = 2;
    case 16
        CostFunction=@(x) MyCost16(x); %cec09-4
    case 17
        CostFunction=@(x) MyCost17(x); %cec09-5
    case 18
        CostFunction=@(x) MyCost18(x); %cec09-6
    case 19
        CostFunction=@(x) MyCost19(x); %cec09-8
    case 20
        CostFunction=@(x) MyCost20(x); %cec09-9
    case 21
        CostFunction=@(x) MyCost21(x); %cec09-10
    case 22
        CostFunction=@(x) wfg(x, 2, 2, 4, 1); %wfg1
        nVar = 6;
        VarMin=zeros(1,nVar);
        VarMax=ones(1,nVar);
        numOfObj = 2;
        for i = 1:nVar
            VarMax(i) = VarMax(i).*(i*2);
        end
        clear i;       
    case 23
        CostFunction=@(x) wfg(x, 2, 2, 4, 2); %wfg2
        nVar = 6;
        VarMin=zeros(1,nVar);
        VarMax=ones(1,nVar);
        numOfObj = 2;
        for i = 1:nVar
            VarMax(i) = VarMax(i).*(i*2);
        end
        clear i;
    case 24
        CostFunction=@(x) wfg(x, 2, 2, 4, 3); %wfg3
        nVar = 6;
        VarMin=zeros(1,nVar);
        VarMax=ones(1,nVar);
        numOfObj = 2;
        for i = 1:nVar
            VarMax(i) = VarMax(i).*(i*2);
        end
        clear i;
    case 25
        CostFunction=@(x) wfg(x, 2, 2, 4, 4); %wfg4
        nVar = 6;
        VarMin=zeros(1,nVar);
        VarMax=ones(1,nVar);
        numOfObj = 2;
        for i = 1:nVar
            VarMax(i) = VarMax(i).*(i*2);
        end
        clear i;
    case 26
        CostFunction=@(x) wfg(x, 2, 2, 4, 5); %wfg5
        nVar = 6;
        VarMin=zeros(1,nVar);
        VarMax=ones(1,nVar);
        numOfObj = 2;
        for i = 1:nVar
            VarMax(i) = VarMax(i).*(i*2);
        end
        clear i;
    case 27
        CostFunction=@(x) wfg(x, 2, 2, 4, 6); %wfg6
        nVar = 6;
        VarMin=zeros(1,nVar);
        VarMax=ones(1,nVar);
        numOfObj = 2;
        for i = 1:nVar
            VarMax(i) = VarMax(i).*(i*2);
        end
        clear i;
    case 28
        CostFunction=@(x) wfg(x, 2, 2, 4, 7); %wfg7
        nVar = 6;
        VarMin=zeros(1,nVar);
        VarMax=ones(1,nVar);
        numOfObj = 2;
        for i = 1:nVar
            VarMax(i) = VarMax(i).*(i*2);
        end
        clear i;
    case 29
        CostFunction=@(x) wfg(x, 2, 2, 4, 8); %wfg8
        nVar = 6;
        VarMin=zeros(1,nVar);
        VarMax=ones(1,nVar);
        numOfObj = 2;
        for i = 1:nVar
            VarMax(i) = VarMax(i).*(i*2);
        end
        clear i;
    case 30
        CostFunction=@(x) wfg(x, 2, 2, 4, 9); %wfg9
        nVar = 6;
        VarMin=zeros(1,nVar);
        VarMax=ones(1,nVar);
        numOfObj = 2;
        for i = 1:nVar
            VarMax(i) = VarMax(i).*(i*2);
        end
        clear i;
    case 31
        CostFunction=@(x) wfg(x, 2, 2, 4, 10); %wfg10
        nVar = 6;
        VarMin=zeros(1,nVar);
        VarMax=ones(1,nVar);
        numOfObj = 2;
        for i = 1:nVar
            VarMax(i) = VarMax(i).*(i*2);
        end
        clear i;
end
VarSize=[1 nVar]; 
VelMax=(VarMax-VarMin); 
nPop=50;  
nRep=numOfObj*nPop;  
MaxIt=300; 
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
particle=CreateEmptyParticle(numOfObj*nPop);
gbest = CreateEmptyParticle(numOfObj);
[gbest.Cost] = deal(Inf*ones(1,numOfObj));
for nn = 1:numOfObj
	for i=(nn-1)*nPop+1:nn*nPop
	    particle(i).Velocity=zeros(1,nVar);    
	    tempPosition=unifrnd(0,1,VarSize);
    	particle(i).Position = tempPosition .* (VarMax-VarMin) + VarMin;
	    particle(i).Cost=CostFunction(particle(i).Position);   
	    particle(i).Best.Position=particle(i).Position;
	    particle(i).Best.Cost=particle(i).Cost;
	    particle(i).numOfObj = nn;
	end
end
clear i nn ;
particle=DetermineDomination(particle); 
rep=GetNonDominatedParticles(particle); 
rep_costs=GetCosts(rep);
G=CreateHypercubes(rep_costs,nGrid,alpha);
for i=1:numel(rep)
    [rep(i).GridIndex rep(i).GridSubIndex]=GetGridIndex(rep(i),G);
end
for it=1:MaxIt
	for nn = 1:numOfObj
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
	        pm=(1-(it-1)/(MaxIt-1))^(1/mu);
	        if rand<pm
	            NewSol = CreateEmptyParticle(1);
	            NewSol.numOfObj = nn;
	            NewSol.Position=Mutate(particle(i).Position,pm,VarMin,VarMax);
	            NewSol.Position=min(max(NewSol.Position,VarMin),VarMax);
	            NewSol.Cost=CostFunction(NewSol.Position);
	            if Dominates2(NewSol,particle(i),numOfObj,nn)
	                particle(i).Position=NewSol.Position;
	                particle(i).Cost=NewSol.Cost;

	            elseif Dominates2(particle(i),NewSol,numOfObj,nn)

	            else
	                if rand<0.5
	                    particle(i).Position=NewSol.Position;
	                    particle(i).Cost=NewSol.Cost;
	                end
	            end
	        end
	        if Dominates2(particle(i),particle(i).Best,numOfObj,nn)    
	            particle(i).Best.Position=particle(i).Position;
	            particle(i).Best.Cost=particle(i).Cost;
	        elseif ~Dominates2(particle(i).Best,particle(i),numOfObj,nn)
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
    for i=1:numel(rep)
        [rep(i).GridIndex rep(i).GridSubIndex]=GetGridIndex(rep(i),G);
    end
    if numel(rep)>nRep
        EXTRA=numel(rep)-nRep;
        rep=DeleteFromRep(rep,EXTRA,gamma);
        rep_costs=GetCosts(rep);
        G=CreateHypercubes(rep_costs,nGrid,alpha);
    end
    disp(['Iteration ' num2str(it) ': Number of Repository Particles = ' num2str(numel(rep))]);
    w=w*wdamp;
    rep_costs=GetCosts(rep);
    plot(rep_costs(1,:),rep_costs(2,:),'rx');
    drawnow;
end
costs=GetCosts(particle);
rep_costs=GetCosts(rep);
figure;
plot(costs(1,:),costs(2,:),'b.');
hold on;
plot(rep_costs(1,:),rep_costs(2,:),'rx');
legend('Main Population','Repository');

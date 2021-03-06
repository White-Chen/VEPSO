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

function dom=Dominates(x,y,varargin)
    global epsilon;
    if nargin < 3
	    if isstruct(x)
	        x=x.Cost;
            x=x*(1+epsilon);
	    end

	    if isstruct(y)
	        y=y.Cost;
            y=y*(1+epsilon);
	    end
	    
		dom=all(x<=y) && any(x<y);
	else 
	 	if isstruct(x)
	        x=x.Cost(varargin{1});
	    end

	    if isstruct(y)
	        y=y.Cost(varargin{1});
	    end
	    dom=x<y;
    end
end
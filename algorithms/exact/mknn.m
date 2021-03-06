% This file is a part of the MC2 toolbox developed by Y. Mohammand and T. Nishida.
%Please do not remove this comment
%
% Using this file is governed by the license of MC2 which you can find in LICENSE.md
% 
% You can find more information about this toolbox here:
% - Yasser Mohammad and Toyoaki Nishida, "MC2: An Integrated Toolbox for Change, Causality, 
%   and Motif Discovery", 29th International Conference on Industrial, Engineering & 
%   Other Applications of Applied Intelligent Systems (IEA/AIE) 2016, pp. 128 -- 141.
% - Yasser Mohammad and Toyoaki Nishida, "Data Mining for Social Robotics", Springer 2016.
%

function [locs,...
    dists,executionTime,means,stats]=mknn(x,lrange,lStep,normalization,innerOverlap ...
                        ,nMotifs,outerOverlap,R,fast)

   if length(lrange)<2
        lrange=[max(3,floor(0.9*lrange)),lrange];
    end
    if nargin<3
        lStep=max(10,ceil((lrange(2)-lrange(1))/10));   
    end
    if nargin<4
        normalization=3;
    end
    if nargin<5
        innerOverlap=0;
    end    
    if nargin<6
        nMotifs=10;
    end
    if nargin<7
        outerOverlap=0.0;
    end
    if nargin<8
        R=8;
    end
    if nargin<9
        fast=0;
    end    
   locs=cell(0,0);
   if nargout>2
    means=cell(0,0);
    stats=cell(0,0);
   end
   executionTime=0.0;
   success=true;
   dists=[];
   for L=lrange(1):lStep:lrange(2)
       if nargout>3
            [locst,...
                dist,t,meanst,statst]=mkn(x,L,innerOverlap,R,nMotifs,outerOverlap,normalization,fast);
       else
           [locst,...
                dist,t]=mkn(x,L,innerOverlap,R,nMotifs,outerOverlap,normalization,fast);
       end
        
    	executionTime=executionTime+t;
        success=s&&success;
        if nargout>2
            if(s)
                if(size(locst,1)>0)
                    %[locst,meanst,statst]=mkCombine(x,locst,L);
                    locs=[locs;locst];
                    dists=[dists;dist];
                    if nargout>3
                        means=[means,meanst];
                        stats=[stats,statst];
                    end                    
                else
                end
            end
        end
   end
   
end
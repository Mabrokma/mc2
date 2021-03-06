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

function [locs,means,stats,maxSmallDistance,execTime,errorLocs]=mkppRange(x,lrange,lStep,...
    nMotifs,recalcDists)
% a wrapper to mkpp to make it look as if taking the same parameters as
% mkpRange ... used internally by mkTest
  
   [locs,execTime,~,means,stats,maxSmallDistance]=mkpp(x,lrange,lStep...
       ,2,0,nMotifs,0,10,recalcDists);%,lStep,innerOverlap,R ...
    n=length(locs);
   L=length(x)-lrange(2);
   toremove=[];
   for i=1:n
       if locs{i}(1,2)>L || locs{i}(2,2)>L
           toremove=[toremove,i];
       end
   end
   if ~isempty(toremove)
       errorLocs=locs(toremove);
       locs(toremove)=[];
       means(toremove)=[];
       stats(toremove)=[];
   end
                        %,nMotifs,outerOverlap, Fast,recalcDists);
   %[locs,means,stats]=mkCombine(x,locs,lrange(1));
   
end
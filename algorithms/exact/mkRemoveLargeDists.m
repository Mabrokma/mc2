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

function [maxSmallDist,locs,dists]=mkRemoveLargeDists(locs,dists,minToTry,minPairsToKeep)
% calculates a meaningful threshold for distances based on the input set of
% distances.
%
% locs      either a cell of pair motifs or that it is a 2m*2
%            matrix where each two consecutive rows (starting with an odd number)
%           represent a motif.
% dists     m*1 vector representing distances between the m pair motifs
%
%
% minToTry  [optinoal] the minimum number of distances in dists under which we do not
%           try anything and return max(dists) as maxSmallDist while locs and dists
%           are kept without change
%
% minPairsToKeep [optional] the minimum number of pairs to keep. If the
%                first attempt to find maxSmallDist found some value that
%                is less than minPairsToKeep values in dists, then we just
%                set maxSmallDist to the minPairsToKeep value in an ordered
%                version of dists.
%
% Output:
% =======
% maxSmallDist  A threshold value for small distances calculated from
%               the data
% locs          Only pairs that have a distance <= maxSmallDist. They will
%               be ordered in ascending order of pair distances
% dists         The distances corresponding to locs.
%
%
%
% TODO add the ability to utilize the mean and variance of distances in the
% whole dataset or a fraction of it.
if ~exist('minToTry','var')
    minToTry=8;
end

if ~exist('minLocsToKeep','var')
    minLocsToKeep=1;
end
if(numel(dists)<minToTry)
    maxSmallDist=max(dists);
    return;
end
if(iscell(locs))
    locsM=cell2mat(locs);
end
lengths=double(locsM(:,2)-locsM(:,1)+1);
lengths=lengths(1:2:end);
[d,I]=sort(dists./lengths,'ascend');
try
c=kmeans(d,3,'emptyaction','singleton');
catch e
    nn=floor(numel(d)/3);
    c=ones(numel(d),1);
    try
        c(1:nn)=1;
        c(nn+1:2*nn)=2;
        c(2*nn+1:end)=3;
    catch e
    end
end
n=numel(c);
first=c(1);
smallDistLoc=n;
for i=1:n
    if c(i)~=first
        if i<=minLocsToKeep            
            smallDistLoc=minPairsToKeep;
        else
            smallDistLoc=i-1;
        end
        break;
    end
end
maxSmallDist=d(smallDistLoc);
if nargout>1
    locs=locs(I(1:smallDistLoc));
    dists=dists(I(1:smallDistLoc));
end
end
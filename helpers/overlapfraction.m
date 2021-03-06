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

function fraction=overlapfraction(begend1,begend2,fractionOfWhat)
% finds the overlapping fraction between two motif stems (internal
% function)
%
% For more information please consult the following publications: 
% ===============================================================
% Yasser Mohammad and Toyoaki Nishida, CPMD: A Matlab Toolbox for Change
% Point and Constrained Motif Discovery, IEA/AIE 2012 
%
% Please cite the above mentioned publications if you are using this
% routine for your research.
%
%
% fractionOfWhat    1 == first subsequence length
%                   2 == second subsequence length
%                   0 == min (first , second) subsequence length
%                   3 == max (first , second) subsequence length
%                   4 == subsequence length from the very beginning of
%                   eithr of the two motifs to the very end of either of
%                   them
                     
    if nargin<3
        fractionOfWhat=4;
    end
    if begend1(1)>begend2(2) || begend2(1)>begend1(2)
        fraction =0;
        return;
    end
    if (begend1(1)>=begend2(1) && begend1(2)<= begend2(2)) || ...
        (begend2(1)>=begend1(1) && begend2(2)<= begend1(2))
        fraction =1;
        return;
    end
    fraction=(min([begend1(2),begend2(2)])-max([begend1(1),begend2(1)])+1);
    switch(fractionOfWhat)        
        case 1
            fraction=fraction./(begend1(2)-begend1(1));
        case 2
            fraction=fraction./(begend2(2)-begend2(1));
        case 0
            fraction=fraction./min([(begnd2(2)-begend2(1)),(begnd2(1)-begend1(1))]);
        case 3
            fraction=fraction./max([(begnd2(2)-begend2(1)),(begnd2(1)-begend1(1))]);    
        case 4    
            fraction=fraction...
            ./(max([begend1(2),begend2(2)])-min([begend1(1),begend2(1)])+1);        
    end
end
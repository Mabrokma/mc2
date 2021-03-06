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


figure;
Ns=2;
Nt=1;
useFixedAs=1;
As=zeros(4*Ns,Ns);
As(:,:)=[0.9,0.1;0.1,0.9;  
           0.5,0.5;0.5,0.5;
           0.5,0.5;0.1,0.9;
           0.1,0.9;0.1,0.9
           ];
mu=[10,-10];
p0=rand(Ns,1);
p0=p0./sum(p0);

for j=1:4

if useFixedAs
    A=As((j-1)*2+1:2*j,:);
else
    A=rand(Ns,Ns);
    for i=1:Ns
        A(i,:)=A(i,:)./(sum(A(i,:)));
    end
end


sigma=zeros(Ns,Nt,Nt);
letters={'(a)','(b)','(c)','(d)'}
for i=1:Ns
    sigma(:,:,i)=2*eye(Nt);
end

subplot(2,2,j); 
plot(generateHMM(A,p0,mu,sigma,100),'LineWidth',2);
str=sprintf('%s $A  = \\left[ {\\begin{array}{*{20}{c}}{%3.2f}&%3.2f \\\\ %3.2f&{%3.2f}\\end{array}} \\right]$',letters{j},A(1,1),A(1,2),A(2,1),A(2,2));
fprintf(str);
title(str,'interpreter','latex','FontSize',20);
end
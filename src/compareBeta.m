function [] = compareBeta(beta1,beta2,label1,label2, g)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here


allVals = vertcat(beta1, beta2);
lb = floor(min(allVals));
ub = ceil(max(allVals));

hold on 
plot(beta1, beta2, 'o','linewidth', g.LW)
plot([lb,ub],[lb,ub],'--','color','k', 'linewidth', g.LW);
% lsline
hold off 

xlim([lb,ub])
ylim([lb,ub])
axis square;

xlabel(label1, 'fontsize', g.FS)
ylabel(label2, 'fontsize', g.FS)

set(gca,'fontsize', g.FS - 4)

end


function [] = compareBeta(beta_x, beta_y, label_x, label_y, g, scaleAxis)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
plot(beta_x, beta_y, 'o','linewidth', g.LW)
title('Feature weight reconstruction')
xlabel(label_x, 'fontsize', g.FS)
ylabel(label_y, 'fontsize', g.FS)
set(gca,'fontsize', g.FS - 4)

if scaleAxis
    allVals = vertcat(beta_x, beta_y);
    lb = floor(min(allVals));
    ub = ceil(max(allVals));
    
    hold on 
    plot([lb,ub],[lb,ub],'--','color','k', 'linewidth', g.LW);
%     lsline
    hold off
    
    xlim([lb,ub]); ylim([lb,ub])
    axis square;
else
    range_scale_factor = 1.1; 
    lb_x = min(beta_x); ub_x = max(beta_x);
    symbound_x = max(abs(ub_x),abs(lb_x)) * range_scale_factor;
    lb_y = min(beta_y); ub_y = max(beta_y);
    symbound_y = max(abs(ub_y),abs(lb_y)) * range_scale_factor;
    
    xlim([-symbound_x,symbound_x]); ylim([-symbound_y,symbound_y]);

end

end


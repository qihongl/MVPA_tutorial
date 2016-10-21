clear variables; 
seed = 1;  rng(seed);

m = 500; 
mn_ratio = .1 :.1: 2;
sim_size = 10;
accuracy.rls = zeros(length(mn_ratio),1);
accuracy.log = zeros(length(mn_ratio),1);
for i = 1 : length(mn_ratio)
    for s = 1 : sim_size
        acc = classification_rls_log(mn_ratio(i), false);
        accuracy.rls(i) = accuracy.rls(i) + acc.rls;
        accuracy.log(i) = accuracy.log(i) + acc.log;
    end
end
accuracy.rls = accuracy.rls / sim_size; 
accuracy.log = accuracy.log / sim_size; 

%% 
g.LW = 2; 
g.FS = 20; 
hold on 
plot(mn_ratio * m, accuracy.rls, 'linewidth', g.LW);
plot(mn_ratio * m, accuracy.log, 'linewidth', g.LW);
plot([min(mn_ratio * m), max(mn_ratio * m)], [.5, .5], '--k')
hold off
legend({'RLS', 'Logistic', 'Chance'}, 'location', 'NE')
title_text = sprintf('Compare RLS and LOGISCTIC\n number of training examples = %d', m);
title(title_text);
ylabel('Classification accuracy')
xlabel('Number of features')
set(gca,'fontsize', g.FS - 4)
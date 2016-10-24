clear variables; 
seed = 1;  rng(seed);

n = 500; 
mn_ratio = .2 :.2: 4;
sim_size = 10;
accuracy.rls = zeros(length(mn_ratio),1);
accuracy.log = zeros(length(mn_ratio),1);
for i = 1 : length(mn_ratio)
    fprintf('%d ',i)
    for s = 1 : sim_size
        m = round(n * mn_ratio(i));
        acc = classification_rls_log(m, n, false);
        accuracy.rls(i) = accuracy.rls(i) + acc.rls;
        accuracy.log(i) = accuracy.log(i) + acc.log;
    end
end
fprintf('\n')
accuracy.rls = accuracy.rls / sim_size; 
accuracy.log = accuracy.log / sim_size; 

%% 
g.LW = 2; 
g.FS = 20; 
hold on 
plot(mn_ratio * n, accuracy.rls, 'linewidth', g.LW);
plot(mn_ratio * n, accuracy.log, 'linewidth', g.LW);
plot([min(mn_ratio * n), max(mn_ratio * n)], [.5, .5], '--k')
hold off
legend({'RLS', 'Logistic', 'Chance'}, 'location', 'NE')
title_text = sprintf('Compare RLS and LOGISCTIC\n number of training examples = %d', n);
title(title_text);
ylabel('Classification accuracy')
xlabel('Number of features')
set(gca,'fontsize', g.FS - 4)
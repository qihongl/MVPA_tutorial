%% classification with RLS linear prediction
clear variables; clf; 
seed = 1;  rng(seed); 
% stimuli by voxel
m = 1000;        % num stimuli
n = 200;        % num voxels
testset_size = 100; 
noise = randn(m,1);

%% generate X, beta and y 
X = randn(m,n);
beta.truth = randn(n,1);
% beta.truth = generateBeta(numNonZeroFeatures, n, 1);
y = sign(X * beta.truth);

% hold out test set 
idx_test = false(m,1); 
idx_test(randsample(m,testset_size)) = true;
y_test = y(idx_test);
X_test = X(idx_test,:);
y_train = y(~idx_test);
X_train = X(~idx_test,:);

%% compute RLS prediction 
beta.rls = inv(X_train' * X_train) * X_train' * y_train; 
% beta.rls = X_train \ y_train; 
y_hat = sign(X_test * beta.rls);

%% plot the data 
% re-order the rows 
accuracy = sum(y_hat == y_test) / length(y_test); 
idx_one = y_test == 1;
y_test = vertcat(y_test(~idx_one),y_test(idx_one));
y_hat = vertcat(y_hat(~idx_one),y_hat(idx_one));

% 
g.FS = 20; 
g.LW = 4;
hold on 
plot(y_test,'linewidth', g.LW)
plot(y_hat, 'o','linewidth', g.LW/2)
hold off 
legend({'Truth', 'RLS prediction'}, 'location', 'SE')
title_test = sprintf('RLS classification: accuracy = %.2f', accuracy);
title(title_test);
ylabel('Response')
xlabel('Training examples')
set(gca,'fontsize', g.FS - 4)